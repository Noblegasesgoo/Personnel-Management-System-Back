package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.NationMapper;
import com.nijigen.server.pojo.Nation;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.INationService;
import com.nijigen.server.utils.RedisUtil;
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
public class NationServiceImpl extends ServiceImpl<NationMapper, Nation> implements INationService {

    @Autowired
    private NationMapper nationMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RedisUtil redisUtil;

    /**
     * 获得所有民族信息
     *
     * @return ResultVO
     */
    @Override
    public ResultVO getAllNations() {

        //从redis获取数据
        ValueOperations<String, Object> valueOperations = redisTemplate.opsForValue();
        List<Nation> redisNations = (List<Nation>) valueOperations.get("nation");

        // 如果为空，去数据库获取
        if (CollectionUtils.isEmpty(redisNations)){

            redisNations = nationMapper.selectList(new QueryWrapper<Nation>());
            //将数据设置到Redis中
            valueOperations.set("nation", redisNations);
        }

        // 如果redis中的内容与数据库的不一致，也就是集合长度不一样，更新Redis中的内容
        if (!nationMapper.selectList(new QueryWrapper<Nation>()).equals(redisNations)) {

            redisUtil.remove("nation");
            redisNations = nationMapper.selectList(new QueryWrapper<Nation>());
            //将数据设置到Redis中
            valueOperations.set("nation", redisNations);
        }

        return ResultVO.success("查询民族信息成功", redisNations);
    }
}
