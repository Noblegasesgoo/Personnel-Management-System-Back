package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.EmployeeEntryMapper;
import com.nijigen.server.mapper.EmployeeLeaveMapper;
import com.nijigen.server.mapper.EmployeeMapper;
import com.nijigen.server.pojo.Employee;
import com.nijigen.server.pojo.EmployeeEntry;
import com.nijigen.server.pojo.EmployeeLeave;
import com.nijigen.server.pojo.VO.ResultPageVO;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-25
 */
@Service
public class EmployeeServiceImpl extends ServiceImpl<EmployeeMapper, Employee> implements IEmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private EmployeeLeaveMapper employeeLeaveMapper;

    @Autowired
    private EmployeeEntryMapper employeeEntryMapper;

    /**
     * 分页查询所有员工
     *
     * @param currentPage
     * @param pageSize
     * @param employee       用来条件搜索
     * @param beginDateScope 入职日期范围
     * @return ResultPageVO
     */
    @Override
    public ResultPageVO getAllEmpInfo(Integer currentPage, Integer pageSize, Employee employee, LocalDate[] beginDateScope) {

        // 开启分页
        Page<Employee> employeePage = new Page<>(currentPage, pageSize);

        IPage<Employee> allEmpInfo = employeeMapper.getAllEmpInfo(employeePage, employee, beginDateScope);

        return new ResultPageVO(allEmpInfo.getTotal(), allEmpInfo.getRecords());
    }

    /**
     * 员工入职
     * @param employee
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO addEmployee(Employee employee) {

        // 由于人们都会有重名的情况出现，所以我们这里不管以前被修改过在职状态的员工，我们查询一下身份证这种百分百不可能重复的内容。
        if (employeeMapper.selectOne(new QueryWrapper<Employee>().eq("id_card", employee.getIdCard())) != null) {
            return ResultVO.error("添加员工失败!身份证重复！", employee);
        }

        // 设置新员工状态以及入职日期
        employee.setWorkState("实习");
        employee.setBeginDate(LocalDate.now());

        // 设置新员工的id
        List<Employee> employees = employeeMapper.selectList(new QueryWrapper<Employee>());
        employee.setId(employees.get(employees.size()-1).getId());

        if (employeeMapper.insert(employee) > 0) {

            // 再向入职管理表中添加一条数据
            // 这里只设置申请提交时间，不设置离职时间
            if (employeeEntryMapper.insert(new EmployeeEntry(null,employee.getId(),LocalDate.now(),null,null,true,null)) > 0) {

                return ResultVO.success("添加员工申请提交成功!", employee);
            } else {

                return ResultVO.error("添加员工申请提交失败!请稍后再试", employee);
            }

        } else {
            return ResultVO.error("添加员工申请提交失败!请稍后再试", employee);
        }
    }

    /**
     * 开除员工
     * @param employee
     * @return ResultVO
     */
    @Override
    public ResultVO deleteEmployee(Employee employee) {

        EmployeeLeave employeeLeave = new EmployeeLeave(null, employee.getId(), LocalDate.now(), null, null, true, null);

        if (employeeLeaveMapper.insert(employeeLeave) > 0) {

            return ResultVO.success("离职请求创建成功！");
        } else {

            return ResultVO.error("离职请求创建失败！请重试");
        }

    }

    /**
     * 查询员工信息（导出用），可以传入员工id实现单条查询
     * @param emp_id
     * @return ResultVO
     */
    @Override
    public List<Employee> getEmployee(Integer emp_id) {

        return employeeMapper.selectEmployee(emp_id);
    }

}
