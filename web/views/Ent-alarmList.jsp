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
                <script>
                    $(function () {
                        var addAlarmMessage = "${param.addAlarmMessage}";
                        if (!$.isEmptyObject(addAlarmMessage)) {
                            alert(addAlarmMessage);
                            history.back();
                        }
                        var delAlarmMessage = "${param.delAlarmMessage}";
                        if (!$.isEmptyObject(delAlarmMessage)) {
                            alert(delAlarmMessage);
                        }
                    });
                </script>
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">警报列表</strong> /
                    <small>Alarm list</small>
                </div>
            </div>

            <hr>
            <script>
                $(function () {
                    //批量删除
                    $("#deleteAll").click(function () {
                        //获取标签
                        if ($("input[type=checkbox]:checked")[0] == null) {
                            alert("至少选择一条");
                            return;
                        }
                        var ids = new Array;
                        $("input[type=checkbox]:checked").filter(".checkChildren").each(function() {
                            ids.push($(this).val());
                            n = $(this).parents("tr").index() + 1; // 获取checkbox所在行的顺序
                            $("#datTable").find("tr:eq(" + n + ")").remove();
                        });
                        //alert(ids);
                        $.ajax({
                            url :"${pageContext.request.contextPath}/Alarm/delAllAlarm",
                            data : "ids=" + ids,    //最原始的传参  "fname=Henry&lname=Ford"   可以用json字符串传JSON.stringify(param) 但是后端接受参数需要用 @ResponseBody int[] ids  contentType必须声明为"application/json;charset=utf-8",不然会报错
                            type : "post",
                            dataType : "json",
                            success : function(data) {
                                if(data="0"){
                                    alert("删除成功！");
                                }else if(data="-1"){
                                    alert("系统错误，请稍后尝试！");
                                }else if(data="-2"){
                                    alert("id错误，非法进入！");
                                }else if(data="-3"){
                                    alert("非法操作！");
                                }
                            }
                        });
                    });
                    //全选-全不选
                    var flag = true;
                    $("#checkAll").click(function () {
                        var cb = $("input[type=checkbox]")
                        for (var i = 0; i < cb.length; i++) {
                            cb[i].checked = flag;
                        }
                        flag = !flag
                    });
                    $(".checkChildren").click(function () {
                        var children =$("input[type=checkbox]").filter(".checkChildren");
                        var checkedchildren=$("input[type=checkbox]:checked").filter(".checkChildren");
                        if(children.length==checkedchildren.length){
                            $("#checkAll").prop("checked",true);
                        }else{
                            $("#checkAll").prop("checked",false);
                        }
                    });
                });
            </script>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-6">
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <a href="${pageContext.request.contextPath}/Alarm/addAlarm" type="button" class="am-btn am-btn-success am-round">
                                <span class="am-icon-plus"></span> 新增</a>
                        </div>
                        <div class="am-btn-group am-btn-group-xs">
                            <button id="deleteAll" type="button" class="am-btn am-btn-danger am-round">
                                <span class="am-icon-trash-o"></span> 批量删除
                            </button>
                        </div>
                    </div>
                </div>
                <div class="am-u-sm-12 am-u-md-3">
                    <!-- 空 -->
                </div>
                <div class="am-u-sm-12 am-u-md-3">
                    <form action="${pageContext.request.contextPath}/Alarm/alarmList" method="get">
                        <div class="am-input-group am-input-group-sm">
                            <input type="text" name="searchWord" placeholder="警报名称" class="am-form-field" value="${requestScope.searchWord}">
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
                        <table id="datTable" class="am-table am-table-striped am-table-hover table-main">
                            <thead>
                            <tr>
                                <th class="table-check">
                                    <input id="checkAll" value="all" type="checkbox"/>
                                </th>
                                <th class="table-title">名称</th>
                                <th class="table-title">数据模板名称</th>
                                <th class="table-type">数据点名称</th>
                                <th class="table-author">触发条件</th>
                                <th class="table-date">状态</th>
                                <th class="table-date">更新时间</th>
                                <th class="table-set">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageBean.list}" var="li">
                            <tr>
                                <td>
                                    <input class="checkChildren" value="${li.id}" type="checkbox"/>
                                </td>
                                <td><a href="#">${li.sTriggerName}</a></td>
                                <td>
                                    ${li.dataTemplate.sTemplateName}
                                </td>
                                <td>${li.dataPoint.sName}</td>
                                <c:choose>
                                    <c:when test="${li.sTriggerCondition=='0'}">
                                        <td class="am-hide-sm-only">开关ON</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='1'}">
                                        <td class="am-hide-sm-only">开关OFF</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='2'}">
                                        <td class="am-hide-sm-only">数值低于${li.iMin}</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='3'}">
                                        <td class="am-hide-sm-only">数值高于${li.iMin}</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='4'}">
                                        <td class="am-hide-sm-only">数值在${li.iMin}-${li.iMax}之间</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='5'}">
                                        <td class="am-hide-sm-only">数值高于${li.iMax}低于${li.iMin}</td>
                                    </c:when>
                                    <c:when test="${li.sTriggerCondition=='6'}">
                                        <td class="am-hide-sm-only">数值等于${li.iMin}</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="am-hide-sm-only">${li.sTriggerCondition}</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${li.iStatus==0}">
                                        <td>未启用</td>
                                    </c:when>
                                    <c:when test="${li.iStatus==1}">
                                        <td>启用</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>${li.iStatus}</td>
                                    </c:otherwise>
                                </c:choose>
                                <td class="am-hide-sm-only">${li.dUpdateTime}</td>
                                <td>
                                    <div class="am-btn-toolbar">
                                        <div class="am-btn-group am-btn-group-xs">
                                            <a href="${pageContext.request.contextPath}/Alarm/editAlarm/${li.id}" class="am-btn am-btn-primary am-btn-xs">
                                                <span class="am-icon-pencil-square-o"></span> 编辑</a>
                                            <%--<a class="am-btn am-btn-success am-btn-xs am-hide-sm-only">
                                                <span class="am-icon-copy"></span> 复制</a>--%>
                                            <a href="${pageContext.request.contextPath}/Alarm/delAlarm/${li.id}" class="am-btn am-btn-danger am-btn-xs am-hide-sm-only">
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
                                                <a href="${pageContext.request.contextPath}/Alarm/alarmList/${pageBean.pageNum-1}">«</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/Alarm/alarmList/${pageBean.pageNum-1}">«</a>
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
                                                <a href="${pageContext.request.contextPath}/Alarm/alarmList/${i}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/Alarm/alarmList/${pageBean.pageNum+1}">»</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="am-disabled">
                                                <a href="${pageContext.request.contextPath}/Alarm/alarmList/${pageBean.pageNum+1}">»</a>
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