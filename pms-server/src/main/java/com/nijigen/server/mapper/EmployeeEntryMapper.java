package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.EmployeeEntry;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-27
 */

@Repository
public interface EmployeeEntryMapper extends BaseMapper<EmployeeEntry> {

    /**
     * 查询入职表信息
     * @return List<EmployeeEntry>
     */
    List<EmployeeEntry> selectAllEmployeeEntryInfo();

}
