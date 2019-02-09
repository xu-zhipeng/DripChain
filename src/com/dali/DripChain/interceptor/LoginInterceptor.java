package com.dali.DripChain.interceptor;

import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        System.out.println("进入拦截器 preHandle 方法...："+request.getRequestURL()+","+request.getRequestURI());
        HttpSession session =request.getSession();
        Company company = (Company)session.getAttribute("Company");
        User user = (User)session.getAttribute("User");
        if(company==null){
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('请先登录！',location='/DripChain/Login/login')</script>");
            out.flush();
            out.close();
            return false;
        }
        //Arrays.asList(new String[]{"/User/subList","User/addsubView"}).contains(request.getServletPath())
        if(request.getServletPath().contains("/User/subList")||request.getServletPath().contains("User/addsubView")){
            if(user!=null){
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('权限不足！',history.go(-1))</script>");
                out.flush();
                out.close();
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        System.out.println("进入拦截器 postHandle 方法...："+request.getRequestURL()+","+request.getRequestURI());
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//        System.out.println("进入拦截器 afterCompletion 方法...："+request.getRequestURL()+","+request.getRequestURI());
    }
}
