package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.MenuRoleMapper;
import com.nijigen.server.pojo.MenuRole;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IMenuRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@Service
public class MenuRoleServiceImpl extends ServiceImpl<MenuRoleMapper, MenuRole> implements IMenuRoleService {

    @Autowired
    private MenuRoleMapper menuRoleMapper;

    /**
     * 根据角色id查询菜单id
     *
     * @param roleId
     * @return ResultVO
     */
    @Override
    public ResultVO getMenuIdByRoleId(Integer roleId) {

        QueryWrapper<MenuRole> menuRoleQueryWrapper = new QueryWrapper<>();
        menuRoleQueryWrapper.eq("role_id", roleId);

        // 从查出来的所有对象中获取他们的id并且返回一个list
        //List<Integer> menuIds = menuRoleMapper.selectList(menuRoleQueryWrapper).stream().map(MenuRole::getMenuId).collect(Collectors.toList());

        List<MenuRole> menuRoles = menuRoleMapper.selectList(menuRoleQueryWrapper);
        return ResultVO.success("查询菜单id成功", menuRoles);
    }

    /**
     * 更新角色菜单
     *
     * @param roleId
     * @param menuIds
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO updateMenuRole(Integer roleId, Integer[] menuIds) {

        // 删除当前角色下的所有菜单使用权限
        QueryWrapper<MenuRole> menuRoleQueryWrapper = new QueryWrapper<>();
        menuRoleQueryWrapper.eq("role_id", roleId);
        menuRoleMapper.delete(menuRoleQueryWrapper);

        // 如果此时这个用户只有一个菜单使用权限，并且我们要收回这个权限，也就是说收回权限过后，用户所有权限都没有了
        // 这种极端情况下，我们的 menuIds 就为空了。
        if (menuIds == null || menuIds.length == 0) {

            return ResultVO.success("更新权限成功");
        }

        menuRoleMapper.insertRecord(roleId, menuIds);


        return ResultVO.success("更新权限成功");
    }
}
