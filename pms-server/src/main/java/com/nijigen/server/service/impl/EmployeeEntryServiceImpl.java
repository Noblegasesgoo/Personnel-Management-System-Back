package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.EmployeeEntryMapper;
import com.nijigen.server.mapper.EmployeeMapper;
import com.nijigen.server.pojo.Employee;
import com.nijigen.server.pojo.EmployeeEntry;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IEmployeeEntryService;
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
 * @since 2021-10-27
 */
@Service
public class EmployeeEntryServiceImpl extends ServiceImpl<EmployeeEntryMapper, EmployeeEntry> implements IEmployeeEntryService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private EmployeeEntryMapper employeeEntryMapper;


    /**
     * 查询入职表信息
     *
     * @return ResultVO
     */
    @Override
    public ResultVO getAllEmployeeEntryInfo() {
        List<EmployeeEntry> employeeEntries = employeeEntryMapper.selectAllEmployeeEntryInfo();
        return ResultVO.success("查询入职表信息成功！", employeeEntries);
    }

    /**
     * 同意入职信息
     *
     * @param employeeEntry
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO agreeEmployeeEntryInfo(EmployeeEntry employeeEntry) {

        // 将员工表的该入职员工的状态修改为在职
        Employee employee = employeeMapper.selectById(employeeEntry.getEmployeeId());

        employee.setWorkState("在职");
        employee.setConversionDate(LocalDate.now());
        employeeMapper.updateById(employee);

        // 从入职申请表逻辑删除该条申请
        employeeEntry.setEnabled(false);
        if (employeeEntryMapper.updateById(employeeEntry) > 0) {

            return ResultVO.success("同意入职成功！", employeeEntry);
        } else {

            return ResultVO.error("数据库繁忙，请重试！", employeeEntry);
        }
    }

    /**
     * 入职描述修改
     * @param employeeEntry
     * @return ResultVO
     */
    @Override
    public ResultVO updateEmployeeEntryInfo(EmployeeEntry employeeEntry) {

        if (employeeEntryMapper.updateById(employeeEntry) > 0) {

            return ResultVO.success("修改离职信息成功！", employeeEntry);
        } else {

            return ResultVO.error("数据库繁忙！请稍后再试", employeeEntry);
        }

    }

    /**
     * 取消入职申请
     * @param eeId
     * @return ResultVO
     */
    @Override
    public ResultVO deleteApplication(Integer eeId) {

        if (employeeEntryMapper.deleteById(eeId) > 0) {

            return ResultVO.success("撤销该入职信息成功！");
        } else {

            return ResultVO.error("数据库繁忙！请稍后再试");
        }
    }

}
