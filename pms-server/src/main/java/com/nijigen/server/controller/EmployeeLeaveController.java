package com.nijigen.server.controller;


import com.nijigen.server.pojo.EmployeeLeave;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IEmployeeLeaveService;
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
 * @since 2021-10-26
 */
@RestController
@Api(value = "提供员工离职管理接口", tags = "员工离职管理")
@RequestMapping("/personnel/leave")
public class EmployeeLeaveController {

    @Autowired
    private IEmployeeLeaveService employeeLeaveService;

    @ApiOperation(value = "获取离职表信息")
    @GetMapping("/get")
    public ResultVO getAllEmployeeLeaveInfo() {

        return employeeLeaveService.getAllEmployeeLeaveInfo();
    }

    @ApiOperation(value = "同意离职信息")
    @PostMapping("/agree")
    public ResultVO agreeEmployeeLeaveInfo(@RequestBody EmployeeLeave employeeLeave) {

        return employeeLeaveService.agreeEmployeeLeaveInfo(employeeLeave);
    }

    @ApiOperation(value = "离职描述修改")
    @PutMapping("/update")
    public ResultVO updateEmployeeLeaveInfo(@RequestBody EmployeeLeave employeeLeave) {

        return employeeLeaveService.updateEmployeeLeaveInfo(employeeLeave);
    }

    @ApiOperation(value = "取消离职申请")
    @DeleteMapping("/delete/{elId}")
    public ResultVO deleteApplication(@PathVariable("elId") Integer elId) {

        return employeeLeaveService.deleteApplication(elId);
    }
}
