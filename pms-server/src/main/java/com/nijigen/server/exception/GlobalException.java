package com.nijigen.server.exception;

import com.nijigen.server.pojo.VO.ResultVO;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

/**
 * @author zhaolimin
 * @date 2021/10/22
 * @apiNote 全局异常处理
 */

@RestControllerAdvice
public class GlobalException {

    @ExceptionHandler(SQLException.class)
    public ResultVO mySqlException(SQLException e){

        if (e instanceof SQLIntegrityConstraintViolationException){
            return ResultVO.error("该数据有关联数据，操作失败！");
        }

        return ResultVO.error("数据库异常，操作失败！");
    }
}
