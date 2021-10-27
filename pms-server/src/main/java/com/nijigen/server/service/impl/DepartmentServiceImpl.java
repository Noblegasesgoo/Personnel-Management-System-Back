package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.DepartmentMapper;
import com.nijigen.server.pojo.Department;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements IDepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 分页查询所有部门信息
     *
     * @param currentPage
     * @param pageSize
     * @return ResultVO
     */
    @Override
    public ResultVO getAllDeptInfo(Integer currentPage, Integer pageSize) {

        // 新建条件查询器查询启用的岗位
        QueryWrapper<Department> departmentQueryWrapper = new QueryWrapper<>();
        departmentQueryWrapper.eq("enabled", true);
        //参数一：当前页
        //参数二：页面大小
        Page<Department> currentDepartment = new Page<>(currentPage, pageSize);

        return ResultVO.success("查询第"+currentPage+"页部门成功!", departmentMapper.selectPage(currentDepartment, departmentQueryWrapper));
    }

    /**
     * 添加部门
     *
     * @param department
     * @return ResultVO
     */
    @Override
    public ResultVO addDept(Department department) {

        // 新建条件查询
        QueryWrapper<Department> departmentQueryWrapper = new QueryWrapper<>();
        departmentQueryWrapper.eq("name", department.getName());

        // 查询数据库是否有叫这个名字的部门
        Department one = departmentMapper.selectOne(departmentQueryWrapper);
        if (one == null) {
            department.setId(null);
            department.setParentId(0);
            department.setDeptPath(".1");
            department.setIsParent(false);
            department.setEnabled(true);

            departmentMapper.insert(department);
            return ResultVO.success("添加部门成功！", department);
        } else if (one.getEnabled() == false) {

            department.setId(one.getId());
            department.setParentId(0);
            department.setDeptPath(".1");
            department.setIsParent(false);
            department.setEnabled(true);

            departmentMapper.updateById(department);
            return ResultVO.success("添加部门成功！", department);
        } else {

            return ResultVO.error("该部门已经存在，请重试！", department);
        }

    }

    /**
     * 修改部门信息
     *
     * @param department
     * @return ResultVO
     */
    @Override
    public ResultVO updateDept(Department department) {

        department.setParentId(0);
        department.setDeptPath(".1");
        department.setIsParent(false);
        department.setEnabled(true);

        if (departmentMapper.updateById(department) > 0) {

            return ResultVO.success("更新部门信息成功！", department);
        }

        return ResultVO.error("数据库繁忙，请稍后再试");
    }

    /**
     * 通过部门id删除部门
     *
     * @param deptId
     * @return ResultVO
     */
    @Override
    public ResultVO deleteDept(Integer deptId) {

        Department deletedDepartment = departmentMapper.selectById(deptId);

        UpdateWrapper<Department> departmentUpdateWrapper = new UpdateWrapper<>();
        departmentUpdateWrapper.set("enabled", false).eq("id", deptId);

        if (departmentMapper.update(deletedDepartment, departmentUpdateWrapper) > 0) {

            return ResultVO.success("删除部门成功", deletedDepartment);
        }

        return ResultVO.error("删除失败，请稍后再试", deletedDepartment);
    }

}
