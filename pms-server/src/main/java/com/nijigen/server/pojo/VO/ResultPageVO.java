package com.nijigen.server.pojo.VO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author zhaolimin
 * @date 2021/10/25
 * @apiNote 分页返回公共对象
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultPageVO {

    // 总条数
    private long total;

    // 数据
    private List<?> data;
}
