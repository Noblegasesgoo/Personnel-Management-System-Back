package com.nijigen.server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.nijigen.server.mapper.PositionMapper;
import com.nijigen.server.pojo.Position;
import com.nijigen.server.pojo.VO.ResultVO;
import com.nijigen.server.service.IPositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zhaolimin
 * @since 2021-10-18
 */
@Service
public class PositionServiceImpl extends ServiceImpl<PositionMapper, Position> implements IPositionService {

    @Autowired
    private PositionMapper positionMapper;

    /**
     * 分页查询所有部门信息
     * @param currentPage 当前页面
     * @param pageSize 页面大小
     * @return Page<Position>
     */
    @Override
    public Page<Position> getAllPositions(Integer currentPage, Integer pageSize) {

        // 新建条件查询器查询启用的岗位
        QueryWrapper<Position> positionQueryWrapper = new QueryWrapper<>();
        positionQueryWrapper.eq("enabled", true);

        //参数一：当前页
        //参数二：页面大小

        Page<Position> currentPositions = new Page<>(currentPage, pageSize);

        return positionMapper.selectPage(currentPositions, positionQueryWrapper);
    }

    /**
     * 添加岗位
     *
     * @param position
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO addPositions(Position position) {

        // 新建条件查询
        QueryWrapper<Position> positionQueryWrapper = new QueryWrapper<>();
        positionQueryWrapper.eq("name", position.getName());

        // 查询数据库是否有叫这个名字的岗位
        Position one = positionMapper.selectOne(positionQueryWrapper);
        if (one == null) {

            // 没有则插入
            position.setId(null);
            position.setEnabled(true); // 设置启用状态
            position.setCreateDate(LocalDate.now()); // 设置插入时间
            positionMapper.insert(position);
            return ResultVO.success("添加岗位成功！", position);
        } else if (one.getEnabled() == false) {

            // 未启用则更新原有信息
            position.setId(one.getId());
            position.setEnabled(true); // 设置启用状态
            position.setCreateDate(LocalDate.now()); // 设置插入时间
            positionMapper.updateById(position);
            return ResultVO.success("添加岗位成功！", position);
        } else {

            return ResultVO.error("该岗位已经存在，请重试！", position);
        }

    }

    /**
     * 根据岗位id修改岗位信息
     *
     * @param position
     * @return ResultVO
     */
    @Override
    @Transactional
    public ResultVO updatePositionById(Position position) {

        position.setEnabled(true); // 设置启用状态
        position.setCreateDate(LocalDate.now()); // 设置插入时间
        if (positionMapper.updateById(position) > 0) {
            return ResultVO.success("更新岗位信息成功！", null);
        }

        return ResultVO.error("数据库繁忙，请稍后再试");
    }

    /**
     * 通过id删除岗位
     *
     * @param positionId
     * @return ResultVO
     */
    @Override
    public ResultVO deletePositionById(Integer positionId) {

        Position deletedPosition = positionMapper.selectById(positionId);

        UpdateWrapper<Position> positionUpdateWrapper = new UpdateWrapper<>();
        positionUpdateWrapper.set("enabled", false).eq("id", positionId);

        if (positionMapper.update(deletedPosition, positionUpdateWrapper) > 0) {
            return ResultVO.success("删除岗位成功", deletedPosition);
        }

        return ResultVO.error("删除失败，请稍后再试", deletedPosition);
    }

}
