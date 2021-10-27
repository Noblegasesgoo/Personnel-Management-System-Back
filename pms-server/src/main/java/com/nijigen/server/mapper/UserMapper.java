package com.nijigen.server.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.nijigen.server.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */

@Repository
public interface UserMapper extends BaseMapper<User> {


    /**
     * 获取关键词有关所有用户信息（除了当前登录用户的）
     * @param userId
     * @param keywords
     * @return List<User>
     */
    List<User> selectAllUsersByKeywords(@Param("userId") Integer userId, @Param("keywords") String keywords);
}
