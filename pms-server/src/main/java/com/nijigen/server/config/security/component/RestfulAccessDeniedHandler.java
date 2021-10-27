package com.nijigen.server.config.security.component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nijigen.server.pojo.VO.ResultVO;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 当前用户访问一个其没有权限的接口时的自定义返回结果。
 */

@Component
public class RestfulAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException {


        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        ResultVO result = ResultVO.error(403,"权限不足！请联系管理员！",null);

        out.write(new ObjectMapper().writeValueAsString(result));
        out.flush();
        out.close();
    }
}
