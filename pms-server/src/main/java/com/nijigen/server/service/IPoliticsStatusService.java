package com.nijigen.server.service;

import com.nijigen.server.pojo.PoliticsStatus;
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
public interface IPoliticsStatusService extends IService<PoliticsStatus> {

    /**
     * 获取所有政治面貌信息
     * @return ResultVO
     */
    public ResultVO getAllPoliticsStatus();
}
