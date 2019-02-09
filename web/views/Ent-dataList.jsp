<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>水滴链 | 设备状态</title>
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
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>

    <script type="text/javascript">
        $(function () {     //下拉框js
            $("#xiala ul").hide();   ////初始化隐藏状态
            $("#xiala li a").click(function () {
                if ($(this).next("ul").is(":visible")) {
                    $(this).next("ul").slideUp(100);
                } else {
                    // $("#xiala ul").slideUp(100);//打开之前把其他的关掉
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
            <div class="am-cf am-padding">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">设备数据</strong> /
                    <small>设备数据</small>
                </div>
            </div>
            <hr/>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;"><strong>数据保存</strong>
                                <hr/>
                            </div>
                            <p>数据保存：线上数据仅保存60天。</p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>关于设备上下线</strong>
                                <hr/>
                            </div>
                            <p>若3小时内设备无任何数据收发，透传云识别可能为异常，将主动踢掉设备，设备可以重连已保证数据接收。</p>
                        </div>
                    </div>


                </div>
                <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                    <form class="am-form am-form-horizontal">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <tr>
                                <div class="am-g">
                                    <div class="am-u-lg-6">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/Device/addDevice" type="button" class="am-btn am-btn-primary am-btn-xs">添加设备</a>
                                        </div>
                                    </div>
                                    <div class="am-u-lg-6">
                                        <form action="${pageContext.request.contextPath}/Device/dataList" method="get">
                                            <div class="am-input-group am-input-group-sm">
                                                <input type="text" name="searchWord" placeholder="请输入设备名" class="am-form-field" value="${requestScope.searchWord}">
                                                <span class="am-input-group-btn">
                                                    <input type="submit" class="am-btn am-btn-success" value="查询设备"/>
                                                </span>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </tr>
                            <thead>
                            <tr>
                                <th class="table-title ">设备名</th>
                                <th class="table-title ">设备编号</th>
                                <th class="table-title ">数据点名称</th>
                                <th class="table-title ">值</th>
                                <th class="table-title ">时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageBean.list}" var="li">
                            <tr>
                                <td class="am-hide-sm-only">${li.deviceName}</td>
                                <td class="am-hide-sm-only">${li.deviceId}</td>
                                <td class="am-hide-sm-only">${li.dataPointName}</td>
                                <td class="am-hide-sm-only">${li.value}</td>
                                <td class="am-hide-sm-only">${li.createTime}</td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="am-cf">
                            共 ${pageBean.totalRecord} 个设备，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
                            <div class="am-fr">
                                <ul class="am-pagination am-pagination-centered">
                                    <%--当前不是第一页--%>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum > 1}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/DataManage/dataList/${pageBean.pageNum-1}">«</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/DataManage/dataList/${pageBean.pageNum-1}">«</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:forEach begin="${pageBean.start}" end="${pageBean.end}" step="1" var="i">
                                        <c:if test="${pageBean.pageNum == i}">
                                            <li class="am-active">
                                                <a href="javascript:;">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${pageBean.pageNum != i}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/DataManage/dataList/${i}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/DataManage/dataList/${pageBean.pageNum+1}">»</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/DataManage/dataList/${pageBean.pageNum+1}">»</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- content end -->
</div>
</body>
</html>