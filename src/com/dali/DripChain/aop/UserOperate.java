package com.dali.DripChain.aop;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.RetentionPolicy;


@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface UserOperate {

    //模块名
    String moduleName() default "";
    //方法名
    String funName() default "";
    //操作内容
    String operateDesc() default "";
}

