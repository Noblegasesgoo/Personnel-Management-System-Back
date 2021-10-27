package com.nijigen.server.config.security.component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nijigen.server.pojo.VO.ResultVO;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 当未登录或者token失效时，再访问接口时的自定义返回结果
 */

@Component
public class RestAuthorizationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException {

        response.setCharacterEncoding("UTF-8"); // 设置响应字符集
        response.setContentType("application/json"); // 设置响应上下文格式
        PrintWriter out = response.getWriter(); // 获得输出流

        // 设置自定义消息
        ResultVO result = ResultVO.error("尚未登录，请重新登录");
        result.setCode(401);

        out.write(new ObjectMapper().writeValueAsString(result));
        out.flush();
        out.close();
    }
}
