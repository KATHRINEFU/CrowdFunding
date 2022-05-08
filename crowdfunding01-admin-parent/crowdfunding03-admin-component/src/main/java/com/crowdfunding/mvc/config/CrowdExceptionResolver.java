package com.crowdfunding.mvc.config;

import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.exception.AccessForbiddenException;
import com.crowdfunding.exception.LoginFailedException;
import com.crowdfunding.util.CrowdUtil;
import com.crowdfunding.util.ResultEntity;
import com.google.gson.Gson;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//ControllerAdvice表示当前类为基于注解的异常处理类，
@ControllerAdvice
public class CrowdExceptionResolver {

    // 未登录异常
    @ExceptionHandler(value = AccessForbiddenException.class)
    public ModelAndView resolveAccessForbiddenException(AccessForbiddenException exception,
                                                        HttpServletRequest request,
                                                        HttpServletResponse response) throws IOException {
        String viewName = "admin-login";
        return commonResolve(viewName,exception,request,response);
    }

    @ExceptionHandler(value = LoginFailedException.class)
    public ModelAndView resolveLoginFailedException(
            LoginFailedException exception, HttpServletRequest request, HttpServletResponse response
    ) throws IOException {
        String viewName = "admin-login"; //changable
        return commonResolve(viewName, exception, request, response);
    }

    @ExceptionHandler(value = ArithmeticException.class)
    public ModelAndView resolveMathException(
            ArithmeticException exception, HttpServletRequest request, HttpServletResponse response
    ) throws IOException {
        String viewName = "system-error"; //changable
        return commonResolve(viewName, exception, request, response);
    }

    //ExceptionHandler将一个具体异常类型h和一个方法关联起来（建立映射）
    @ExceptionHandler(value = NullPointerException.class)
    public ModelAndView resolveNullPointerException(
            //实际捕获到的异常类型，请求对象, 相应对象
            NullPointerException exception, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String viewName = "system-error";
        return commonResolve(viewName, exception, request, response);

    }

    private ModelAndView commonResolve(
            String viewName, Exception exception,
            HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        //1。判断请求类型（返回json或页面）
        boolean judgeRequest = CrowdUtil.judgeRequestType(request);

        //2. 如果是Ajax请求
        if(judgeRequest){
            //3. 创建ResultEntity对象
            ResultEntity<Object> resultEntity = ResultEntity.failed(exception.getMessage());
            //4. 创建Gson对象
            Gson gson = new Gson();
            //5. 将resultEntity对象转换为json字符串
            String json = gson.toJson(resultEntity);
            //6. 将json字符串作为响应体返回给浏览器
            response.getWriter().write(json);
            //7. 由于上面已经通过原生的response对象返回了相应，因此不提供ModelAndView对象
            return null;
        }

        //8. 如果不是Ajax请求则创建ModelAndView对象
        ModelAndView modelAndView = new ModelAndView();
        //9. 将Exception对象存入模型
        modelAndView.addObject(CrowdConstant.ATTR_NAME_EXCEPTION,exception);
        //10. 设置对应的视图名称
        modelAndView.setViewName(viewName);

        return modelAndView;
    }

}
