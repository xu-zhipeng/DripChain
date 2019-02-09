<%--
  Created by IntelliJ IDEA.
  User: chenkui
  Date: 2018/11/13
  Time: 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>水滴链 | 子用户修改</title>
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
<!--头部开始-->
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
                    <strong class="am-text-primary am-text-lg">子用户修改</strong>
                    <small>子用户修改</small>
                </div>
            </div>
            <hr/>
            <div class="am-tabs data-am-tabs">
                <div class="am-tabs-bd">
                    <form class="am-form" action="${pageContext.request.contextPath}/User/updatasub" method="post">
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">用户名:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="hidden" name="updataSubuser" value="${user.id}">
                                <input type="text" class="am-input-sm am-radius" name="sUsername" placeholder="${user.sUsername}" disabled>
                            </div>
                        </div>
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">电话:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="text" class="am-input-sm am-radius" name="newPhone" placeholder="请输入手机联系方式">
                            </div>
                        </div>
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">邮箱:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="email" class="am-input-sm am-radius" name="newEmail" placeholder="请输入新的邮箱">
                            </div>
                        </div>
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">昵称:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="text" class="am-input-sm am-radius" name="newNickname"placeholder="请输入新的昵称">
                            </div>
                        </div>
                        <div class="am-margin am-text-center">
                            <input type="submit" class="am-btn am-btn-primary am-btn-xs">
                            <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="return confirm('确定放弃修改吗？')" >放弃修改</button>
                        </div>
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
