package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.UserRole;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */

@Repository
public interface UserRoleMapper extends BaseMapper<UserRole> {

    /**
     * 通过id更新用户角色信息
     * @param userId
     * @param roleIds 暂时性只接受一个，换成数组形式是为了方便扩展
     * @return ResultVO
     */
    Integer addUserRole(@Param("userId") Integer userId, @Param("roleIds") Integer[] roleIds);
}
