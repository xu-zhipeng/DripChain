package com.dali.DripChain.controller;

import com.dali.DripChain.aop.UserOperate;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.User;
import com.dali.DripChain.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/Login")
public class LoginController {
    private static Logger log = LoggerFactory.getLogger(LoginController.class);
    @Resource
    private LoginService loginService;

    //     return "forward:/Login/main";  //跳转到另一个controller
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        System.out.println("进入登录页面");
        return "/login";
    }

    @UserOperate(moduleName = "登录注册模块", funName = "doLogin", operateDesc = "登录")
    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public String doLogin(String sUserName_login, String sPassword_login, String checkCode, Model model, HttpSession session) {
        System.out.println("验证码：" + session.getAttribute("checkCode"));
        if (Objects.equals(checkCode.trim().toLowerCase(), session.getAttribute("checkCode"))) {
            Company company = loginService.doCompanyLogin(sUserName_login, sPassword_login);
            Company sessionCompany = new Company();//company是PO对象  sessionCompany是VO对象
            if (company != null) {
                BeanUtils.copyProperties(company, sessionCompany);//通过复制将PO对象转成VO对象
                sessionCompany.setsPassword("密码清空");//密码清空
                session.setAttribute("Company", sessionCompany);
                return "redirect:/Index/index";
            } else {
                User user = loginService.doUserLogin(sUserName_login, sPassword_login);
                if (user != null) {
                    User sessionUser = new User();
                    BeanUtils.copyProperties(user, sessionUser);
                    BeanUtils.copyProperties(sessionUser.getCompany(), sessionCompany);
                    sessionCompany.setsPassword("密码清空");//根账户密码清空
                    sessionUser.setsPassword("密码清空");//密码清空
                    session.setAttribute("Company", sessionCompany);
                    session.setAttribute("User", sessionUser);
                    return "redirect:/Index/index";
                } else {
                    model.addAttribute("errorMessage", "用户名或密码错误!");
                }
            }
        } else {
            model.addAttribute("checkCodeError", "验证码错误!");
        }
        return "redirect:login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "login";
    }

    @UserOperate(moduleName = "登录注册模块", funName = "doRegister", operateDesc = "注册")
    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    public String doRegister(Company company, Model model, HttpServletResponse response, HttpServletRequest request) {
        if (company != null) {
            String sCompanyTelephone = request.getParameter("sCompanyTelephone");
            String sEmail = request.getParameter("sEmail");
            // System.out.println("输入的邮箱"+sEmail);
            if (Pattern.compile("0?(13|14|15|17|18|19)[0-9]{9}").matcher(sCompanyTelephone).matches()) {
                System.out.println("输入的手机号正确");
            } else {
                model.addAttribute("sCompanyTelephoneError", "输入的手机格式不正确");
                return "redirect:/Login/register";
            }
            if (Pattern.compile("\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}").matcher(sEmail).matches()) {
                System.out.println("邮箱输入正确");
            } else {
                model.addAttribute("sEmailError", "邮箱格式不正确");
                return "redirect:/Login/register";
            }
            int result = loginService.doRegister(company);
            if (result > 0) {
                try {
                    //设置response编码
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('注册成功！',location='/DripChain/Login/login')</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (result == -2) {
                try {
                    //设置response编码
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('用户名已存在！',location='/DripChain/Login/register')</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (result == -3) {
                try {
                    //设置response编码
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('该号码已存在！',location='/DripChain/Login/register')</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (result == -4) {
                try {
                    //设置response编码
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('该邮箱已存在！',location='/DripChain/Login/register')</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return "redirect:/Login/login";
    }

    @UserOperate(moduleName = "登录注册模块", funName = "logout", operateDesc = "退出")
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletResponse response) {
        session.invalidate();
        try {
            //设置response编码
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('退出成功！',location='/DripChain/Login/login')</script>");
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/Login/login";
    }

}
