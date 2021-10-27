package com.nijigen.server.service;

import com.nijigen.server.pojo.EmployeeLeave;
import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-26
 */
public interface IEmployeeLeaveService extends IService<EmployeeLeave> {

    /**
     * 获取离职员工表信息
     * @return ResultVO
     */
    public ResultVO getAllEmployeeLeaveInfo();

    /**
     * 同意离职信息
     * @param employeeLeave
     * @return ResultVO
     */
    public ResultVO agreeEmployeeLeaveInfo(EmployeeLeave employeeLeave);

    /**
     * 离职描述修改
     * @param employeeLeave
     * @return ResultVO
     */
    public ResultVO updateEmployeeLeaveInfo(EmployeeLeave employeeLeave);

    /**
     * 取消离职申请
     * @param elId
     * @return ResultVO
     */
    public ResultVO deleteApplication(Integer elId);
}
