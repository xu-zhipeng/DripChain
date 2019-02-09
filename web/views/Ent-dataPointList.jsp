<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>

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
                <script>
                    $(function () {
                        var DataTemplateMessage = "${requestScope.DataTemplateMessage}";
                        if (!$.isEmptyObject(DataTemplateMessage)) {
                            alert(DataTemplateMessage);
                            history.back();
                        }
                        var delDataPointMessage = "${param.delDataPointMessage}";
                        if (!$.isEmptyObject(delDataPointMessage)) {
                            alert(delDataPointMessage);
                        }
                    });
                </script>
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">数据点列表</strong> /
                    <small>DataPoint List</small>
                </div>
            </div>

            <hr>

            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-6">
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <a href="${pageContext.request.contextPath}/DataManage/addDataPoint?iDataTemplateId=${iDataTemplateId}" type="button" class="am-btn am-btn-success am-round">
                                <span class="am-icon-plus"></span> 新增</a>
                        </div>
                        <div class="am-btn-group am-btn-group-xs">
                            <button type="button" class="am-btn am-btn-danger am-round">
                                <span class="am-icon-trash-o"></span> 批量删除
                            </button>
                        </div>
                    </div>
                </div>
                <div class="am-u-sm-12 am-u-md-3">
                    <!-- 空 -->
                </div>
                <div class="am-u-sm-12 am-u-md-3">
                    <form action="${pageContext.request.contextPath}/DataManage/getDataTemplate" method="get">
                        <div class="am-input-group am-input-group-sm">
                            <input type="hidden" name="id" value="${iDataTemplateId}">
                            <input type="text" name="searchWord" placeholder="数据点名称" class="am-form-field" value="${requestScope.searchWord}">
                            <span class="am-input-group-btn">
                                <input type="submit" class="am-btn am-btn-success" value="搜索"/>
                            </span>
                        </div>
                    </form>
                </div>
            </div>

            <div class="am-g">
                <div class="am-u-sm-12">
                    <form class="am-form">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <thead>
                            <tr><%--
                                <th class="table-check">
                                    <input type="checkbox"/>
                                </th>--%>
                                <th class="table-title">ID</th>
                                <th class="table-title">名称</th>
                                <th class="table-title">寄存器</th>
                                <th class="table-type">数据类型</th>
                                <th class="table-type">数值类型</th>
                                <th class="table-author">小数位数</th>
                                <th class="table-date">存储</th>
                                <th class="table-date">单位</th>
                                <th class="table-set">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageBean.list}" var="li">
                                <tr>
                                    <td>${li.id}</td>
                                    <td>${li.sName}</td>
                                    <td>${li.sRegister}</td>
                                    <c:choose>
                                        <c:when test="${li.iType==0}">
                                            <td>数值型</td>
                                        </c:when>
                                        <c:when test="${li.iType==1}">
                                            <td>开关型</td>
                                        </c:when>
                                        <c:when test="${li.iType==3}">
                                            <td>定位型</td>
                                        </c:when>
                                        <c:when test="${li.iType==4}">
                                            <td>字符型</td>
                                        </c:when>
                                        <c:otherwise>${li.iType}</c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${li.iValueKind==0}">
                                            <td>两字节无符号整数</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==1}">
                                            <td>两字节带符号整数</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==2}">
                                            <td>四字节无符号整数（AB CD）</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==3}">
                                            <td>四字节带符号整数（AB CD）</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==4}">
                                            <td>四字节浮点型 </td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==5}">
                                            <td>bit</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==6}">
                                            <td>四字节无符号整数（CD AB）</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==8}">
                                            <td>四字节有符号整数（CD AB）</td>
                                        </c:when>
                                        <c:when test="${li.iValueKind==10}">
                                            <td>四字节浮点型（CD AB）</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${li.iValueKind}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${li.iDecimalAccuracy}</td>
                                    <c:choose>
                                        <c:when test="${li.iStorage==0}">
                                            <td>不存储</td>
                                        </c:when>
                                        <c:when test="${li.iStorage==1}">
                                            <td>存储</td>
                                        </c:when>
                                        <c:when test="${li.iStorage==2}">
                                            <td>变化时存储</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${li.iStorage}</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${li.sUnit}</td>
                                    <td>
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <a href="${pageContext.request.contextPath}/DataManage/editDataPoint/${li.id}" class="am-btn am-btn-primary am-btn-xs">
                                                    <span class="am-icon-pencil-square-o"></span> 编辑</a>
                                                <a class="am-btn am-btn-success am-btn-xs am-hide-sm-only">
                                                    <span class="am-icon-copy"></span> 复制</a>
                                                <a href="${pageContext.request.contextPath}/DataManage/delDataPoint/${li.id}" class="am-btn am-btn-danger am-btn-xs am-hide-sm-only">
                                                    <span class="am-icon-trash-o"></span> 删除</a>
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
                                                <a href="${pageContext.request.contextPath}/DataManage/getDataTemplate/${pageBean.pageNum-1}?iDataTemplateId=${iDataTemplateId}">«</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/DataManage/getDataTemplate/${pageBean.pageNum-1}?iDataTemplateId=${iDataTemplateId}">«</a>
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
                                                <a href="${pageContext.request.contextPath}/DataManage/getDataTemplate/${i}?iDataTemplateId=${iDataTemplateId}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/DataManage/getDataTemplate/${pageBean.pageNum+1}?iDataTemplateId=${iDataTemplateId}">»</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/DataManage/getDataTemplate/${pageBean.pageNum+1}?iDataTemplateId=${iDataTemplateId}">»</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>
                        </div>
                        <hr/>
                        <p>注：.....</p>
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
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
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