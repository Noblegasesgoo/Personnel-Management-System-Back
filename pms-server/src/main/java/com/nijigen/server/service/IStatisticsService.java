package com.nijigen.server.service;

import com.nijigen.server.pojo.VO.ResultPageVO;

import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 统计服务提供接口
 */

public interface IStatisticsService {

    /**
     * 新聘员工报表
     * @param currentPage
     * @param pageSize
     * @param deptName
     * @param beginDateScope
     * @return ResultPageVO
     */
    public ResultPageVO getNewEmployeeReportForm(Integer currentPage, Integer pageSize, String deptName, LocalDate[] beginDateScope);

    /**
     * 离职员工报表
     * @param currentPage
     * @param pageSize
     * @param deptName
     * @param beginDateScope
     * @return ResultPageVO
     */
    public ResultPageVO getLeaveEmployeeReportForm(Integer currentPage, Integer pageSize, String deptName, LocalDate[] beginDateScope);
}
