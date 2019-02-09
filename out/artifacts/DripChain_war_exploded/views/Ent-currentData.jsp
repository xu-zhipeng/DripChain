<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>水滴链 | 数据分析</title>
  <meta name="description" content="数据分析">
  <meta name="keywords" content="index">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
  <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
  <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css" />
  <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
  <script src="/DripChain/views/static/js/echarts.min.js"></script>

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
            <strong class="am-text-primary am-text-lg">数据分析</strong> /
            <small>实时数据</small>
          </div>
        </div>

        <ul class="am-avg-sm-1 am-avg-md-4 am-margin am-padding am-text-center admin-content-list ">
          <li>
            <a href="#" class="am-text-success">
              <span class="am-icon-btn am-icon-file-text"></span>
              <br/>合格设备
              <br/>2</a>
          </li>
          <li>
            <a href="#" class="am-text-warning">
              <span class="am-icon-btn am-icon-briefcase"></span>
              <br/>警告设备
              <br/>1</a>
          </li>
          <li>
            <a href="#" class="am-text-danger">
              <span class="am-icon-btn am-icon-recycle"></span>
              <br/>超标设备
              <br/>1</a>
          </li>
          <li>
            <a href="#" class="am-text-primary">
              <span class="am-icon-btn am-icon-user-md"></span>
              <br/>异常设备
              <br/>1</a>
          </li>
        </ul>

        <div class="am-g">
          <div class="am-u-sm-12">
            <table class="am-table am-table-bd am-table-striped admin-content-table">
              <thead>
                <tr>
                  <th>设备编号</th>
                  <th>设备名称</th>
                  <th>合格数据范围</th>
                  <th>当前数据</th>
                  <th>最近更新时间</th>
                  <th>管理</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>PH值</td>
                  <td>
                    <a href="#">0.75~1.64</a>
                  </td>
                  <td>
                    <span class="am-badge am-badge-success">1.26</span>
                  </td>
                  <td>
                      <span class="am-badge ">2018-10-24 10:26</span>
                  </td>
                  <td>
                    <div class="am-dropdown" data-am-dropdown>
                      <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>
                        <span class="am-icon-cog"></span>
                        <span class="am-icon-caret-down"></span>
                      </button>
                      <ul class="am-dropdown-content">
                        <li>
                          <a href="#">1. 编辑</a>
                        </li>
                        <li>
                          <a href="#">2. 下载</a>
                        </li>
                        <li>
                          <a href="#">3. 删除</a>
                        </li>
                      </ul>
                    </div>
                  </td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>PH值</td>
                    <td>
                        <a href="#">0.75~1.64</a>
                    </td>
                    <td>
                        <span class="am-badge am-badge-danger">1.80</span>
                    </td>
                    <td>
                        <span class="am-badge ">2018-10-24 10:26</span>
                    </td>
                    <td>
                        <div class="am-dropdown" data-am-dropdown>
                            <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>
                                <span class="am-icon-cog"></span>
                                <span class="am-icon-caret-down"></span>
                            </button>
                            <ul class="am-dropdown-content">
                                <li>
                                    <a href="#">1. 编辑</a>
                                </li>
                                <li>
                                    <a href="#">2. 下载</a>
                                </li>
                                <li>
                                    <a href="#">3. 删除</a>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>水流量</td>
                    <td>
                        <a href="#">12~14</a>
                    </td>
                    <td>
                        <span class="am-badge am-badge-warning">13.9</span>
                    </td>
                    <td>
                        <span class="am-badge ">2018-10-24 10:26</span>
                    </td>
                    <td>
                        <div class="am-dropdown" data-am-dropdown>
                            <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>
                                <span class="am-icon-cog"></span>
                                <span class="am-icon-caret-down"></span>
                            </button>
                            <ul class="am-dropdown-content">
                                <li>
                                    <a href="#">1. 编辑</a>
                                </li>
                                <li>
                                    <a href="#">2. 下载</a>
                                </li>
                                <li>
                                    <a href="#">3. 删除</a>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>PH值</td>
                    <td>
                        <a href="#">0.75~1.64</a>
                    </td>
                    <td>
                        <span class="am-badge am-badge-success">1.06</span>
                    </td>
                    <td>
                        <span class="am-badge ">2018-10-24 10:26</span>
                    </td>
                    <td>
                        <div class="am-dropdown" data-am-dropdown>
                            <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>
                                <span class="am-icon-cog"></span>
                                <span class="am-icon-caret-down"></span>
                            </button>
                            <ul class="am-dropdown-content">
                                <li>
                                    <a href="#">1. 编辑</a>
                                </li>
                                <li>
                                    <a href="#">2. 下载</a>
                                </li>
                                <li>
                                    <a href="#">3. 删除</a>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>5</td>
                    <td>氮磷检测机</td>
                    <td>
                        <a href="#">0.03~2.12</a>
                    </td>
                    <td>
                        <span class="am-badge-primary">……</span>
                    </td>
                    <td>
                        <span class="am-badge ">2018-10-24 10:26</span>
                    </td>
                    <td>
                        <div class="am-dropdown" data-am-dropdown>
                            <button class="am-btn am-btn-default am-btn-xs am-dropdown-toggle" data-am-dropdown-toggle>
                                <span class="am-icon-cog"></span>
                                <span class="am-icon-caret-down"></span>
                            </button>
                            <ul class="am-dropdown-content">
                                <li>
                                    <a href="#">1. 编辑</a>
                                </li>
                                <li>
                                    <a href="#">2. 下载</a>
                                </li>
                                <li>
                                    <a href="#">3. 删除</a>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>



      <footer class="admin-content-footer">
        <hr>
        <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
      </footer>
      </div>
    </div>
    <!-- content end -->

  </div>

  <a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}"></a>

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