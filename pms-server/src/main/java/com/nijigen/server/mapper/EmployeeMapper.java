package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nijigen.server.pojo.Employee;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-25
 */

@Repository
public interface EmployeeMapper extends BaseMapper<Employee> {

    /**
     * 分页查询所有员工
     *
     * @param currentPage
     * @param pageSize
     * @param employee       用来条件搜索
     * @param beginDateScope 入职日期范围
     * @return IPage<Employee>
     */
    IPage<Employee> getAllEmpInfo(Page<Employee> employeePage, @Param("employee") Employee employee, @Param("beginDateScope") LocalDate[] beginDateScope);

    /**
     * 查询员工信息（导出用），可以传入员工id实现单条查询
     * @param emp_id
     * @return ResultVO
     */
    List<Employee> selectEmployee(Integer emp_id);
}
