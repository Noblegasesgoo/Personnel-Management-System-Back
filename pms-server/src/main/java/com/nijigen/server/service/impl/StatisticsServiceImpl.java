package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nijigen.server.mapper.EntryEmployeeFormVOMapper;
import com.nijigen.server.mapper.LeaveEmployeeFormVOMapper;
import com.nijigen.server.pojo.VO.EntryEmployeeFormVO;
import com.nijigen.server.pojo.VO.LeaveEmployeeFormVO;
import com.nijigen.server.pojo.VO.ResultPageVO;
import com.nijigen.server.service.IStatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 统计服务实现类
 */

@Service
public class StatisticsServiceImpl implements IStatisticsService {

    @Autowired
    private EntryEmployeeFormVOMapper entryEmployeeFormVOMapper;

    @Autowired
    private LeaveEmployeeFormVOMapper leaveEmployeeFormVOMapper;


    /**
     * 新聘员工报表
     * @param currentPage
     * @param pageSize
     * @param deptName
     * @param beginDateScope
     * @return ResultVO
     */
    @Override
    public ResultPageVO getNewEmployeeReportForm(Integer currentPage, Integer pageSize, String deptName, LocalDate[] beginDateScope) {

        // 开启分页
        Page<EntryEmployeeFormVO> entryEmployeeFormVOPage = new Page<>(currentPage, pageSize);

        IPage<EntryEmployeeFormVO> entryEmployeeFormVOIPage = entryEmployeeFormVOMapper.selectNewEmployeeReportForm(entryEmployeeFormVOPage, deptName, beginDateScope);

        return new ResultPageVO(entryEmployeeFormVOIPage.getTotal(), entryEmployeeFormVOIPage.getRecords());
    }

    /**
     * 离职员工报表
     * @param currentPage
     * @param pageSize
     * @param deptName
     * @param leaveDateScope
     * @return
     */
    @Override
    public ResultPageVO getLeaveEmployeeReportForm(Integer currentPage, Integer pageSize, String deptName, LocalDate[] leaveDateScope) {

        // 开启分页
        Page<LeaveEmployeeFormVO> leaveEmployeeFormVOPage = new Page<>(currentPage, pageSize);

        IPage<LeaveEmployeeFormVO> leaveEmployeeFormVOIPage = leaveEmployeeFormVOMapper.selectLeaveEmployeeReportForm(leaveEmployeeFormVOPage, deptName, leaveDateScope);

        return new ResultPageVO(leaveEmployeeFormVOIPage.getTotal(), leaveEmployeeFormVOIPage.getRecords());
    }
}
