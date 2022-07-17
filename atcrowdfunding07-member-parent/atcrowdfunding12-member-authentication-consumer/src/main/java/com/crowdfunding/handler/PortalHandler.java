package com.crowdfunding.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName PortalHandler
 * @Description display main page (skip data first)
 * @Author katefu
 * @Date 7/18/22 12:35 AM
 * @Version 1.0
 **/

@Controller
public class PortalHandler {
    @RequestMapping("/")
    public String showPortalPage() {

        // 节省时间，省略加载数据部分

        return "portal";
    }
}
