package com.dali.DripChain.controller;

import com.dali.DripChain.aop.UserOperate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/Index")
public class IndexController {
    private static Logger log = LoggerFactory.getLogger(LoginController.class);
    /*@Resource
    private LoginService loginService;*/
    //     return "forward:/Login/main";  //跳转到另一个controller

    @UserOperate(moduleName = "首页模块",funName = "index",operateDesc = "进入首页")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
        System.out.println("进入首页");
        return "index";
    }
}
