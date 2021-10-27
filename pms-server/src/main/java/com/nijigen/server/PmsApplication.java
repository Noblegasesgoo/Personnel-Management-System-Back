package com.nijigen.server;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 项目启动类
 */

@SpringBootApplication
@MapperScan("com.nijigen.server.mapper")
public class PmsApplication {

    public static void main(String[] args) {
        SpringApplication.run(PmsApplication.class, args);
    }
}
