package com.nijigen.server.controller;

import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IDepartmentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhaolimin
 * @date 2021/10/23
 * @apiNote 部门信息管理api
 */

@RestController
@RequestMapping("/dept")
@Api(value = "提供部门信息管理接口", tags = "部门信息管理")
public class DepartmentListController {

    @Autowired
    private IDepartmentService departmentService;

    @ApiOperation(value = "分页查询部门信息")
    @GetMapping("/query")
    public ResultVO getAllDeptInfo(@RequestParam(defaultValue = "1") Integer currentPage, @RequestParam(defaultValue = "5") Integer pageSize) {

        return departmentService.getAllDeptInfo(currentPage,pageSize);
    }
}
