package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nijigen.server.pojo.VO.LeaveEmployeeFormVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 离职员工统计mapper
 */

@Repository
public interface LeaveEmployeeFormVOMapper extends BaseMapper<LeaveEmployeeFormVO> {


    /**
     * 离职员工报表
     * @param currentPage
     * @param pageSize
     * @param deptId
     * @param leaveDateScope
     * @return ResultPageVO
     */
    IPage<LeaveEmployeeFormVO> selectLeaveEmployeeReportForm(Page<LeaveEmployeeFormVO> leaveEmployeeFormVOPage, @Param("deptName") String deptName, @Param("leaveDateScope") LocalDate[] leaveDateScope);
}
