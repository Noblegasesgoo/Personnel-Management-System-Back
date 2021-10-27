package com.nijigen.server.controller;

import com.nijigen.server.pojo.Role;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IMenuRoleService;
import com.nijigen.server.service.IMenuService;
import com.nijigen.server.service.IRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author zhaolimin
 * @date 2021/10/22
 * @apiNote 权限组api
 */

@RestController
@RequestMapping("/system/cfg/permission")
@Api(value = "提供权限组信息的接口", tags = "权限组管理")
public class PermissionController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IMenuService menuService;

    @Autowired
    private IMenuRoleService menuRoleService;

    @ApiOperation(value = "获取所有角色")
    @GetMapping("/list")
    public ResultVO getAllRoles() {

        return ResultVO.success("获取所有角色成功!", roleService.list());
    }

    @ApiOperation(value = "添加角色")
    @PostMapping("/add")
    public ResultVO addRole(@RequestBody Role role) {

        return roleService.addRole(role);
    }

    @ApiOperation(value = "删除角色")
    @DeleteMapping("/delete/{roleId}")
    public ResultVO deleteRoleById(@PathVariable("roleId") Integer roleId) {

        return roleService.deleteRoleById(roleId);
    }

    @ApiOperation(value = "获取所有菜单信息")
    @GetMapping("/menus")
    public ResultVO getAllMenus() {

        return menuService.getAllMenus();
    }

    @ApiOperation(value = "根据角色id查询菜单id")
    @GetMapping("/get-menus-id-by/{roleId}")
    public ResultVO getMenuIdByRoleId(@PathVariable("roleId") Integer roleId) {

        return menuRoleService.getMenuIdByRoleId(roleId);
    }

    @ApiOperation(value = "更新角色菜单")
    @PutMapping("/update-menu-role")
    public ResultVO updateMenuRole(Integer roleId, Integer[] menuIds) {

        return menuRoleService.updateMenuRole(roleId, menuIds);
    }

}

