package com.dali.DripChain.controller;

import com.dali.DripChain.aop.UserOperate;
import com.dali.DripChain.dao.CompanyDao;
import com.dali.DripChain.dao.UserDao;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.PageBean;
import com.dali.DripChain.entity.User;
import com.dali.DripChain.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/User")
public class UserController {
    @Resource
    private UserDao userDao;
    @Resource
    private UserService userService;
    @Resource
    private CompanyDao companyDao;

    @RequestMapping(value = "/addsubView", method = RequestMethod.GET)
    public String addsubView() {
        return "Ent-addsub";
    }

    @UserOperate(moduleName = "用户模块", funName = "doAdd", operateDesc = "添加子用户")
    @RequestMapping(value = "/doAdd", method = RequestMethod.POST)
    public String doAdd(User user, Model model, HttpServletResponse response, HttpServletRequest request, HttpSession session, String sEmail, String sTelephone) {
        if (user != null) {
            Company company = (Company) session.getAttribute("Company");//取登录用户
            // System.out.println(company);
            user.setCompany(userDao.<Company>findUnique("from Company where id=?", company.getId()));//把公司id插入到子用户表中
            //用来验证输入的邮箱是否正确
            sEmail = request.getParameter("sEmail");
            if (Pattern.compile("\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}").matcher(sEmail).matches()) {
                System.out.println("邮箱输入正确");
            } else {
                model.addAttribute("sEamilError", "邮箱格式不正确");
                return "redirect:/User/addsubView";
            }
            //用来验证输入的手机号码
            sTelephone = request.getParameter("sTelephone");
            if (Pattern.compile("0?(13|14|15|17|18|19)[0-9]{9}").matcher(sTelephone).matches()) {
                System.out.println("输入的手机号正确");
            } else {
                model.addAttribute("sTelephone", "输入的手机格式不正确");
                return "redirect:/User/addsubView";
            }
            int rs = userService.doAddSuser(user);
            //System.out.println(rs);
            if (rs > 0) {
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('添加成功！',location='/DripChain/User/subList')</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (rs == -2) {
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('子用户已存在！',location='/DripChain/User/addsubView)</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (rs == -3) {
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('该邮箱已存在！',location='/DripChain/User/addsubView)</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (rs == -4) {
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('该号码已存在！',location='/DripChain/User/addsubView)</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else if (rs == -5) {
                try {
                    response.setContentType("text/html;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.println("<script>alert('该昵称已存在！',location='/DripChain/User/addsubView)</script>");
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return "redirect:/User/subList";
    }

    /*
     *修改密码
     */
    @RequestMapping(value = "/upPwdView", method = RequestMethod.GET)
    //获得修改密码这个视图
    public String upPwdView() {
        System.out.println("开始修改密码");
        return "Ent-subpassword";
    }

    @UserOperate(moduleName = "用户模块", funName = "upPwd", operateDesc = "修改密码")
    @RequestMapping(value = "/upPwd", method = RequestMethod.POST)
    //获得修改密码这个请求
    public String upPwd(Model model, HttpServletResponse response, HttpServletRequest request, HttpSession session, String newPassword, String newsPasswordConfirm) {
        User user = (User) session.getAttribute("User");
        //System.out.println("取到的子用户"+user);
        Company company = (Company) session.getAttribute("Company");
        //System.out.println("取到的根用户"+company);

        if (user != null) {
            int id = user.getId();//登录子用户的id
            newPassword = request.getParameter("newsPassword");
            newsPasswordConfirm = request.getParameter("newsPasswordConfirm");
            if (newPassword.equals(newsPasswordConfirm) == true) {
                System.out.println("两次输入的密码一致");
            } else {
                model.addAttribute("PwdError", "两次输入的密码不一致");
                return "redirect:/User/upPwdView";
            }
            User user1 = userDao.get(id);//取出要修改的用户
            user1.setsPassword(newPassword);
            int rs = userService.updatasub(user1);
            if (rs == -1) {
                System.out.println("修改失败！");
            }
        } else if (company != null) {
            int id = company.getId();
            newPassword = request.getParameter("newsPassword");
            newsPasswordConfirm = request.getParameter("newsPasswordConfirm");
            if (newPassword.equals(newsPasswordConfirm) == true) {
                System.out.println("两次输入的密码一致");
            } else {
                model.addAttribute("PwdError", "两次输入的密码不一致");
                return "redirect:/User/upPwdView";
            }
            Company company1 = companyDao.get(id);
            company1.setsPassword(newPassword);
            int rs = userService.updataCompany(company1);
            if (rs == -1) {
                System.out.println("修改失败！");
            }
        }
        return "redirect:/Login/logout";

    }

    /*
     *显示子用户列表和查询子用户
     */
    @RequestMapping(value = {"/subList", "/subList/{pageNum}"}, method = RequestMethod.GET)
    public String subList(@PathVariable(value = "pageNum", required = false) Integer pageNum, String sUsername, Map<String, Object> map, HttpSession session) {
        Company company = (Company) session.getAttribute("Company");//取登录根用户
        System.out.println("sUsername" + sUsername);
        if (sUsername != null) {
            session.setAttribute("subListsUsername", sUsername);
        }
        sUsername = (String) session.getAttribute("subListsUsername");
        if (sUsername == null) {
            sUsername = "";
        }
        if (pageNum == null || pageNum <= 0) {
            pageNum = 1;
        }
        int pageSize = 3;//设置每页显示的数据条数
        PageBean<User> pageBean = userService.findPage(pageNum, pageSize, sUsername, company.getId());
        map.put("pageBean", pageBean);
        map.put("sUsername", sUsername);
        return "Ent-sublist";
    }

    //删除子用户
    @RequestMapping(value = "/deleSub", method = RequestMethod.GET)
    public String deleSub(int userId, Model model, HttpServletResponse response) {
        int rs = userService.doDelesub(userId);
        if (rs == -1) {

            //删除成功
        } else if (rs == -2) {
            //删除失败
        }
        return "redirect:/User/subList";
    }

    /*
     *修改子用户的信息
     */
    //获得编辑子用户的页面
    @RequestMapping(value = "/updatasubView/{id}", method = RequestMethod.GET)
    public String updatasubView(@PathVariable(value = "id", required = false) Integer id, Map<String, Object> map, HttpSession session) {
        User user = userDao.findUnique("from User where id=?", id);
        Company company = (Company) session.getAttribute("Company");
        map.put("user", user);
        return "Ent-updatasub";
    }

    //获得编辑子用户的请求
    @UserOperate(moduleName = "用户模块", funName = "updatasub", operateDesc = "编辑子用户")
    @RequestMapping(value = "/updatasub", method = RequestMethod.POST)
    public String updatasub(Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response) {
        Company company = (Company) session.getAttribute("Company");
        //System.out.println("adada"+company);
        int id = Integer.parseInt(request.getParameter("updataSubuser"));
        // User user=userDao.findUnique("from User where id=?",id);
        //System.out.println("子用户"+user);
        String newPhone = request.getParameter("newPhone");
        String newEmail = request.getParameter("newEmail");
        String newNickname = request.getParameter("newNickname");
        System.out.println(newEmail);
        User user = userDao.get(id);
        user.setsEmail(newEmail);
        user.setsTelephone(newPhone);
        user.setsNickName(newNickname);
        //System.out.println(user);
        int rs = userService.updatasub(user);
        if (rs == -1) {
            try {
                response.setContentType("text/html;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('修改失败！')</script>");
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/User/subList";
    }

    /*
     *显示用户信息
     *
     */
    @RequestMapping(value = "/showInfo", method = RequestMethod.GET)
    public String showInfo(Model model, HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("User");
        System.out.println("子用户信息" + user);
        Company company = (Company) session.getAttribute("Company");
        if (company != null) {
            int id = company.getId();
            userService.showcompany(id);
        } else if (user != null) {
            int id = user.getId();
            userService.showsub(id);
        }
        return "Ent-userinfo";
    }
}



