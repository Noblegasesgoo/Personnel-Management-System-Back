package com.nijigen.server.controller;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * @author zhaolimin
 * @date 2021/10/18
 * @apiNote 验证码获取api
 */


@RestController
@Api(value = "提供获取验证码接口", tags = "验证码管理")
public class CaptchaController {

    @Autowired
    private DefaultKaptcha defaultKaptcha;

    @ApiOperation(value = " 验证码获取")
    @GetMapping(value = "/captcha", produces = "image/jpeg")
    public void getCaptcha(HttpServletResponse response, HttpServletRequest request) {

        // 定义response输出类型为image/jpeg类型
        response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.
        response.setHeader("Cache-Control", "no-store, no-cache, mustrevalidate");
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        // Set standard HTTP/1.0 no-cache header.
        response.setHeader("Pragma", "no-cache");
        // return a jpeg
        response.setContentType("image/jpeg");

        // 获取验证码文本内容
        String captchaText = defaultKaptcha.createText();
        System.out.println("验证码内容：" + captchaText);

        request.getSession().setAttribute("captcha", captchaText);
        BufferedImage captchaImage = defaultKaptcha.createImage(captchaText);
        ServletOutputStream out = null;
        try {
            out =  response.getOutputStream();

            // 输出流输出图片，格式为jpg
            ImageIO.write(captchaImage, "jpg", out);
            // 输出出去后将图片刷出去
            out.flush();

        } catch (IOException e) {

            e.printStackTrace();
        } finally {

            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }


    }
}
