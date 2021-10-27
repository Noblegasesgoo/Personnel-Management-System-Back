package com.nijigen.server.config.security.component;

import com.nijigen.server.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote jwt 登录授权过滤器
 */
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {

    @Value("${jwt.tokenHeader}")
    private String tokenHeader;

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    /**
     * 相当于前置拦截
     * @param request
     * @param response
     * @param filterChain
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String authHeader = request.getHeader(tokenHeader);
        //存在token
        if (null != authHeader && authHeader.startsWith(tokenHead)) {

            // 存在token的话字符串截取
            String authToken = authHeader.substring(tokenHead.length());
            // 从token中获得username
            String username = jwtTokenUtil.getUserNameFromToken(authToken);

            // 拿到了username但是spring-security的全局上下文中拿不到用户对象，也就是未登录
            if (null != username && null == SecurityContextHolder.getContext().getAuthentication()) {

                // 我们拿到UserDetails，相当于登录了
                UserDetails userDetails = userDetailsService.loadUserByUsername(username);

                //验证token是否有效，重新设置用户对象
                if (jwtTokenUtil.validateToken(authToken, userDetails)) {

                    // 有效要重新给token放置到用户对象中
                    UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                }
            }
        }

        filterChain.doFilter(request, response);

        // ---------------------------------------- 获取token方式一
        //// 预检请求判断是否放行
        //String method = request.getMethod();
        //if (method.equalsIgnoreCase("OPTIONS")){
        //    return;
        //}
        //
        //// 通过request获取header
        //String authHeader = request.getHeader("token");
        //System.out.println(authHeader);
        //// 正常前端请求中的key就是tokenHeader中的值，value就是tokenHead的值 + 空格 + jwt令牌
        //if (authHeader != null && authHeader.startsWith(tokenHead)) {
        //
        //    // 存在token的话字符串截取
        //    String authToken = authHeader.substring(tokenHead.length());
        //    // 从token中获得username
        //    String username = jwtTokenUtil.getUserNameFromToken(authToken);
        //
        //    // 拿到了username但是spring-security的全局上下文中拿不到用户对象，也就是未登录
        //    if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
        //
        //        // token存在但是未登录
        //        // 我们拿到UserDetails，相当于登录了
        //        UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        //
        //        // 判断token是否有效
        //        if (jwtTokenUtil.validateToken(authToken, userDetails)){
        //            // 有效要重新给token放置到用户对象中
        //            UsernamePasswordAuthenticationToken authenticationToken =
        //                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        //            authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        //            SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        //        }
        //    }
        //}
        //
        //filterChain.doFilter(request,response);

    }
}
