package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.Menu;
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
public interface MenuMapper extends BaseMapper<Menu> {


    /**
     * 根据用户id获取当前用户的角色对应的菜单信息。
     * @param userId
     * @return List<Menu>
     */
    List<Menu> selectMenusByUserId(Integer userId);

    /**
     * 根据角色获取当前角色可使用菜单。
     * @return List<Menu>
     */
    List<Menu> selectMenusWithRole();

    /**
     * 获取所有菜单
     * @return List<Menu>
     */
    List<Menu> selectAllMenus();

}
