package com.crowdfunding.mvc.interceptor;

import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.entity.Admin;
import com.crowdfunding.exception.AccessForbiddenException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @ClassName LoginInterceptor
 * @Description login in check interceptor
 * @Author katefu
 * @Date 5/8/22 10:11 AM
 * @Version 1.0
 **/
public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 1.通过request对象获取session对象
        HttpSession session = request.getSession();
        // 2.尝试从session域获取admin对象
        Admin admin = (Admin) session.getAttribute(CrowdConstant.ATTR_NAME_LOGIN_ADMIN);
        // 3.判断admin是否为空
        if(admin==null){
            // 4.抛出异常
            throw new AccessForbiddenException(CrowdConstant.MESSAGE_ACCESS_FORBIDDEN);
        }
        // 5.如果admin不为空，则返回true放行
        return true;
    }
}
