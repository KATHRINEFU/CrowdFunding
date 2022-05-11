package com.crowdfunding.mvc.handler;

import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.entity.Admin;
import com.crowdfunding.service.api.AdminService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
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

    @RequestMapping("/admin/update.html")
    public String update(
            Admin admin,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("keyword") String keyword){

        adminService.update(admin);
        return "redirect: /admin/get/page.html?pageNum="+pageNum+"&keyword="+keyword; 
    }

    @RequestMapping("/admin/to/edit/page.html")
     public String toEditPage(
             @RequestParam("adminId") Integer adminId,
             @RequestParam("pageNum") Integer pageNum,
             @RequestParam("keyword") String keyword,
             ModelMap modelMap
    ){
        // 1.根据adminId查询admin对象
        Admin admin = adminService.getAdminById(adminId);
        // 2.将admin对象存入模型
        modelMap.addAttribute("admin", admin);
        return "admin-edit";
    }

    @RequestMapping("admin/save.html")
    public String save(Admin admin){
        adminService.saveAdmin(admin);
        return "redirect: /admin/get/page.html?pageNum="+Integer.MAX_VALUE;
    }

    @RequestMapping("/admin/remove/{adminId}/{pageNum}/{keyword}.html")
    public String remove(
            @PathVariable("adminId") Integer adminId,
            @PathVariable("pageNum") Integer pageNum,
            @PathVariable("keyword") String keyword){
        //执行删除
        adminService.remove(adminId);
        //页面跳转 回到分页页面
        //直接返回admin-page会无法显示分页数据
        //返回/admin/get/page一旦刷新界面会重新删除数据，影响性能
        //重定向到/admin/get/page，附加pageNum和keyword

        return "redirect: /admin/get/page.html?pageNum="+pageNum+"&keyword="+keyword;
    }

    @RequestMapping("/admin/get/page.html")
    public String getPageInfo(
            //请求没有携带对应参数时，使用默认值
            @RequestParam(value = "keyword", defaultValue = "") String keyword,
            //pageNum默认第一页
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            //pageSize默认5页
            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
            ModelMap modelMap
    ){
        //使用service方法获取page info
        PageInfo<Admin> pageInfo = adminService.getPageInfo(keyword, pageNum, pageSize);
        System.out.println("adding data to pageInfo");
        //将pageInfo对象存入模型
        modelMap.addAttribute(CrowdConstant.ATTR_NAME_PAGE_INFO, pageInfo);
        return "admin-page";
    }

    @RequestMapping("/admin/do/logout.html")
    public String doLogout(HttpSession session){
        session.invalidate(); //强制session失效
        return "redirect:/admin/to/login/page.html";
    }
     
    @RequestMapping("/admin/do/Login.html") //根据jsp登陆表单提交的信息
    public String doLogin(
            @RequestParam("loginAcct") String loginAcct,
            @RequestParam("userPswd") String userPswd,
            HttpSession session
    ) {
        System.out.println("开始adminHandler");
        // 1.调用service方法执行登录检查
        // 返回admin对象说明登录成功，否则会抛出异常
        Admin admin = adminService.getAdminByLoginAcct(loginAcct, userPswd);

        // 2.将登录成功返回的admin对象存入Session域
        session.setAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN, admin);
        return "admin-main";
    }
}
