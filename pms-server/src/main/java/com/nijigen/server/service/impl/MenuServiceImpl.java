package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.MenuMapper;
import com.nijigen.server.pojo.Menu;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IMenuService;
import com.nijigen.server.utils.RedisUtil;
import com.nijigen.server.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

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
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private RedisUtil redisUtil;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 根据用户id获取当前用户的角色对应的菜单信息。
     * 用户id从spring security中的全局对象中存取。
     * @return ResultVO
     */
    @Override
    public ResultVO getMenusByUserId() {

        // 通过security全局上下文获得user对象的id
        Integer userId = UserUtil.getCurrentUserId();

        //从redis获取菜单数据
        ValueOperations<String, Object> valueOperations = redisTemplate.opsForValue();
        List<Menu> redisMenus = (List<Menu>) valueOperations.get("menu_" + userId);

        // 如果为空，去数据库获取
        if (CollectionUtils.isEmpty(redisMenus)){
            redisMenus = menuMapper.selectMenusByUserId(userId);
            //将数据设置到Redis中
            valueOperations.set("menu_"+userId, redisMenus);
        }

        // 如果redis中的内容与数据库的不一致，也就是集合长度不一样，更新Redis中的内容
        if (!menuMapper.selectMenusByUserId(userId).equals(redisMenus)) {

            redisUtil.remove("menu_"+userId);
            redisMenus = menuMapper.selectMenusByUserId(userId);
            //将数据设置到Redis中
            valueOperations.set("menu_"+userId, redisMenus);

        }

        return ResultVO.success("查询菜单成功", redisMenus);
    }

    /**
     * 根据角色获取菜单列表。
     *
     * @return List<Menu>
     */
    @Override
    public List<Menu> getMenusWithRole() {
        List<Menu> menus = menuMapper.selectMenusWithRole();
        return menus;
    }

    /**
     * 获取所有菜单
     *
     * @return List<Menu>
     */
    @Override
    public ResultVO getAllMenus() {

        //从redis获取菜单数据
        ValueOperations<String, Object> valueOperations = redisTemplate.opsForValue();
        List<Menu> redisMenus = (List<Menu>) valueOperations.get("menu_all");

        // 如果为空，去数据库获取
        if (CollectionUtils.isEmpty(redisMenus)){
            redisMenus = menuMapper.selectAllMenus();
            //将数据设置到Redis中
            valueOperations.set("menu_all", redisMenus);
        }

        // 如果redis中的内容与数据库的不一致，也就是集合长度不一样，更新Redis中的内容
        if (!menuMapper.selectAllMenus().equals(redisMenus)) {

            redisUtil.remove("menu_all");
            redisMenus = menuMapper.selectAllMenus();
            //将数据设置到Redis中
            valueOperations.set("menu_all", redisMenus);

        }

        return ResultVO.success("查询所有菜单成功！", redisMenus);
    }

}
