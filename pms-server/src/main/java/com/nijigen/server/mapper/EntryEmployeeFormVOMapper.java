package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nijigen.server.pojo.VO.EntryEmployeeFormVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

/**
 * @author zhaolimin
 * @date 2021/10/27
 * @apiNote 入职员工统计mapper
 */

@Repository
public interface EntryEmployeeFormVOMapper extends BaseMapper<EntryEmployeeFormVO> {


     /**
     * 新聘员工报表
     * @param currentPage
     * @param pageSize
     * @param deptId
     * @param beginDateScope
     * @return ResultVO
     */
    IPage<EntryEmployeeFormVO> selectNewEmployeeReportForm(Page<EntryEmployeeFormVO> entryEmployeeFormVOPage, @Param("deptName") String deptName, @Param("beginDateScope") LocalDate[] beginDateScope);
}
