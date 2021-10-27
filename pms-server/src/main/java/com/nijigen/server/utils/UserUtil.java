package com.nijigen.server.utils;

import com.nijigen.server.pojo.User;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

/**
 * @author zhaolimin
 * @date 2021/10/24
 * @apiNote 用户工具类
 */

@Component
public class UserUtil {

    /**
     * 获取当前登录的用户
     * @return User
     */
    public static User getCurrentUser(){

        return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    /**
     * 获取当前登录的用户的id
     * @return id
     */
    public static Integer getCurrentUserId() {

        return getCurrentUser().getId();
    }

    /**
     * 获取当前登录的用户的用户名
     * @return username
     */
    public static String getCurrentUserUsername() {

        return getCurrentUser().getUsername();
    }

    /**
     * 获取当前登录的用户的密码
     * @return password
     */
    public static String getCurrentUserPassword() {

        return getCurrentUser().getPassword();
    }

}
