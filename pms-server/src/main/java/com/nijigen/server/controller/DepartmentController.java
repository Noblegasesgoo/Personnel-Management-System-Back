package com.nijigen.server.controller;


import com.nijigen.server.pojo.Department;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IDepartmentService;
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
@RequestMapping("/system/cfg/dept")
@Api(value = "提供部门管理接口", tags = "部门管理")
public class DepartmentController {

    @Autowired
    private IDepartmentService departmentService;

    @ApiOperation(value = "添加部门")
    @PostMapping("/add")
    public ResultVO addDept(@RequestBody Department department) {

        return departmentService.addDept(department);
    }

    /**
     * id从department对象中去区
     * @param department
     * @return ResultVO
     */
    @ApiOperation(value = "通过id修改部门")
    @PutMapping("/update")
    public ResultVO updateDept(@RequestBody Department department) {

        return departmentService.updateDept(department);
    }

    @ApiOperation(value = "通过id删除部门")
    @DeleteMapping("/delete/{deptId}")
    public ResultVO addDept(@PathVariable("deptId") Integer deptId) {

        return departmentService.deleteDept(deptId);
    }

}
