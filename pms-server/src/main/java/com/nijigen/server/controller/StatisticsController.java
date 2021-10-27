package com.nijigen.server.controller;

import com.nijigen.server.pojo.VO.ResultPageVO;
import com.nijigen.server.service.IStatisticsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 统计报表api
 */

@RestController
@RequestMapping("/statistics")
@Api(value = "提供报表接口", tags = "报表管理")
public class StatisticsController {

    @Autowired
    private IStatisticsService statisticsService;


    @ApiOperation(value = "新聘员工报表")
    @GetMapping("/entry-form")
    public ResultPageVO getNewEmployeeReportForm(@RequestParam(defaultValue = "1") Integer currentPage,
                                                 @RequestParam(defaultValue = "5") Integer pageSize,
                                                 String deptName,
                                                 LocalDate[] beginDateScope) {

        return statisticsService.getNewEmployeeReportForm(currentPage, pageSize, deptName, beginDateScope);
    }

    @ApiOperation(value = "离职员工报表")
    @GetMapping("/leave-form")
    public ResultPageVO getLeaveEmployeeReportForm(@RequestParam(defaultValue = "1") Integer currentPage,
                                                 @RequestParam(defaultValue = "5") Integer pageSize,
                                                   String deptName,
                                                 LocalDate[] leaveDateScope) {

        return statisticsService.getLeaveEmployeeReportForm(currentPage, pageSize, deptName, leaveDateScope);
    }
}
