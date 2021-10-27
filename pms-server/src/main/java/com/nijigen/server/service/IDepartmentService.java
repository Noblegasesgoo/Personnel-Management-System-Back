package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Department;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IDepartmentService extends IService<Department> {

    /**
     * 分页查询所有部门信息
     * @param currentPage
     * @param pageSize
     * @return ResultVO
     */
    public ResultVO getAllDeptInfo(Integer currentPage, Integer pageSize);

    /**
     * 添加部门
     * @param department
     * @return ResultVO
     */
    public ResultVO addDept(Department department);

    /**
     * 修改部门信息
     * @param department
     * @return ResultVO
     */
    public ResultVO updateDept(Department department);

    /**
     * 通过部门id删除部门
     * @param deptId
     * @return ResultVO
     */
    public ResultVO deleteDept(Integer deptId);
}
