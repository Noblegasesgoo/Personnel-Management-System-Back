package com.nijigen.server.controller;


import com.nijigen.server.mapper.MenuMapper;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IMenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@RestController
@RequestMapping("/system/basic")
@Api(value = "提供菜单管理", tags = "系统菜单管理")
public class MenuController {

    @Autowired
    private IMenuService menuService;

    @Autowired
    private MenuMapper menuMapper;

    @ApiOperation(value = "根据用户id查询当前id用户菜单信息")
    @GetMapping("/menu")
    public ResultVO getMenusByUserId() {

        return menuService.getMenusByUserId();
    }

}
