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
                    <small>数据预测</small>
                </div>
            </div>

            <div class="am-g">
                <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                <div id="container" style="height: 600px;width: 100%"></div>
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
                        src="http://api.map.baidu.com/api?v=3.0&ak=LBIgTRrLI5rhggci3fNeblOnDnO4PIjI"></script>
                <script type="text/javascript"
                        src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
                <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
                <script type="text/javascript">
                    var dom = document.getElementById("container");
                    var myChart = echarts.init(dom);
                    var app = {};
                    option = null;
                    var dataAll = [
                        [
                            [10.0, 8.04],
                            [8.0, 6.95],
                            [13.0, 7.58],
                            [9.0, 8.81],
                            [11.0, 8.33],
                            [14.0, 9.96],
                            [6.0, 7.24],
                            [4.0, 4.26],
                            [12.0, 10.84],
                            [7.0, 4.82],
                            [5.0, 5.68]
                        ],
                        [
                            [10.0, 9.14],
                            [8.0, 8.14],
                            [13.0, 8.74],
                            [9.0, 8.77],
                            [11.0, 9.26],
                            [14.0, 8.10],
                            [6.0, 6.13],
                            [4.0, 3.10],
                            [12.0, 9.13],
                            [7.0, 7.26],
                            [5.0, 4.74]
                        ],
                        [
                            [10.0, 7.46],
                            [8.0, 6.77],
                            [13.0, 12.74],
                            [9.0, 7.11],
                            [11.0, 7.81],
                            [14.0, 8.84],
                            [6.0, 6.08],
                            [4.0, 5.39],
                            [12.0, 8.15],
                            [7.0, 6.42],
                            [5.0, 5.73]
                        ],
                        [
                            [8.0, 6.58],
                            [8.0, 5.76],
                            [8.0, 7.71],
                            [8.0, 8.84],
                            [8.0, 8.47],
                            [8.0, 7.04],
                            [8.0, 5.25],
                            [19.0, 12.50],
                            [8.0, 5.56],
                            [8.0, 7.91],
                            [8.0, 6.89]
                        ]
                    ];

                    var markLineOpt = {
                        animation: false,
                        label: {
                            normal: {
                                formatter: 'y = 0.5 * x + 3',
                                textStyle: {
                                    align: 'right'
                                }
                            }
                        },
                        lineStyle: {
                            normal: {
                                type: 'solid'
                            }
                        },
                        tooltip: {
                            formatter: 'y = 0.5 * x + 3'
                        },
                        data: [[{
                            coord: [0, 3],
                            symbol: 'none'
                        }, {
                            coord: [20, 13],
                            symbol: 'none'
                        }]]
                    };

                    option = {
                        title: {
                            text: 'Anscombe\'s quartet',
                            x: 'center',
                            y: 0
                        },
                        grid: [
                            {x: '7%', y: '7%', width: '38%', height: '38%'},
                            {x2: '7%', y: '7%', width: '38%', height: '38%'},
                            {x: '7%', y2: '7%', width: '38%', height: '38%'},
                            {x2: '7%', y2: '7%', width: '38%', height: '38%'}
                        ],
                        tooltip: {
                            formatter: 'Group {a}: ({c})'
                        },
                        xAxis: [
                            {gridIndex: 0, min: 0, max: 20},
                            {gridIndex: 1, min: 0, max: 20},
                            {gridIndex: 2, min: 0, max: 20},
                            {gridIndex: 3, min: 0, max: 20}
                        ],
                        yAxis: [
                            {gridIndex: 0, min: 0, max: 15},
                            {gridIndex: 1, min: 0, max: 15},
                            {gridIndex: 2, min: 0, max: 15},
                            {gridIndex: 3, min: 0, max: 15}
                        ],
                        series: [
                            {
                                name: 'I',
                                type: 'scatter',
                                xAxisIndex: 0,
                                yAxisIndex: 0,
                                data: dataAll[0],
                                markLine: markLineOpt
                            },
                            {
                                name: 'II',
                                type: 'scatter',
                                xAxisIndex: 1,
                                yAxisIndex: 1,
                                data: dataAll[1],
                                markLine: markLineOpt
                            },
                            {
                                name: 'III',
                                type: 'scatter',
                                xAxisIndex: 2,
                                yAxisIndex: 2,
                                data: dataAll[2],
                                markLine: markLineOpt
                            },
                            {
                                name: 'IV',
                                type: 'scatter',
                                xAxisIndex: 3,
                                yAxisIndex: 3,
                                data: dataAll[3],
                                markLine: markLineOpt
                            }
                        ]
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