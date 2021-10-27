package com.nijigen.server.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhaolimin
 * @date 2021/10/13
 * @apiNote jwt工具类
 */

@Component
public class JwtTokenUtil {


    private static final String CLAIM_KEY_USERNAME = "sub";
    private static final String CLAIM_KEY_CREATED = "created";
    @Value("${jwt.secret}")
    private String secret;
    @Value("${jwt.expiration}")
    private Long expiration;


    /**
     * 根据用户信息生成token
     *
     * @param userDetails
     * @return
     */
    public String generateToken(UserDetails userDetails) {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USERNAME, userDetails.getUsername());
        claims.put(CLAIM_KEY_CREATED, new Date());
        return generateToken(claims);
    }

    /**
     * 从token中获取登录用户名
     * @param token
     * @return
     */
    public String getUserNameFromToken(String token){
        String username;
        try {
            Claims claims = getClaimsFormToken(token);
            username = claims.getSubject();
        } catch (Exception e) {
            username = null;
        }
        return username;
    }

    /**
     * 验证token是否有效
     * @param token
     * @param userDetails
     * @return
     */
    public boolean validateToken(String token,UserDetails userDetails){
        String username = getUserNameFromToken(token);
        return username.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }


    /**
     * 判断token是否可以被刷新
     * @param token
     * @return
     */
    public boolean canRefresh(String token){
        return !isTokenExpired(token);
    }

    /**
     * 刷新token
     * @param token
     * @return
     */
    public String refreshToken(String token){
        Claims claims = getClaimsFormToken(token);
        claims.put(CLAIM_KEY_CREATED,new Date());
        return generateToken(claims);
    }

    /**
     * 判断token是否失效
     * @param token
     * @return
     */
    private boolean isTokenExpired(String token) {
        Date expireDate = getExpiredDateFromToken(token);
        return expireDate.before(new Date());
    }

    /**
     * 从token中获取过期时间
     * @param token
     * @return
     */
    private Date getExpiredDateFromToken(String token) {
        Claims claims = getClaimsFormToken(token);
        return claims.getExpiration();
    }

    /**
     * 从token中获取荷载
     * @param token
     * @return
     */
    private Claims getClaimsFormToken(String token) {
        Claims claims = null;
        try {
            claims = Jwts.parser()
                    .setSigningKey(secret)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return claims;
    }


    /**
     * 根据荷载生成JWT TOKEN
     *
     * @param claims
     * @return
     */
    private String generateToken(Map<String, Object> claims) {
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(generateExpirationDate())
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    /**
     * 生成token失效时间
     *
     * @return
     */
    private Date generateExpirationDate() {
        return new Date(System.currentTimeMillis() + expiration * 1000);
    }


    //private static final String CLAIM_KEY_USERNAME = "sub"; // 荷载中用户名的key
    //private static final String CLAIM_KEY_CREATED = "created"; // 荷载中jwt的创建时间key
    //
    //@Value("${jwt.secret}")
    //private String secret; // 配置文件中获取jwt的密钥
    //@Value("${jwt.expiration}")
    //private Long expiration; // 配置文件中获取jwt的过期时间
    //
    ///**
    // * 根据用户信息生成token（可供调用）
    // * @param userDetails
    // * @return token
    // */
    //public String generateToken(UserDetails userDetails){
    //
    //    // 创建一个map用来存token生成需要的条件。
    //    HashMap<String,Object> claims = new HashMap<>();
    //    claims.put(CLAIM_KEY_USERNAME, userDetails.getUsername());
    //    claims.put(CLAIM_KEY_CREATED, new Date());
    //
    //    return generateToken(claims);
    //}
    //
    ///**
    // * 根据荷载生成JWT的Token
    // * @param claims
    // * @return token
    // */
    //private String generateToken(Map<String,Object> claims) {
    //    return Jwts.builder()
    //            .setClaims(claims) // 装入荷载
    //            .setExpiration(generateExpirationDate()) // 设置失效时间，我们写一个方法来转
    //            .signWith(SignatureAlgorithm.HS512, secret) // 密钥加密手段
    //            .compact(); // 生成
    //}
    //
    ///**
    // * 生成token失效时间
    // * @return token失效时间
    // */
    //private Date generateExpirationDate() {
    //    // 失效时间就是当前系统时间加上我们设置的token失效时间。
    //    return new Date(System.currentTimeMillis() + expiration*1000);
    //}
    //
    ///**
    // * 从token中获取登录用户名（可供调用）
    // * @param token
    // * @return 登录用户名
    // */
    //public String getUserNameFromToken(String token){
    //
    //    String username;
    //    try {
    //        // 由于我们的username是存在token的荷载中的，所以我们根据token先写个方法获得荷载。
    //        Claims claims = getClaimsFromToken(token);
    //        username = claims.getSubject();
    //    } catch (Exception e) {
    //        username = null;
    //    }
    //
    //    return username;
    //}
    //
    ///**
    // * 从token中获取荷载
    // * @param token
    // * @return 当前token荷载
    // */
    //private Claims getClaimsFromToken(String token) {
    //
    //    Claims claims = null;
    //
    //    try {
    //        claims = Jwts.parser()
    //                .setSigningKey(secret) // 先将token根据密钥解码
    //                .parseClaimsJws(token) // 然后通过token获得荷载
    //                .getBody();// 这个body就是荷载
    //    } catch (ExpiredJwtException e) {
    //        e.printStackTrace();
    //    }
    //
    //    return claims;
    //}
    //
    ///**
    // * 判断token是否有效（可供调用）
    // * @param token
    // * @param userDetails 获得其中的username和token荷载里的username是否相同
    // * @return 是否有效
    // */
    //public boolean validateToken(String token, UserDetails userDetails) {
    //
    //    String username = getUserNameFromToken(token);
    //    return username.equals(userDetails.getUsername()) && !isTokenExpired(token);
    //}
    //
    ///**
    // * 判断token是否过期
    // * @param token
    // * @return token是否过期
    // */
    //private boolean isTokenExpired(String token) {
    //
    //   Date expiredDate = getExpiredDateFromToken(token);
    //   return expiredDate.before(new Date()); // 判断token中的失效时间是否是在我们当前时间前面，是的话就是失效
    //}
    //
    ///**
    // * 从token中获取token失效时间
    // * @param token
    // * @return token失效时间
    // */
    //private Date getExpiredDateFromToken(String token) {
    //
    //    Claims claims = getClaimsFromToken(token);
    //    return claims.getExpiration();
    //}
    //
    ///**
    // * 判断token是否可以被刷新（可供调用）
    // * @param token
    // * @return
    // */
    //public boolean isCanFresh(String token){
    //    return !isTokenExpired(token); //如果token过期就可以被刷新
    //}
    //
    ///**
    // * 刷新token（可供调用）
    // * @param token
    // * @return 刷新过期时间后的token
    // */
    //public String refreshToken(String token) {
    //
    //    // 通过当前可刷新的token获得其荷载
    //    Claims claims = getClaimsFromToken(token);
    //    claims.put(CLAIM_KEY_CREATED, new Date());
    //
    //    return generateToken(claims);
    //}

}
