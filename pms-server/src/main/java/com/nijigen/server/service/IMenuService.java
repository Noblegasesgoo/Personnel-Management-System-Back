package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Menu;
import com.nijigen.server.pojo.VO.ResultVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IMenuService extends IService<Menu> {

    /**
     * 根据用户id获取当前用户的角色对应的菜单信息。
     * 用户id从spring security中的全局对象中存取。
     * @return ResultVO
     */
    public ResultVO getMenusByUserId();

    /**
     * 根据角色获取菜单列表。
     * @return List<Menu>
     */
    public List<Menu> getMenusWithRole();

    /**
     * 获取所有菜单
     * @return ResultVO
     */
    public ResultVO getAllMenus();
}
