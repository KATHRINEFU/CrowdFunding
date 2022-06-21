package com.crowdfunding.spring.boot.handler;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName HelloHandler
 * @Description TODO
 * @Author katefu
 * @Date 6/21/22 11:26 PM
 * @Version 1.0
 **/

@RestController
public class HelloHandler {
    @RequestMapping("/hello")
    public String Hello() {
        return "Hello SpringBoot";
    }
}
