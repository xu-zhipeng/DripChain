<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">

<head>

</head>

<body>
  <!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
  以获得更好的体验！</p>
<![endif]-->

  <header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand">
      <strong>水滴链</strong>
      <small>欢迎您访问！</small>
      <div class="am-icon-list am-margin-left">
  
      </div>
    </div>
  
  
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}">
      <span class="am-sr-only">导航切换</span>
      <span class="am-icon-bars"></span>
    </button>
  
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
  
      <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
        <li>
          <a href="javascript:;">
            <span class="am-icon-envelope-o"></span> 留言反馈
            <!-- <span class="am-badge am-badge-warning">5</span> -->
          </a>
        </li>
        <li class="am-dropdown" data-am-dropdown>
          <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
            <span class="am-icon-users"></span>
            <c:choose>
              <c:when test="${sessionScope.User!=null}">
                ${sessionScope.User.sNickName}
              </c:when>
              <c:when test="${sessionScope.Company!=null}">
                ${sessionScope.Company.sCompanyName}
              </c:when>
            </c:choose>
            <span class="am-icon-caret-down"></span>
          </a>
          <ul class="am-dropdown-content">
            <li>
              <a href="${pageContext.request.contextPath}/User/showInfo">
                <span class="am-icon-user"></span> 资料</a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/User/upPwdView">
                <span class="am-icon-cog"></span> 设置</a>
            </li>
            <li>
              <a href="${pageContext.request.contextPath}/Login/logout">
                <span class="am-icon-power-off"></span> 退出</a>
            </li>
          </ul>
        </li>
        <li class="am-hide-sm-only">
          <a href="javascript:;" id="admin-fullscreen">
            <span class="am-icon-arrows-alt"></span>
            <span class="admin-fullText">开启全屏</span>
          </a>
        </li>
      </ul>
    </div>
  </header>




</body>

</html>