package com.nijigen.server.controller;


import com.nijigen.server.pojo.User;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IRoleService;
import com.nijigen.server.service.IUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@RestController
@RequestMapping("/system/user/")
@Api(value = "提供用户管理接口", tags = "用户管理")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IRoleService roleService;

    @ApiOperation(value = "获取关键词有关所有用户信息")
    @GetMapping("/query")
    public ResultVO getAllUsersByKeywords(String keywords) {

        // 获取关键词有关所有用户信息（除了当前登录用户的）
        return userService.getAllUsersByKeywords(keywords);
    }

    @ApiOperation(value = "通过id删除用户信息")
    @DeleteMapping("/delete/{userId}")
    public ResultVO deleteUserById(@PathVariable("userId") Integer userId) {

        // id 从user对象中获取
        return userService.deleteUserById(userId);
    }

    @ApiOperation(value = "获取所有角色信息")
    @GetMapping("/roles")
    public ResultVO getAllRoles() {

        return roleService.getAllRoles();
    }

    @ApiOperation(value = "更新用户角色")
    @PutMapping("/update/role")
    public ResultVO updateUserRole(Integer userId, Integer[] roleIds) {

        return userService.updateUserRole(userId, roleIds);
    }

    @ApiOperation(value = "通过id更新用户信息")
    @PutMapping("/update")
    public ResultVO updateUserById(@RequestBody User user) {

        // id 从user对象中获取
        return userService.updateUserById(user);
    }

}
