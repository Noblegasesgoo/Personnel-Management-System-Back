package com.nijigen.server.controller;

import com.nijigen.server.pojo.User;
import com.nijigen.server.pojo.UserLoginParam;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IUserService;
import com.nijigen.server.service.impl.MenuServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 登录api
 */

@RestController
@Api(value = "提供用户登录接口", tags = "用户登录管理")
public class LoginController {

    @Autowired
    private IUserService userService;

    @Autowired
    private MenuServiceImpl menuService;

    /**
     * 登录成功之后返回token
     * @param userLoginParam
     * @param httpServletRequest
     * @return ResultVO
     */
    @ApiOperation(value = "登录")
    @PostMapping("/login")
    public ResultVO login(@RequestBody UserLoginParam userLoginParam, HttpServletRequest httpServletRequest) {

        menuService.getMenusWithRole();
        return userService.login(userLoginParam.getUsername(),
                userLoginParam.getPassword(),
                userLoginParam.getCode(),
                httpServletRequest);
    }

    @ApiOperation(value = "得到当前登录用户信息")
    @GetMapping("/user/info")
    public ResultVO getUserInfo(Principal principal) {

        // 将当前登录对象被设置到 spring security 的全局中去了，我们用 Principal 对象获取当前登录的对象
        if (principal == null){
            return ResultVO.error("获取失败，请重试！");
        }

        // 获取用户名
        String username = principal.getName();
        // 获取用户名之后根据用户名获得完整的用户对象
        User user = userService.getAdminByUserName(username);
        // 返回该用户对象的时候不带上密码
        user.setPassword(null);
        // 设置用户的角色信息
        user.setRoles(userService.getRolesByUserId(user.getId()));

        return ResultVO.success("获取对象信息成功", user);
    }

    @ApiOperation(value = "退出登录")
    @PostMapping("/logout")
    public ResultVO logout() {
        return ResultVO.success("注销成功");
    }
}
