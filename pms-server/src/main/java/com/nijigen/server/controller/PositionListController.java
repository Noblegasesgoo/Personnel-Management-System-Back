package com.nijigen.server.controller;

import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IPositionService;
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
 * @apiNote 岗位信息管理api
 */

@RestController
@RequestMapping("/position")
@Api(value = "提供岗位信息管理接口", tags = "岗位信息管理")
public class PositionListController {

    @Autowired
    private IPositionService positionService;

    @ApiOperation(value = "分页查询当前页所有岗位接口")
    @GetMapping("/query")
    public ResultVO getAllPositions(@RequestParam("currentPage") Integer currentPage, @RequestParam("pageSize") Integer pageSize) {

        return ResultVO.success("查询第"+currentPage+"页的岗位数据成功",positionService.getAllPositions(currentPage, pageSize));
    }

}
