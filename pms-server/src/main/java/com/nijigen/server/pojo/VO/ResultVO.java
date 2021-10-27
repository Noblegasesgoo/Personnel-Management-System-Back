package com.nijigen.server.pojo.VO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 响应结果类
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultVO {

    private long code; // 状态码
    private String message; // 信息
    private Object data; // 数据

    /**
     * 成功返回
     * @return 公共返回对象
     * @param message
     */
    public static ResultVO success(String message){
        return new ResultVO(200, message, null);
    }

    /**
     * 成功返回
     * @param message
     * @param data
     * @return 公共返回对象
     */
    public static ResultVO success(String message, Object data){
        return new ResultVO(200, message, data);
    }

    /**
     * 成功返回
     * @param code
     * @param message
     * @param data
     * @return 公共返回对象
     */
    public static ResultVO success(long code, String message, Object data){
        return new ResultVO(code, message, data);
    }

    /**
     * 失败返回
     * @param message
     * @return 公共返回对象
     */
    public static ResultVO error(String message){
        return new ResultVO(500, message, null);
    }

    /**
     * 失败返回
     * @param message
     * @param data
     * @return 公共返回对象
     */
    public static ResultVO error(String message, Object data){
        return new ResultVO(500, message, data);
    }

    /**
     * 失败返回
     * @param code
     * @param message
     * @param data
     * @return 公共返回对象
     */
    public static ResultVO error(long code, String message, Object data){
        return new ResultVO(code, message, data);
    }


}
