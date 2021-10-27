package com.nijigen.server.service.impl;

import com.nijigen.server.pojo.Oplog;
import com.nijigen.server.mapper.OplogMapper;
import com.nijigen.server.service.IOplogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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
public class OplogServiceImpl extends ServiceImpl<OplogMapper, Oplog> implements IOplogService {

}
