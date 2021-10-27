package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.EmployeeEntry;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-27
 */
public interface IEmployeeEntryService extends IService<EmployeeEntry> {


    /**
     * 查询入职表信息
     * @return ResultVO
     */
    public ResultVO getAllEmployeeEntryInfo();

    /**
     * 同意入职信息
     * @param employeeEntry
     * @return ResultVO
     */
    public ResultVO agreeEmployeeEntryInfo(EmployeeEntry employeeEntry);

    /**
     * 入职描述修改
     * @param employeeEntry
     * @return ResultVO
     */
    public ResultVO updateEmployeeEntryInfo(EmployeeEntry employeeEntry);

    /**
     * 取消入职申请
     * @param eeId
     * @return ResultVO
     */
    public ResultVO deleteApplication(Integer eeId);

}
