package com.nijigen.server.mapper;

import com.nijigen.server.pojo.EmployeeLeave;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-26
 */

@Repository
public interface EmployeeLeaveMapper extends BaseMapper<EmployeeLeave> {

    /**
     * 获取离职员工表信息
     * @return List<EmployeeLeave>
     */
    List<EmployeeLeave> selectAllEmployeeLeaveInfo();
}
