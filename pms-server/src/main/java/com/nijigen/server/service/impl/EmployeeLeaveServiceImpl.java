package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.EmployeeLeaveMapper;
import com.nijigen.server.mapper.EmployeeMapper;
import com.nijigen.server.pojo.Employee;
import com.nijigen.server.pojo.EmployeeLeave;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IEmployeeLeaveService;
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
 * @since 2021-10-26
 */
@Service
public class EmployeeLeaveServiceImpl extends ServiceImpl<EmployeeLeaveMapper, EmployeeLeave> implements IEmployeeLeaveService {

    @Autowired
    private EmployeeLeaveMapper employeeLeaveMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 获取离职员工表信息
     * @return ResultVO
     */
    @Override
    public ResultVO getAllEmployeeLeaveInfo() {


        List<EmployeeLeave> employeeLeaves = employeeLeaveMapper.selectAllEmployeeLeaveInfo();

        if (employeeLeaves.size() > 0) {

            return ResultVO.success("查询离职员工信息成功！", employeeLeaves);
        } else {

            return ResultVO.error("当前无离职员工信息");
        }
    }

    /**
     * 同意离职信息
     * @param employeeLeave
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO agreeEmployeeLeaveInfo(EmployeeLeave employeeLeave) {

        // 将员工表的该离职员工的状态修改为离职
        Employee employee = employeeMapper.selectById(employeeLeave.getEmployeeId());
        employee.setWorkState("离职");
        employee.setLeaveDate(LocalDate.now());
        employeeMapper.updateById(employee);

        // 将这个员工信息从离职信息表中逻辑删除这条信息
        employeeLeave.setEnabled(false);
        if (employeeLeaveMapper.updateById(employeeLeave) > 0) {

            return ResultVO.success("同意离职成功！", employeeLeave);
        } else {

            return ResultVO.error("数据库繁忙，请重试！", employeeLeave);
        }

    }

    /**
     * 离职描述修改
     * @param employeeLeave
     * @return ResultVO
     */
    @Override
    public ResultVO updateEmployeeLeaveInfo(EmployeeLeave employeeLeave) {

        if (employeeLeaveMapper.updateById(employeeLeave) > 0) {

            return ResultVO.success("修改离职信息成功！", employeeLeave);
        } else {

            return ResultVO.error("数据库繁忙！请稍后再试", employeeLeave);
        }

    }

    /**
     * 取消离职申请
     * @param elId
     * @return ResultVO
     */
    @Override
    public ResultVO deleteApplication(Integer elId) {

        if (employeeLeaveMapper.deleteById(elId) > 0) {

            return ResultVO.success("撤销该离职信息成功！");
        } else {

            return ResultVO.error("数据库繁忙！请稍后再试");
        }
    }

}
