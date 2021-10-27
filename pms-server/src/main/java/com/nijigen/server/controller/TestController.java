package com.nijigen.server.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhaolimin
 * @date 2021/10/19
 * @apiNote 测试api
 */

@RestController
@Api(value = "提供api测试管理", tags = "api测试管理")
public class TestController {

    @GetMapping("/dept/add")
    @ApiOperation(value = "测试动态权限设置")
    public String testAutObjectPostProcess() {
        return "dept/add";
    }
}
