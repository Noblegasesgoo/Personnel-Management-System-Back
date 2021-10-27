package com.nijigen.server.controller;


import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import com.nijigen.server.pojo.*;
import com.nijigen.server.pojo.VO.ResultPageVO;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-25
 */
@RestController
@RequestMapping("/employee/basic")
@Api(value = "提供员工基本信息管理接口", tags = "员工基本信息管理")
public class EmployeeController {

    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private IDepartmentService departmentService;

    @Autowired
    private IPositionService positionService;

    @Autowired
    private IPoliticsStatusService politicsStatusService;

    @Autowired
    private INationService nationService;

    @Autowired
    private IJobLevelService jobLevelService;


    @ApiOperation(value = "分页查询所有员工")
    @GetMapping("/query")
    public ResultPageVO getAllEmployee(@RequestParam(defaultValue = "1") Integer currentPage,
                                       @RequestParam(defaultValue = "5") Integer pageSize,
                                       Employee employee,
                                       LocalDate[] beginDateScope) {

        return employeeService.getAllEmpInfo(currentPage,pageSize,employee,beginDateScope);
    }

    @ApiOperation(value = "员工入职")
    @PostMapping("/add")
    public ResultVO addEmployee(@RequestBody Employee employee) {

        return employeeService.addEmployee(employee);
    }

    @ApiOperation(value = "通过id更新员工")
    @PutMapping("/update")
    public ResultVO updateEmployee(@RequestBody Employee employee) {

        if (employeeService.updateById(employee)) {

            return ResultVO.success("更新员工信息成功", employee);
        } else {

            return ResultVO.error("更新员工信息失败，请稍后再试", employee);
        }
    }

    @ApiOperation(value = "通过id开除员工")
    @PostMapping("/delete")
    public ResultVO deleteEmployee(@RequestBody Employee employee) {

        return employeeService.deleteEmployee(employee);
    }

    /**
     * 以流的形式导入员工信息（导入用）
     * @param file
     * @return ResultVO
     */
    @ApiOperation(value = "导入员工数据（有bug）")
    @PostMapping("/import")
    public ResultVO importEmployeeInfo(MultipartFile file) {

        ImportParams importParams = new ImportParams();
        // 从excel第二行开始读，去掉标题栏
        importParams.setTitleRows(1);
        //// 获取五个一对一关系对象的所有数据
        //List<Position> positionList = positionService.list();
        //List<Department> departmentList = departmentService.list();
        //List<JobLevel> jobLevelList = jobLevelService.list();
        //List<Nation> nationList = (List<Nation>) nationService.getAllNations().getData();
        //List<PoliticsStatus> politicsStatusList = (List<PoliticsStatus>) politicsStatusService.getAllPoliticsStatus().getData();

        try {
            List<Employee> employees = ExcelImportUtil.importExcel(file.getInputStream(), Employee.class, importParams);

            //employees.forEach(employee -> {
            //
            //    /*
            //        野路子大致逻辑（不提倡）：
            //            通过重写这几个实体类中的equals和hashcode方法，将name变成比较对象，使用name调用有参构造从而创建一个唯一对象，有唯一索引，
            //            通过这个索引值可以确定它在数据库查出的list中的对象是谁，然后得到这个name对应的对象，然后通过这个对象得到id。
            //     */
            //    // 设置部门id
            //    employee.setDepartmentId(departmentList.get(departmentList.indexOf(new Department(employee.getDepartment().getName()))).getId());
            //    // 设置民族id
            //    employee.setNationId(nationList.get(nationList.indexOf(new Nation(employee.getNation().getName()))).getId());
            //    // 设置职称id
            //    employee.setJobLevelId(jobLevelList.get(jobLevelList.indexOf(new JobLevel(employee.getJobLevel().getName()))).getId());
            //    // 设置政治面貌id
            //    employee.setPoliticId(politicsStatusList.get(politicsStatusList.indexOf(new PoliticsStatus(employee.getPoliticsStatus().getName()))).getId());
            //    // 设置岗位id
            //    employee.setPoliticId(positionList.get(positionList.indexOf(new Position(employee.getPosition().getName()))).getId());
            //
            //});

            if (employeeService.saveBatch(employees)) {

                return ResultVO.success("导入员工信息成功！", employees);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResultVO.success("导入员工信息失败！请重试！");

    }

    /**
     * 以流的形式导出员工信息（导出用）
     * @param response
     * @return ResultVO
     */
    @ApiOperation(value = "导出员工数据")
    @GetMapping(value = "/export", produces = "application/octet-stream")
    public void exportEmployeeInfo(HttpServletResponse response) {

        // 拿到数据
        List<Employee> employees = employeeService.getEmployee(null);

        // 设置导出格式
        ExportParams exportParams = new ExportParams("员工表"
                , "员工表-"+ (new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString())
                , ExcelType.HSSF);

        // 导出数据
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams, Employee.class, employees);

        // 得到输出流
        ServletOutputStream outputStream = null;
        try {
            // 设置响应头的信息，告知客户端响应正文类型，流的形式
            response.setHeader("content-type", "application/octet-stream");
            // 设置响应头的信息，防止中文乱码
            response.setHeader("content-disposition", "attachment;filename="+ URLEncoder.encode("员工表.xls", "UTF-8"));

            // 导出
            outputStream = response.getOutputStream();
            workbook.write(outputStream);

        } catch (IOException e) {
            e.printStackTrace();
        } finally {

            if (outputStream != null) {
                try {
                    outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }


    @ApiOperation(value = "获取所有民族信息")
    @GetMapping("/query/nation")
    public ResultVO getAllNations() {

        return nationService.getAllNations();
    }

    @ApiOperation(value = "获取所有政治面貌信息")
    @GetMapping("/query/politics-status")
    public ResultVO getAllPoliticsStatus() {

        return politicsStatusService.getAllPoliticsStatus();
    }

    @ApiOperation(value = "获取所有岗位信息")
    @GetMapping("/query/position")
    public ResultVO getAllPositions() {

        return ResultVO.success("获取所有岗位信息成功", positionService.list());
    }

    @ApiOperation(value = "获取所有部门信息")
    @GetMapping("/query/dept")
    public ResultVO getAllDepartments() {

        return ResultVO.success("获取所有部门信息成功", departmentService.list());
    }

    @ApiOperation(value = "获取所有职称信息")
    @GetMapping("/query/job-level")
    public ResultVO getAllJobLevel() {

        return ResultVO.success("获取所有职称信息成功", jobLevelService.list());
    }
}
