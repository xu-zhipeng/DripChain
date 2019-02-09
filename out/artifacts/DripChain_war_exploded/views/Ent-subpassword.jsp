<%--
  Created by IntelliJ IDEA.
  User: chenkui
  Date: 2018/11/12
  Time: 22:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>水滴链 | 修改密码</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css" />
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="/DripChain/views/static/js/my.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#xiala ul").hide();   ////初始化隐藏状态
            $("#xiala li a").click(function () {
                if ($(this).next("ul").is(":visible")) {
                    $(this).next("ul").slideUp(100);
                } else {
                    // $("#favorite ul").slideUp(100);//打开之前把其他的关掉
                    $(this).next("ul").slideDown(100);
                }
            });
        });
        $(function () {
            $("#admin-offcanvas").show();
            $(".am-icon-list.am-margin-left").click(function () {
                if ($("#admin-offcanvas").is(":visible")) {
                    $("#admin-offcanvas").hide();
                } else {
                    $("#admin-offcanvas").show();
                }
            });
        });
    </script>
</head>
<body>
!--头部开始-->
<jsp:include page="top.jsp" flush="true"/>
<!--头部结束-->
<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="left.jsp" flush="true"/>
    <!-- sidebar end -->

    <!-- content start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">修改密码</strong>
                    <small>修改密码</small>
                </div>
            </div>
            <hr/>
            <div class="am-tabs data-am-tabs">
                <div class="am-tabs-bd">
                    <form id="subpasswordForm" class="am-form" role="form" action="${pageContext.request.contextPath}/User/upPwd" method="post">
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">新密码:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="password" class="am-input-sm" name="newsPassword" id="pwd1"  placeholder="请输入新密码">
                            </div>
                        </div>
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">确认密码:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="password" class="am-input-sm" name="newsPasswordConfirm"id="pwd2" placeholder="请输入确认密码">
                                <small>${param.PwdError}</small>
                            </div>
                        </div>

                        <div class="am-margin am-text-center">
                            <input type="submit" class="am-btn am-btn-primary am-btn-xs">
                            <button type="button" class="am-btn am-btn-primary am-btn-xs"  onclick="history.back();">放弃修改</button>
                        </div>
                        <script>
                            //密码进行MD5加密传输
                            $("#subpasswordForm").submit(function () {
                                var pwd1 = $("#pwd1").val().MD5(32);
                                var pwd2 = $("#pwd2").val().MD5(32);
                                $("#pwd1").val(pwd1);
                                $("#pwd2").val(pwd2);
                            });
                        </script>
                    </form>
                </div>
            </div>
        </div>

        <footer class="admin-content-footer am-text-center">
            <p class="am-padding-left">© 2015级毕业小组</p>
        </footer>
    </div>
    <!-- content end -->
</div>

<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
   data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

<!--[if lt IE 9]>

<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->

</body>
</html>
