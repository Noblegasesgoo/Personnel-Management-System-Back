package com.nijigen.server.controller;


import com.nijigen.server.pojo.EmployeeEntry;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IEmployeeEntryService;
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
 * @since 2021-10-27
 */
@RestController
@RequestMapping("/employee-entry")
@Api(value = "提供员工入职管理接口", tags = "员工入职管理")
public class EmployeeEntryController {

    @Autowired
    private IEmployeeEntryService employeeEntryService;

    @ApiOperation(value = "查询入职表信息")
    @GetMapping("/query")
    public ResultVO getAllEmployeeEntryInfo() {

        return employeeEntryService.getAllEmployeeEntryInfo();
    }

    @ApiOperation(value = "同意入职信息")
    @PostMapping("/agree")
    public ResultVO agreeEmployeeEntryInfo(@RequestBody EmployeeEntry employeeEntry) {

        return employeeEntryService.agreeEmployeeEntryInfo(employeeEntry);
    }

    @ApiOperation(value = "入职描述修改")
    @PutMapping("/update")
    public ResultVO updateEmployeeEntryInfo(@RequestBody EmployeeEntry employeeEntry) {

        return employeeEntryService.updateEmployeeEntryInfo(employeeEntry);
    }

    @ApiOperation(value = "取消入职申请")
    @DeleteMapping("/delete/{eeId}")
    public ResultVO deleteApplication(@PathVariable("eeId") Integer eeId) {

        return employeeEntryService.deleteApplication(eeId);
    }

}
