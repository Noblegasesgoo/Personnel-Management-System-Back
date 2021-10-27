package com.nijigen.server.service;

import com.nijigen.server.pojo.Nation;
import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface INationService extends IService<Nation> {

    /**
     * 获得所有民族信息
     * @return ResultVO
     */
    public ResultVO getAllNations();
}
