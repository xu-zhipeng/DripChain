<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <title>列表展示</title>
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
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="map-display.css">
    <link rel="stylesheet" type="text/css" href="/DripChain/views/static/css/list-display.css">

    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=3.0&ak=LBIgTRrLI5rhggci3fNeblOnDnO4PIjI"></script>
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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑";
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=3.0&ak=LBIgTRrLI5rhggci3fNeblOnDnO4PIjI"></script>
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
        <div class="admin-content-body admin-content-bodyadd">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">列表展示</strong> /
                    <small>List Display</small>
                </div>
            </div>

            <hr/>
            <div class="list-display-main">
                <div class="list-display-main-left">
                    <div class="list-display-main-left-top">
                        <div class="am-input-group am-input-group-sm am-input-group-smadd">
                            <input type="text" class="am-form-field" placeholder="设备编号或名称">
                            <span class="am-input-group-btn">
		          <button class="am-btn am-btn-default" type="button">查询</button>
		          </span>
                        </div>

                    </div>
                    <ul class="list-display-main-ul">
                        <li>
                            <div class="list-display-main-li-div1">
                                <div class="list-display-main-li-div1-img"><img
                                        src="/DripChain/views/static/images/2.png"></div>
                                <div class="list-display-main-li-div2">
                                    <a href="#" class="list-display-main-li-div2-a">共享按摩椅</a><br>
                                    <span class="list-display-main-li-div2-span">00004299015953132138</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="list-display-main-li-div1">
                                <div class="list-display-main-li-div1-img"><img
                                        src="/DripChain/views/static/images/2.png"></div>
                                <div class="list-display-main-li-div2">
                                    <a href="#" class="list-display-main-li-div2-a">共享按摩椅</a><br>
                                    <span class="list-display-main-li-div2-span">00004299015953132138</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="list-display-main-li-div1">
                                <div class="list-display-main-li-div1-img"><img
                                        src="/DripChain/views/static/images/2.png"></div>
                                <div class="list-display-main-li-div2">
                                    <a href="#" class="list-display-main-li-div2-a">共享按摩椅</a><br>
                                    <span class="list-display-main-li-div2-span">00004299015953132138</span>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="list-display-main-li-div1">
                                <div class="list-display-main-li-div1-img"><img
                                        src="/DripChain/views/static/images/2.png"></div>
                                <div class="list-display-main-li-div2">
                                    <a href="#" class="list-display-main-li-div2-a">共享按摩椅</a><br>
                                    <span class="list-display-main-li-div2-span">00004299015953132138</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="list-display-main-right">
                    <div class="list-display-main-right-img"><img src="/DripChain/views/static/images/1.png"></div>
                    <ul class="list-display-main-right-ul">
                        <li>
                            <div>
                                <div class="list-display-main-right-li-div1">
                                    <div class="list-display-main-right-li-div2">设备名称：共享按摩椅</div>
                                    <div class="list-display-main-right-li-div3">设备编号：00004299015953132138</div>
                                </div>
                                <ul class="list-display-main-right-ul-ul">
                                    <li>
                                        <div class="list-display-main-right-ul-ul-div1">
                                            <div class="list-display-main-right-ul-ul-div2">
                                                <span class="list-display-main-right-ul-ul-div2-span1">按摩气压</span><br>
                                                <span class="list-display-main-right-ul-ul-div2-span2">数据点id：2941</span>
                                            </div>
                                            <div class="list-display-main-right-ul-ul-div1-son">
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">从机名称：</span><br>
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">2</span>
                                            </div>
                                            <div class="list-display-main-right-ul-ul-div1-son">
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">更新时间</span><br>
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">2018-8-29 19:57:45</span>
                                            </div>
                                            <div class="list-display-main-right-ul-ul-div1-son">
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">当前值：</span><br>
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);">12770个</span>
                                            </div>
                                            <div class="list-display-main-right-ul-ul-div1-son">
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);"><button
                                                        type="button" class="am-btn am-btn-primary">主动采集</button></span><br>
                                                <span style="line-height: 40px; font-size: 14px;color: rgb(102,102,102);"><button
                                                        type="button" class="am-btn am-btn-primary">历史查询</button></span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>

                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- content end -->

    </div>

</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);  // 初始化地图,设置中心点坐标和地图级别
    //添加地图类型控件
    map.addControl(new BMap.MapTypeControl({
        mapTypes: [
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]
    }));
    map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
</script>