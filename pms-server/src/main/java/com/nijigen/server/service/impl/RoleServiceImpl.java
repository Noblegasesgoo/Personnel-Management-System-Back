package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.MenuRoleMapper;
import com.nijigen.server.mapper.RoleMapper;
import com.nijigen.server.mapper.UserRoleMapper;
import com.nijigen.server.pojo.MenuRole;
import com.nijigen.server.pojo.Role;
import com.nijigen.server.pojo.UserRole;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private MenuRoleMapper menuRoleMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    /**
     * 通过id删除角色
     *
     * @param roleId
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO deleteRoleById(Integer roleId) {

        // 先将MenuRole表中有关roleId的内容删除
        menuRoleMapper.delete(new QueryWrapper<MenuRole>().eq("role_id", roleId));
        // 再将UserRole表中有关roleId的内容删除
        userRoleMapper.delete(new QueryWrapper<UserRole>().eq("role_id", roleId));
        // 最后再删除角色
        Role deletedRole = roleMapper.selectById(roleId); // 保存要删除的角色，准备返回给前台
        if (roleMapper.deleteById(roleId) > 0) {

            // 删除成功后将删除角色信息返回给前台
            return ResultVO.success("删除角色成功!", deletedRole);
        }

        return ResultVO.error("与菜单或用户有管理信息，删除失败，请稍后再试", deletedRole);

    }

    /**
     * 添加角色
     *
     * @param role
     * @return ResultVO
     */
    @Override
    public ResultVO addRole(Role role) {

        // 如果不是以ROLE_开头，我们就补充上
        if (!role.getName().startsWith("ROLE_")) {
            role.setName("ROLE_" + role.getName());
        }

        List<Role> roles = roleMapper.selectList(new QueryWrapper<Role>());
        for(Role r : roles) {

            if(r.getName().equals(role.getName())) {

                return ResultVO.error("角色名称重复！请重新输入", role.getName());
            }
        }

        if (roleMapper.insert(role) > 0) {

            role.setId(null);
            return ResultVO.success("添加角色成功!", role);
        }

        return ResultVO.error("添加失败，请稍后再试", role);
    }

    /**
     * 获取全部角色信息
     *
     * @return
     */
    @Override
    public ResultVO getAllRoles() {

        return ResultVO.success("查询所有角色成功！",roleMapper.selectList(new QueryWrapper<>()));
    }
}
