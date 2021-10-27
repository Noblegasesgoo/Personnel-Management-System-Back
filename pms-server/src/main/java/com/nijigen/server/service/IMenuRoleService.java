package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.MenuRole;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IMenuRoleService extends IService<MenuRole> {

    /**
     * 根据角色id查询菜单id
     * @param roleId
     * @return ResultVO
     */
    public ResultVO getMenuIdByRoleId(Integer roleId);

    /**
     * 更新角色菜单
     * @param roleId
     * @param menuIds
     * @return ResultVO
     */
    public ResultVO updateMenuRole(Integer roleId, Integer[] menuIds);
}
