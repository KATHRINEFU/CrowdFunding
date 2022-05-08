package com.crowdfunding.mvc.handler;

import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.entity.Admin;
import com.crowdfunding.service.api.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * @ClassName AdminHandler
 * @Description TODO
 * @Author katefu
 * @Date 5/7/22 9:32 AM
 * @Version 1.0
 **/

@Controller
public class AdminHandler {
    @Autowired
    private AdminService adminService;

    @RequestMapping("/admin/do/logout.html")
    public String doLogout(HttpSession session){
        session.invalidate(); //强制session失效
        return "redirect:/admin/to/login/page.html";
    }
     
    @RequestMapping("/admin/do/Login.html") //根据jsp登陆表单提交的信息
    public String doLogin(
            @RequestParam("LoginAcct") String loginAcct,
            @RequestParam("UserPswd") String userPswd,
            HttpSession session
    ){
        //调用Service方法实行登陆检查
        //如果返回admin对象说明成功，如果账号密码不正确则抛出异常
        Admin admin = adminService.getAdminByLoginAcct(loginAcct,userPswd);
        //将登陆成功返回的admin对象存到session域
        session.setAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN, admin);
        return "redirect:/admin/to/main/page.html"; //去后台主页面
    }
}
