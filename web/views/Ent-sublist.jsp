<%--
  Created by IntelliJ IDEA.
  User: chenkui
  Date: 2018/11/13
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>
<%@ page import="com.dali.DripChain.entity.Company" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Company company = (Company) session.getAttribute("Company");//取到公司登录的信息

%>
<html>
<head>
    <title>水滴链 | 子用户列表</title>
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
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">子用户列表</strong> / <small>子用户列表</small></div>
            </div>

            <hr>
            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <tr>
                                <div class="am-g">
                                    <div class="am-u-lg-6">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/User/addsubView" type="button" class="am-btn am-btn-primary am-btn-xs">
                                                <span class="am-icon-plus"></span>添加</a>
                                        </div>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/User/subList" method="get">
                                    <div class="am-u-lg-6">
                                        <div class="am-input-group">
                                            <input type="text" class="am-from-field" name="sUsername" placeholder="请输入子用户名">
                                            <span class="am-input-group-btn">
                                               <input type="submit" class="am-btn am-btn-primary am-btn-xs" value="查询子用户"></input>
                                                   </span>
                                        </div>
                                    </div>
                                    </form>
                                </div>
                            </tr>
                            <thead>
                            <tr>
                                <th class="table-title">公司名</th>
                                <th class="table-title ">用户名</th>
                                <th class="table-title ">昵称</th>
                                <th class="table-title">邮箱</th>
                                <th class="table-title">权限</th>
                                <th class="table-set">电话</th>
                                <th class="table-set">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${pageBean.list}">
                            <tr>
                                <td>${user.company.sCompanyName}</td>
                                <td class="am-hide-sm-only">${user.sUsername}</td>
                                <td class="am-hide-sm-only">${user.sNickName}</td>
                                <td class="am-hide-sm-only">${user.sEmail}</td>
                                <td class="am-hide-sm-only">${user.sUserRight}</td>
                                <td class="am-hide-sm-only">${user.sTelephone}</td>
                                <td>
                                    <div class="am-btn-toolbar">
                                        <div class="am-btn-group am-btn-group-xs">
                                            <a href="${pageContext.request.contextPath}/User/updatasubView/${user.id}" type="button" class="am-btn am-btn-primary am-btn-xs">
                                                <span class="am-icon-pencil-square-o"></span>编辑</a>
                                            <a href="/DripChain/User/deleSub?userId=${user.id}" onclick="return confirm('确定删除？')" type="button" class="am-btn am-btn-primary am-btn-xs">
                                                <span class="am-icon-trash-o" ></span>删除</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="am-cf">
                            共 ${pageBean.totalRecord} 条警报，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
                            <div class="am-fr">
                                <ul class="am-pagination">
                                    <%--当前不是第一页--%>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum > 1}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/User/subList/${pageBean.pageNum-1}">«</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/User/subList/${pageBean.pageNum-1}">«</a>
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
                                                <a href="${pageContext.request.contextPath}/User/subList/${i}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/User/subList/${pageBean.pageNum+1}">»</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/User/subList/${pageBean.pageNum+1}">»</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                        </div>
                        <hr />
                        <p>注：.....</p>
                    </form>
                </div>

            </div>
        </div>

        <footer class="admin-content-footer">
            <hr>
            <p class="am-padding-left">© 2015级毕业小组</p>
        </footer>
        <!-- content end -->


        <a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

        <footer>
            <hr>
            <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
        </footer>
    </div>
</div>

      <a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
         data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

      <!--[if lt IE 9]>

      <![endif]-->

      <!--[if (gte IE 9)|!(IE)]><!-->

      <!--<![endif]-->
</body>
</html>
