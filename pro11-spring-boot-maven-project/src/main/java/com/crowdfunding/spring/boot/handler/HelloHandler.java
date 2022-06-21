package com.crowdfunding.spring.boot.handler;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName HelloHandler
 * @Description TODO
 * @Author katefu
 * @Date 6/21/22 10:53 PM
 * @Version 1.0
 **/

@RestController
//Controller+ResponseBody
public class HelloHandler {
    @RequestMapping("/get/spring/boot/hello/message")
    public String getMessage(){
        return "first blood!!";
    }
}
