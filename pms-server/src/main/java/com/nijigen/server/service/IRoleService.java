package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Role;
import com.nijigen.server.pojo.VO.ResultVO;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IRoleService extends IService<Role> {


    /**
     * 通过id删除角色
     * @param roleId
     * @return ResultVO
     */
    public ResultVO deleteRoleById(Integer roleId);

    /**
     * 添加角色
     * @param role
     * @return ResultVO
     */
    public ResultVO addRole(@RequestBody Role role);

    /**
     * 获取全部角色信息
     * @return
     */
    public ResultVO getAllRoles();
}
