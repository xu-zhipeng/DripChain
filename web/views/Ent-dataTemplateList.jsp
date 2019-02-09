<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>水滴链 | 设备分组</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <!--引入amzaeui资源-->
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <!--引入js的时候要注意，必须先引入jQuery，再引入amazeui，因为这个框架是基于jQuery开发的-->
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <script src="/DripChain/views/static/js/jquery.min.js"></script>
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
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
        $(function () {     //下拉框js
            $("#list ul").hide();   ////初始化隐藏状态
            $("#xist li a").click(function () {
                if ($(this).next("ul").is(":visible")) {
                    $(this).next("ul").slideUp(100);
                } else {
                    // $("#xiala ul").slideUp(100);//打开之前把其他的关掉
                    $(this).next("ul").slideDown(100);
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
                    <strong class="am-text-primary am-text-lg">数据模板列表</strong> /
                    <small>DataTemplate List</small>
                </div>
            </div>
            <script>
                $(function () {
                    var DataTemplateMessage = "${param.DataTemplateMessage}";
                    if (!$.isEmptyObject(DataTemplateMessage)) {
                        alert(DataTemplateMessage);
                        history.back();
                    }
                    var delDataTemplateMessage = "${param.delDataTemplateMessage}";
                    if (!$.isEmptyObject(delDataTemplateMessage)) {
                        alert(delDataTemplateMessage);
                    }
                });
            </script>

            <div class="am-g">
                <div class="am-u-sm-12">
                    <!--
                    <a href="Ent-addDevice.jsp">
                      <button type="button" class="am-btn am-btn-primary am-btn-xs">添加</button></a>-->
                    <a href="${pageContext.request.contextPath}/DataManage/addDataTemplate" type="button"
                       class="am-btn am-btn-primary am-btn-xs">
                        <span class="am-icon-plus"></span>添加</a>
                    <ul class="am-list am-list-static am-list-border">
                        <c:forEach var="li" items="${pageBean.list}">
                            <li>
                                <i class="am-icon-home am-icon-fw"></i>
                                <div class="am-topbar-right">
                                    <div class="am-btn-group am-btn-group-xs">
                                        <a href="${pageContext.request.contextPath}/DataManage/editDataTemplate/${li.id}" class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                                data-am-modal="{target: '#my-alert'}"><span
                                                class="am-icon-pencil-square-o"></span>编辑
                                        </a>
                                        <a   href="${pageContext.request.contextPath}/DataManage/delDataTemplate/${li.id}" onclick="return confirm('确定删除？')"
                                                class="am-btn am-btn-default am-btn-xs am-hide-sm-only am-text-danger"
                                                data-am-modal="{target: '#my-delect'}"><span
                                                class="am-icon-trash-o"></span>
                                            删除
                                        </a>
                                    </div>
                                </div>
                                <a style="display: inline-block;" href="${pageContext.request.contextPath}/DataManage/getDataTemplate?iDataTemplateId=${li.id}">${li.sTemplateName}</a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="am-cf">
                        共 ${pageBean.totalRecord} 个分组，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
                        <div class="am-fr">
                            <ul class="am-pagination">
                                <%--当前不是第一页--%>
                                <c:choose>
                                    <c:when test="${pageBean.pageNum > 1}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/Device/deviceGroupList/${pageBean.pageNum-1}">«</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="am-disabled">
                                            <a href="${pageContext.request.contextPath}/Device/deviceGroupList/${pageBean.pageNum-1}">«</a>
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
                                            <a href="${pageContext.request.contextPath}/Device/deviceGroupList/${i}">${i}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/Device/deviceGroupList/${pageBean.pageNum+1}">»</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="am-disabled">
                                            <a href="${pageContext.request.contextPath}/Device/deviceGroupList/${pageBean.pageNum+1}">»</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <!-- content end -->
</div>
</body>
</html>