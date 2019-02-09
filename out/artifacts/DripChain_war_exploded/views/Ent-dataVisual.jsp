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
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
    <script src="/DripChain/views/static/js/echarts.js"></script>

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
                    <small>数据可视化</small>
                </div>
            </div>

            <div class="am-g">
                <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                <div id="container" style="width: 100%;height: 600px;"></div>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
                <script type="text/javascript"
                        src="http://api.map.baidu.com/api?v=3.0&ak=X62bMVYNWyuoXiE2n91bsylO9ssyZPwM"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
                <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
                <script type="text/javascript">
                    var dom = document.getElementById("container");
                    var myChart = echarts.init(dom);
                    var app = {};
                    option = null;

                    var yearCount = 7;
                    var categoryCount = 30;

                    var xAxisData = [];
                    var customData = [];
                    var legendData = [];
                    var dataList = [];

                    legendData.push('trend');
                    var encodeY = [];
                    for (var i = 0; i < yearCount; i++) {
                        legendData.push((2010 + i) + '');
                        dataList.push([]);
                        encodeY.push(1 + i);
                    }

                    for (var i = 0; i < categoryCount; i++) {
                        var val = Math.random() * 1000;
                        xAxisData.push('category' + i);
                        var customVal = [i];
                        customData.push(customVal);

                        var data = dataList[0];
                        for (var j = 0; j < dataList.length; j++) {
                            var value = j === 0
                                ? echarts.number.round(val, 2)
                                : echarts.number.round(Math.max(0, dataList[j - 1][i] + (Math.random() - 0.5) * 200), 2);
                            dataList[j].push(value);
                            customVal.push(value);
                        }
                    }

                    function renderItem(params, api) {
                        var xValue = api.value(0);
                        var currentSeriesIndices = api.currentSeriesIndices();
                        var barLayout = api.barLayout({
                            barGap: '30%', barCategoryGap: '20%', count: currentSeriesIndices.length - 1
                        });

                        var points = [];
                        for (var i = 0; i < currentSeriesIndices.length; i++) {
                            var seriesIndex = currentSeriesIndices[i];
                            if (seriesIndex !== params.seriesIndex) {
                                var point = api.coord([xValue, api.value(seriesIndex)]);
                                point[0] += barLayout[i - 1].offsetCenter;
                                point[1] -= 20;
                                points.push(point);
                            }
                        }
                        var style = api.style({
                            stroke: api.visual('color'),
                            fill: null
                        });

                        return {
                            type: 'polyline',
                            shape: {
                                points: points
                            },
                            style: style
                        };
                    }

                    option = {
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data: legendData
                        },
                        dataZoom: [{
                            type: 'slider',
                            start: 50,
                            end: 70
                        }, {
                            type: 'inside',
                            start: 50,
                            end: 70
                        }],
                        xAxis: {
                            data: xAxisData
                        },
                        yAxis: {},
                        series: [{
                            type: 'custom',
                            name: 'trend',
                            renderItem: renderItem,
                            itemStyle: {
                                normal: {
                                    borderWidth: 2
                                }
                            },
                            encode: {
                                x: 0,
                                y: encodeY
                            },
                            data: customData,
                            z: 100
                        }].concat(echarts.util.map(dataList, function (data, index) {
                            return {
                                type: 'bar',
                                animation: false,
                                name: legendData[index + 1],
                                itemStyle: {
                                    normal: {
                                        opacity: 0.5
                                    }
                                },
                                data: data
                            };
                        }))
                    };
                    ;
                    if (option && typeof option === "object") {
                        myChart.setOption(option, true);
                    }
                </script>
            </div>


            <footer class="admin-content-footer">
                <hr>
                <p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
            </footer>
        </div>
        <!-- content end -->
    </div>
</div>


<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu"
   data-am-offcanvas="{target: '#admin-offcanvas'}"></a>


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