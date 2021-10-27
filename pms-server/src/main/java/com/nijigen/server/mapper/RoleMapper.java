package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.Role;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */

@Repository
public interface RoleMapper extends BaseMapper<Role> {

    /**
     * 根据用户id查询当前用户角色信息
     * @param userId
     * @return List<Role>
     */
    List<Role> selectRolesByUserId(Integer userId);

}
