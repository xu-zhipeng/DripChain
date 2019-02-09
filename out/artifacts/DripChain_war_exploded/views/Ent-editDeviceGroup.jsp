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
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <!-- 引入bootstrap.css和bootstrap.js -->
    <link rel="stylesheet" href="/DripChain/views/static/css/bootstrap.min.css">
    <script src="/DripChain/views/static/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css" />
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>

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
<%--头部  start--%>
<jsp:include page="top.jsp" flush="true"/>
<%--头部  end--%>

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="left.jsp" flush="true"/>
    <!-- sidebar end -->

    <!-- content start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">编辑设备分组</strong> /
                    <small>Edit DeviceGroup</small>
                </div>
            </div>
            <hr/>
            <script>
                $(function () {
                    var editDeviceGroupMessage = "${requestScope.editDeviceGroupMessage}";
                    if (!$.isEmptyObject(editDeviceGroupMessage)) {
                        alert(editDeviceGroupMessage);
                        history.back();
                    }
                });
            </script>
            <div class="am-tabs data-am-tabs">
                <div class="am-tabs-bd">
                    <form class="am-form" action="${pageContext.request.contextPath}/Device/doAddOrUpdateDeviceGroup" method="post">
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-4 am-text-right">分组名:</div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                <input type="hidden" name="id" value="${deviceGroup.id}">
                                <input type="text" name="sGroupName" value="${deviceGroup.sGroupName}" class="am-input-sm" placeholder="请输入设备分组名" required>
                            </div>
                        </div>
                        <div class="am-margin am-text-center">
                            <button type="submit" class="am-btn am-btn-primary am-btn-xs">提交</button>
                            <button type="reset" onclick="history.go(-1);" class="am-btn am-btn-primary am-btn-xs">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- content end -->
        <footer class="admin-content-footer am-text-center">
            <p class="am-padding-left">© 2015级毕业小组</p>
        </footer>
    </div>
</div>
</body>
</html>