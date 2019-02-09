<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>水滴链</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js">
    </script>
    <script type="text/javascript">
        $(function () {     //下拉框js
            $("#xiala ul").hide();   ////初始化隐藏状态
            $("#alarm ul").show();
            $("#xiala li a").click(function () {
                if ($(this).next("ul").is(":visible")) {
                    $(this).next("ul").slideUp(100);
                } else {
                    // $("#favorite ul").slideUp(100);//打开之前把其他的关掉
                    $(this).next("ul").slideDown(100);
                }
            });
        });
        $(function () {     //侧边栏隐藏js
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

<!-- 头部 start -->
<jsp:include page="top.jsp" flush="true"/>
<!-- 头部 end -->

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="left.jsp" flush="true"/>
    <!-- sidebar end -->

    <!-- content start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">添加联系人</strong> /
                    <small>Add Contacts</small>
                </div>
            </div>

            <hr/>

            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>报警方式</strong>
                                <hr/>
                            </div>
                            <p>注：有三种报警方式，微信报警、电话报警、短信报警</p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>触发规则</strong>
                                <hr/>
                            </div>
                            <p> 默认触发规则为状态切换报警：</p>
                            <p>例：温度大于40报警；温度到50会触发报警推送并存储报警信息，再次上传“60”不会触发报警且不保存数据。温度到30，会触发恢复报警推送并存储报警消息。</p>
                        </div>
                    </div>

                </div>

                <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                    <form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/Alarm/doAddOrUpdateContact" method="post">
                        <div class="am-form-group">
                            <label for="sName" class="am-u-sm-3 am-form-label">姓名：
                            </label>
                            <div class="am-u-sm-6">
                                <input type="hidden" name="id" value="${contact.id}">
                                <input type="text" name="sName" id="sName" value="${contact.sName}" placeholder="姓名..." required>
                                <small>输入你的名字，让我们记住你。</small>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="sPhone" class="am-u-sm-3 am-form-label">手机：
                            </label>
                            <div class="am-u-sm-6">
                                <input type="text" name="sPhone" id="sPhone" value="${contact.sPhone}" placeholder="手机..." required>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="sEmail" class="am-u-sm-3 am-form-label">邮箱：
                            </label>
                            <div class="am-u-sm-6">
                                <input type="text" name="sEmail" id="sEmail" value="${contact.sEmail}" placeholder="邮箱..." required>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="sWeChat" class="am-u-sm-3 am-form-label">微信：
                            </label>
                            <div class="am-u-sm-6">
                                <input type="text" name="sWeChat" id="sWeChat" value="${contact.sWeChat}"  placeholder="微信...">
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="sNote" class="am-u-sm-3 am-form-label">备注：
                            </label>
                            <div class="am-u-sm-6">
                                <textarea rows="5" name="sNote" id="sNote" placeholder="备注..." >${contact.sNote}</textarea>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-9 am-u-sm-push-3">
                                <button type="submit" class="am-btn am-btn-primary">保存修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <footer class="admin-content-footer">
            <hr>
            <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
        </footer>

    </div>
    <!-- content end -->

</div>

<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
   data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

<footer>
    <hr>
    <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
</footer>

<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="/DripChain/views/static/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/DripChain/views/static/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="/DripChain/views/static/js/amazeui.min.js"></script>

<script src="/DripChain/views/static/js/app.js"></script>
</body>

</html>