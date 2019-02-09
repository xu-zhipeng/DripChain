<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">

<head>
</head>

<body>


    <!-- sidebar start -->
    <div class="admin-sidebar am-offcanvas" id="admin-offcanvas" style="overflow-x: hidden; overflow-y: auto;margin-right: -15px;">
      <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul id="xiala" class="am-list admin-sidebar-list">
          <li>
            <a href="${pageContext.request.contextPath}/Index/index">
              <span class="am-icon-home"></span> 首页</a>
          </li>
  
          <li class="admin-parent">
            <a href="javascript:;" class="am-cf">
              <span class="am-icon-dashboard"></span> 监控中心
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
              <li>
                <a href="${pageContext.request.contextPath}/SurveillanceCenter/mapDisplay" class="am-cf">
                  <span class="am-icon-map-marker"></span> 地图展示
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/SurveillanceCenter/listDisplay">
                  <span class="am-icon-list"></span> 列表展示</a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-dot-circle-o"></span> 数据分析
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
              <li>
                <a href="${pageContext.request.contextPath}/DataAnalysis/currentData" class="am-cf">
                  <span class="am-icon-area-chart"></span> 实时数据
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/DataAnalysis/dataForecast">
                  <span class="am-icon-line-chart"></span> 数据预测</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/DataAnalysis/dataVisual">
                  <span class="am-icon-pie-chart"></span> 数据可视化</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/DataAnalysis/historyData">
                  <span class="am-icon-clock-o"></span> 历史记录
                  <span class="am-badge am-badge-secondary am-margin-right am-fr">24</span>
                </a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-television"></span> 数据管理
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in">
              <li>
                <a href="${pageContext.request.contextPath}/DataManage/dataTemplateList" class="am-cf">
                  <span class="am-icon-list"></span> 模板列表
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/DataManage/addDataPoint">
                  <span class="am-icon-plus"></span> 添加数据点</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/DataManage/dataList">
                  <span class="am-icon-list"></span> 设备数据</a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-television"></span> 设备管理
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
              <li>
                <a href="${pageContext.request.contextPath}/Device/deviceList" class="am-cf">
                  <span class="am-icon-list"></span> 设备列表
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Device/addDevice">
                  <span class="am-icon-plus"></span> 添加设备</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Device/deviceGroupList">
                  <span class="am-icon-th"></span> 设备分组
                  <span class="am-badge am-badge-secondary am-margin-right am-fr">24</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Device/deviceStatusList">
                  <span class="am-icon-refresh"></span> 设备状态</a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-bell"></span> 超标预警
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in">
              <li>
                <a href="${pageContext.request.contextPath}/Alarm/alarmList" class="am-cf">
                  <span class="am-icon-list"></span> 警报列表
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Alarm/addAlarm">
                  <span class="am-icon-plus"></span> 添加警报</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Alarm/contactList">
                  <span class="am-icon-group"></span> 报警联系人/组
                  <span class="am-badge am-badge-secondary am-margin-right am-fr">24</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/Alarm/alarmRecordList">
                  <span class="am-icon-calendar"></span> 警报记录</a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-user"></span> 用户中心
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
              <li>
                <a href="${pageContext.request.contextPath}/User/addsubView" class="am-cf">
                  <span class="am-icon-user-plus"></span> 添加子用户
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/User/subList">
                  <span class="am-icon-wrench"></span> 子用户列表</a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/User/upPwdView">
                  <span class="am-icon-key"></span> 用户密码
                  <span class="am-badge am-badge-secondary am-margin-right am-fr">24</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/User/showInfo">
                  <span class="am-icon-user"></span> 个人信息</a>
              </li>
            </ul>
          </li>
          <li class="admin-parent">
            <a class="am-cf" href="javascript:;">
              <span class="am-icon-ellipsis-h"></span> 其他
              <span class="am-icon-angle-right am-fr am-margin-right"></span>
            </a>
            <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
              <li>
                <a href="Ent-suggestion.html">
                  <span class="am-icon-envelope"></span> 留言反馈
                  <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                </a>
              </li>
              <li>
                <a href="data-export.html">
                  <span class="am-icon-table"></span> 数据导出
                  <span class="am-badge am-badge-secondary am-margin-right am-fr">24</span>
                </a>
              </li>
              <li>
                <a href="web-printing.html">
                  <span class="am-icon-print"></span> Web打印</a>
              </li>
            </ul>
          </li>
          <li>
            <a id="erweima" href="javascript:;" class="list-group-item" title="<h4 align='center'>扫二维码下载APP</h4>" data-container="body"
              data-toggle="popover" data-placement="right" data-content="<img src='static/images/erweima.jpg' width='200' height='200' />">
              <span class="am-icon-mobile-phone am-icon-sm"></span>手机端
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/Login/logout">
              <span class="am-icon-sign-out"></span> 注销</a>
          </li>
        </ul>
  <script>
    //$(function () { $("[data-toggle='popover']").popover({ html: true }); });
  </script>

        <div class="am-panel am-panel-default admin-sidebar-panel">
          <div class="am-panel-bd">
            <p>
              <span class="am-icon-bookmark"></span> 公告</p>
            <p>时光静好，与君语；细水流年，与君同。—— Amaze UI</p>
          </div>
        </div>
  
        <div class="am-panel am-panel-default admin-sidebar-panel">
          <div class="am-panel-bd">
            <p>
              <span class="am-icon-tag"></span> wiki</p>
            <p>Welcome to the Amaze UI wiki!</p>
          </div>
        </div>
      </div>
    </div>
    <!-- sidebar end -->




</body>

</html>