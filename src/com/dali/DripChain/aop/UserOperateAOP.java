package com.dali.DripChain.aop;

import com.dali.DripChain.dao.UserOperateLogDao;
import com.dali.DripChain.entity.Company;
import com.dali.DripChain.entity.User;
import com.dali.DripChain.entity.UserOperateLog;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * 处理用户操作日志切面类
 * @author HuYa
 *
 */
@Aspect
@Component
public class UserOperateAOP {

    static Company globalCompany = new Company();
    static {
        globalCompany.setId(-1);
        globalCompany.setsUserName("未登录");
        globalCompany.setsCompanyName("未登录");
    }

    @Resource
    private UserOperateLogDao userOperateLogDao;

    //本地异常日志记录对象
    private  static  final Logger logger = LoggerFactory.getLogger(UserOperateAOP. class);

    @Pointcut("@annotation(com.dali.DripChain.aop.UserOperate)")
    public void controllerAspect(){}

    //注：pointcut = "controllerAspect() && @annotation(annotation) &&args(object,..) ", argNames = "annotation,object"
    //上面这种方法  annotation变量中，可以获得试用直接是填入的参数的值。，但是会有问题，不能使用注解对每个方法都生效，没明白是
    //什么原因，所以希望还是尽量不要用

    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint)
    {
        System.out.println("=====前置通知开始=====");
        System.out.println("请求方法:" + joinPoint.getSignature().getName());

    }


    //只有当连接点正常退出时才调用
    @AfterReturning(pointcut = "controllerAspect()")
    public void doAfterReturning(JoinPoint joinPoint) {
        System.out.println("AfterReturning executed。只有当连接点正常退出时才调用");
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Company company = (Company)request.getSession().getAttribute("Company");
        User user = (User)request.getSession().getAttribute("User");
        if(company==null){
            company = globalCompany;
        }
        try {
            //数据库日志
            UserOperateLog userOperateLog = new UserOperateLog();
            String custId = String.valueOf(company.getId());
            String custName = company.getsUserName();
            if(user!=null){//用户名对整个数据库都唯一
               custName = user.getsUsername();
            }
            String companyName = company.getsCompanyName();
            String moduleName = this.getMethodModuleName(joinPoint);
            String funName = this.getMethodFunName(joinPoint);
            String operateDesc = this.getMethodOperateDesc(joinPoint);
            String ipAddress = this.getIpAddr(request);
            String requestUri = request.getRequestURI();

            userOperateLog.setCustId(custId);
            userOperateLog.setCustName(custName);
            userOperateLog.setCompanyName(companyName);
            userOperateLog.setModuleName(moduleName);
            userOperateLog.setFunName(funName);
            userOperateLog.setOperateDesc(operateDesc);
            userOperateLog.setIpAddress(ipAddress);
            userOperateLog.setRequestUri(requestUri);
            userOperateLog.setOperateStatus("操作成功");
            userOperateLog.setCreateTime(new Date());
            //保存数据库
            userOperateLogDao.save(userOperateLog);
        } catch (Exception e) {
            e.printStackTrace();
            //记录本地异常日志
            logger.error("==后置通知异常==");
            logger.error("异常信息:{}", e.getMessage());
        }
    }

    //只有当连接点异常退出时才调用
    @AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
    public void afterThrowing(JoinPoint joinPoint, Throwable e) {
        System.out.println("AfterThrowing executed。 只有当连接点异常退出时才调用");
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Company company = (Company)request.getSession().getAttribute("Company");
        if(company==null){
            company = globalCompany;
        }
        try {
            //*========数据库日志=========*//
            UserOperateLog userOperateLog = new UserOperateLog();
            String custId = String.valueOf(company.getId());
            String custName = company.getsUserName();
            String companyName = company.getsCompanyName();
            String moduleName = this.getMethodModuleName(joinPoint);
            String funName = this.getMethodFunName(joinPoint);
            String operateDesc = this.getMethodOperateDesc(joinPoint);
            String ipAddress = this.getIpAddr(request);
            String requestUri = request.getRequestURI();

            userOperateLog.setCustId(custId);
            userOperateLog.setCustName(custName);
            userOperateLog.setCompanyName(companyName);
            userOperateLog.setModuleName(moduleName);
            userOperateLog.setFunName(funName);
            userOperateLog.setOperateDesc(operateDesc);
            userOperateLog.setIpAddress(ipAddress);
            userOperateLog.setRequestUri(requestUri);
            userOperateLog.setOperateStatus("抛出异常");
            userOperateLog.setCreateTime(new Date());
            //保存数据库
            userOperateLogDao.save(userOperateLog);
        } catch (Exception e1) {
            e1.printStackTrace();
            //记录本地异常日志
            logger.error("==异常通知异常==");
            logger.error("异常信息:{}", e.getMessage());
        }


    }

    /**
     * 获取IP地址
     * @param request
     * @return
     */
    private  String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public  static String getMethodModuleName(JoinPoint joinPoint)
            throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String moduleName = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    moduleName = method.getAnnotation(UserOperate. class).moduleName();
                    break;
                }
            }
        }
        return moduleName;
    }
    public  static String getMethodFunName(JoinPoint joinPoint)
            throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String funName = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    funName = method.getAnnotation(UserOperate. class).funName();
                    break;
                }
            }
        }
        return funName;
    }
    public  static String getMethodOperateDesc(JoinPoint joinPoint)
            throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String operateDesc = "";
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == arguments.length) {
                    operateDesc = method.getAnnotation(UserOperate. class).operateDesc();
                    break;
                }
            }
        }
        return operateDesc;
    }

}

