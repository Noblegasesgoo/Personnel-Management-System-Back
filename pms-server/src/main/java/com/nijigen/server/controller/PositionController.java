package com.nijigen.server.controller;


import com.nijigen.server.pojo.Position;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IPositionService;
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
@RequestMapping("/system/cfg/position")
@Api(value = "提供岗位管理接口", tags = "岗位管理")
public class PositionController {

    @Autowired
    private IPositionService positionService;

    /**
     * 通过id（从body的position对象中取出）修改岗位信息
     * @param position
     * @return ResultVO
     */
    @ApiOperation(value = "通过id修改岗位信息")
    @PutMapping("/update")
    public ResultVO updatePositionById(@RequestBody Position position) {

        return positionService.updatePositionById(position);
    }

    @ApiOperation(value = "岗位添加接口")
    @PostMapping("/add")
    public ResultVO addPosition(@RequestBody Position position) {

        return positionService.addPositions(position);
    }

    @ApiOperation(value = "岗位删除接口")
    @DeleteMapping("/delete/{positionId}")
    public ResultVO deletePositionById(@PathVariable("positionId") Integer positionId) {

        return positionService.deletePositionById(positionId);
    }
}
