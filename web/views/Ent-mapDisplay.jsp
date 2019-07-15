<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <title>Amaze UI Admin index Examples</title>
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
    <link rel="stylesheet" type="text/css" href="/DripChain/views/static/css/map-display.css">

    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=LBIgTRrLI5rhggci3fNeblOnDnO4PIjI"></script>
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

<!-- 头部 start -->
<jsp:include page="top.jsp" flush="true"/>
<!-- 头部 end -->

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <jsp:include page="left.jsp" flush="true"/>
    <!-- sidebar end -->


    <!-- content start -->
    <div class="admin-content">

        <div style="width:100%;height:550px;z-index:1;" id="allmap">


        </div>
        <!-- content end -->
        <div class="up-map-div"  style="overflow: scroll">
            <div class="up-map-div-top">
                <form action="${pageContext.request.contextPath}/SurveillanceCenter/mapDisplay" method="get">
                <div class="am-input-group am-input-group-sm" style="width: 90%;">
                    <input type="text" name="searchWord" class="am-form-field" placeholder="设备编号或名称">
                    <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" type="submit">查询</button>
                    </span>
                </div>
                </form>
            </div>
            <ul class="up-map-div-ul">
                <c:forEach var="li" items="${devices}">
                    <li>
                        <div class="up-map-div-li-div1">
                            <div class="up-map-div-li-div2"><img src="/DripChain/views/static/images/2.png"></div>
                            <div class="up-map-div-li-div3">
                                <a href="#" class="up-map-div-li-div3-a" onclick="centerAndZoom(${li.dDeviceLongitude},${li.dDeviceLatitude});">${li.sDeviceName}</a><br>
                                <span class="up-map-div-li-div3-span">${li.sDeviceId}</span>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>


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
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 4);   // 初始化地图,设置中心点坐标和地图级别
    map.setCurrentCity("北京");
    // 添加带有定位的导航控件
    map.addControl(new BMap.NavigationControl({
        // 靠左上角位置
        anchor: BMAP_ANCHOR_TOP_LEFT,
        // LARGE类型
        type: BMAP_NAVIGATION_CONTROL_LARGE,
        // 启用显示定位
        enableGeolocation: true
    }));
    //添加地图类型控件
    map.addControl(new BMap.MapTypeControl({
        mapTypes: [
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]
    }));
    map.addControl(new BMap.ScaleControl()); //添加比例尺控件
    var traffic = new BMap.TrafficLayer();        // 创建交通流量图层实例
    map.addTileLayer(traffic);                    // 将图层添加到地图上
    //map.removeTileLayer(traffic);                // 将图层移除
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

    //地图初始化标注
    map.clearOverlays();//清空标注点
    <c:forEach var="li" items="${deviceList}">
    var marker = new BMap.Marker(new BMap.Point(${li.dDeviceLongitude}, ${li.dDeviceLatitude}));// 创建标注
    map.addOverlay(marker);
    </c:forEach>

    function centerAndZoom(longitude_value,latitude_value){
        map.clearOverlays();//清空标注点
        <c:forEach var="li" items="${deviceList}">
        var marker = new BMap.Marker(new BMap.Point(${li.dDeviceLongitude}, ${li.dDeviceLatitude}));// 创建标注
        map.addOverlay(marker);
        </c:forEach>
        removePoint(longitude_value,latitude_value);//删除该点
        var point = new BMap.Point(longitude_value,latitude_value);
        map.centerAndZoom(point, 11);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);            // 将标注添加到地图中
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    }
    function removePoint(longitude_value,latitude_value){
        var allOverlay = map.getOverlays();
        for (var i = 0; i < allOverlay.length; i++){
            if (allOverlay[i].getPosition().lng ==longitude_value && allOverlay[i].getPosition().lat==latitude_value ) {
                map.removeOverlay(allOverlay[i]);
            }
        }
    }
</script>