package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.MenuRole;
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
public interface MenuRoleMapper extends BaseMapper<MenuRole> {


    /**
     * 批量更新权限
     * @param roleId
     * @param menuIds
     * @return 受影响的行数
     */
    Integer insertRecord(@Param("roleId") Integer roleId, @Param("menuIds") Integer[] menuIds);
}
