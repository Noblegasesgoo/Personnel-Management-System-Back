package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Role;
import com.nijigen.server.pojo.User;
import com.nijigen.server.pojo.VO.ResultVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IUserService extends IService<User> {

    /**
     * 登录成功之后返回给前端当前用户token
     * @param username
     * @param password
     * @param code
     * @param httpServletRequest
     * @return ResultVO
     */
    public ResultVO login(String username, String password, String code, HttpServletRequest httpServletRequest);

    /**
     * 根据用户名获取用户
     * @param username
     * @return Admin
     */
    public User getAdminByUserName(String username);

    /**
     * 根据用户id查询当前用户角色信息
     * @param userId
     * @return List<Role>
     */
    public List<Role> getRolesByUserId(Integer userId);

    /**
     * 获取关键词有关所有用户信息（除了当前登录用户的）
     * @param keywords 关键词
     * @return ResultVO
     */
    public ResultVO getAllUsersByKeywords(String keywords);

    /**
     * 通过id删除用户信息
     * @param userId
     * @return ResultVO
     */
    public ResultVO deleteUserById(Integer userId);

    /**
     * 通过id更新用户角色信息
     * @param userId
     * @param roleIds 暂时性只接受一个，换成数组形式是为了方便扩展
     * @return ResultVO
     */
    public ResultVO updateUserRole(Integer userId, Integer[] roleIds);

    /**
     * 通过id更新用户信息
     * @param user
     * @return ResultVO
     */
    public ResultVO updateUserById(User user);

}
