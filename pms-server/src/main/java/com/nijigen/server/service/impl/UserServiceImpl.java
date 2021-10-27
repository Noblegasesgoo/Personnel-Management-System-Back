package com.nijigen.server.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.RoleMapper;
import com.nijigen.server.mapper.UserMapper;
import com.nijigen.server.mapper.UserRoleMapper;
import com.nijigen.server.pojo.Role;
import com.nijigen.server.pojo.User;
import com.nijigen.server.pojo.UserRole;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IUserService;
import com.nijigen.server.utils.JwtTokenUtil;
import com.nijigen.server.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserDetailsService userDetailsService; // 来自spring security提供的。

    @Autowired
    private PasswordEncoder passwordEncoder; // 来自spring security 提供的密码加密。

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    /**
     * 登录成功之后返回给前端当前用户token
     *
     * @param username
     * @param password
     * @param code
     * @param httpServletRequest
     * @return ResultVO
     */
    @Override
    public ResultVO login(String username, String password, String code, HttpServletRequest httpServletRequest) {

        /* 1、验证码 */
        // 得到session中的验证码
        String captcha = (String) httpServletRequest.getSession().getAttribute("captcha");
        // 先判断前台传回的验证码是否不为空并且是否与session中的验证码相同
        if (!captcha.equalsIgnoreCase(code) || StringUtils.isEmpty(code)) {
            return ResultVO.error("验证码错误请重试!");
        }

        /* 2、登录 */
        // 正常登陆成功之后正常情况下我们如果用了spring security，我们后期再去获取一些用户信息的时候。
        // 我们可以用spring security提供的一些对象例如 userDetails 所以我们要获取这个对象。
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);

        // 如果此时userDetails为空或者前台传回的密码与userDetails中的密码不匹配的话
        if (userDetails == null || !passwordEncoder.matches(password, userDetails.getPassword())) {
            return ResultVO.error("用户名或密码不正确!");
        }

        // 如果userDetails中enabled字段为false的话
        if (!userDetails.isEnabled()) {
            return ResultVO.error("该账户已被禁用，请联系管理员！");
        }

        // 我们要把现在登录的这个对象，我们登录成功之后把这个登录的用户对象放在spring security的全文中。
        // 更新用户登录对象
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);

        // 生成token
        String token = jwtTokenUtil.generateToken(userDetails);
        Map<String,String> tokenMap = new HashMap<>();
        tokenMap.put("token", token);
        tokenMap.put("tokenHead", tokenHead);

        return ResultVO.success("登陆成功", tokenMap);
    }

    /**
     * 根据用户名获取用户
     *
     * @param username
     * @return User
     */
    @Override
    public User getAdminByUserName(String username) {

        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("username", username).eq("enabled", true);

        User user = userMapper.selectOne(userQueryWrapper);
        if (user == null) {
            return null;
        } else {
            return user;
        }

    }

    /**
     * 根据用户id查询当前用户角色信息
     * @param userId
     * @return List<Role>
     */
    @Override
    public List<Role> getRolesByUserId(Integer userId) {
        return roleMapper.selectRolesByUserId(userId);
    }


    /**
     * 获取关键词有关所有用户信息（除了当前登录用户的）
     *
     * @param keywords 关键词
     * @return ResultVO
     */
    @Override
    public ResultVO getAllUsersByKeywords(String keywords) {

        // 我们不要传回当前登录过的这个用户的信息，所以取出id备用

        return ResultVO.success("查询用户信息成功！", userMapper.selectAllUsersByKeywords(UserUtil.getCurrentUserId(), keywords));
    }

    /**
     * 通过id删除用户信息
     *
     * @param userId
     * @return ResultVO
     */
    @Override
    public ResultVO deleteUserById(Integer userId) {

        User deletedUser = userMapper.selectById(userId);
        UpdateWrapper<User> userUpdateWrapper = new UpdateWrapper<>();
        userUpdateWrapper.set("enabled", false).eq("id", userId);

        if (userMapper.update(deletedUser, userUpdateWrapper) > 0) {
            return ResultVO.success("封禁用户成功");
        }

        return ResultVO.error("封禁用户失败，请稍后再试");
    }

    /**
     * 通过id更新用户角色信息
     *
     * @param userId
     * @param roleIds 暂时性只接受一个，换成数组形式是为了方便扩展
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO updateUserRole(Integer userId, Integer[] roleIds) {

        // 更新前我们首先要去删除
        QueryWrapper<UserRole> userRoleQueryWrapper = new QueryWrapper<>();
        userRoleQueryWrapper.eq("user_id", userId);
        userRoleMapper.delete(userRoleQueryWrapper);

        // 插入
        Integer result = userRoleMapper.addUserRole(userId, roleIds);

        // 如果插入过后影响的行数等于我们传进来的roleIds数组的长度那就是插入成功
        if (roleIds.length == result) {

            return ResultVO.success("更新用户角色信息成功！");
        } else {

            return ResultVO.error("更新用户角色信息失败！请重试！");
        }

    }

    /**
     * 通过id更新用户信息
     *
     * @param user
     * @return ResultVO
     */
    @Override
    public ResultVO updateUserById(User user) {

        // 先将用户的角色查出来设置
        user.setRoles(roleMapper.selectRolesByUserId(user.getId()));
        // 设置密码
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        if (userMapper.updateById(user) == 0) {

            return ResultVO.error("更新用户信息失败！", user);
        } else {

            return ResultVO.success("更新用户信息成功！", user);
        }
    }

}
