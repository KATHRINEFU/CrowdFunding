package com.crowdfunding.mvc.handler;

import com.crowdfunding.service.api.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 * @ClassName MenuHandler
 * @Description Menu Handler
 * @Author katefu
 * @Date 5/20/22 12:37 AM
 * @Version 1.0
 **/

@Controller
public class MenuHandler {

    @Autowired
    private MenuService menuService;
}
