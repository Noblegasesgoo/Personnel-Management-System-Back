package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Employee;
import com.nijigen.server.pojo.VO.ResultPageVO;
import com.nijigen.server.pojo.VO.ResultVO;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-25
 */
public interface IEmployeeService extends IService<Employee> {

    /**
     * 分页查询所有员工
     * @param currentPage
     * @param pageSize
     * @param employee 用来条件搜索
     * @param beginDateScope 入职日期范围
     * @return ResultPageVO
     */
    public ResultPageVO getAllEmpInfo(Integer currentPage, Integer pageSize, Employee employee, LocalDate[] beginDateScope);

    /**
     * 添加员工
     * @param employee
     * @return ResultVO
     */
    public ResultVO addEmployee(Employee employee);

    /**
     * 开除员工
     * @param employee
     * @return ResultVO
     */
    public ResultVO deleteEmployee(Employee employee);

    /**
     * 查询员工信息（导出用），可以传入员工id实现单条查询
     * @param emp_id
     * @return ResultVO
     */
    public List<Employee> getEmployee(Integer emp_id);

}
