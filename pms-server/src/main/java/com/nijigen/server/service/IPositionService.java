package com.nijigen.server.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.nijigen.server.pojo.Position;
import com.nijigen.server.pojo.VO.ResultVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
public interface IPositionService extends IService<Position> {


    /**
     * 分页查询所有岗位信息
     * @param currentPage 当前页面
     * @param pageSize 页面大小
     * @return Page<Position>
     */
    public Page<Position> getAllPositions(Integer currentPage, Integer pageSize);

    /**
     * 添加岗位
     * @param position
     * @return ResultVO
     */
    public ResultVO addPositions(Position position);

    /**
     * 根据岗位id修改岗位信息
     * @param position 从中取id
     * @return ResultVO
     */
    public ResultVO updatePositionById(Position position);

    /**
     * 通过id删除岗位
     * @param positionId
     * @return ResultVO
     */
    public ResultVO deletePositionById(Integer positionId);
}
