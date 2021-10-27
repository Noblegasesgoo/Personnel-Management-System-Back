package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.PoliticsStatusMapper;
import com.nijigen.server.pojo.PoliticsStatus;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IPoliticsStatusService;
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
public class PoliticsStatusServiceImpl extends ServiceImpl<PoliticsStatusMapper, PoliticsStatus> implements IPoliticsStatusService {

    @Autowired
    private PoliticsStatusMapper politicsStatusMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RedisUtil redisUtil;

    /**
     * 获取所有政治面貌信息
     * @return ResultVO
     */
    @Override
    public ResultVO getAllPoliticsStatus() {

        // 从redis获取数据
        ValueOperations<String, Object> valueOperations = redisTemplate.opsForValue();
        List<PoliticsStatus> redisPoliticsStatus = (List<PoliticsStatus>) valueOperations.get("politics_status");

        // 如果为空，去数据库取
        if (CollectionUtils.isEmpty(redisPoliticsStatus)) {

            redisPoliticsStatus = politicsStatusMapper.selectList(new QueryWrapper<PoliticsStatus>());
            valueOperations.set("politics_status", redisPoliticsStatus);
        }

        // 如果redis中的内容与数据库的不一致，也就是集合长度不一样，更新Redis中的内容
        if (!politicsStatusMapper.selectList(new QueryWrapper<PoliticsStatus>()).equals(redisPoliticsStatus)) {

            redisUtil.remove("politics_status");
            redisPoliticsStatus = politicsStatusMapper.selectList(new QueryWrapper<PoliticsStatus>());
            //将数据设置到Redis中
            valueOperations.set("politics_status", redisPoliticsStatus);
        }

        return ResultVO.success("查询政治面貌信息成功", redisPoliticsStatus);
    }
}
