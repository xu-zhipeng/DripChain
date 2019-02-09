<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>水滴链 | 设备列表</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <!--地图开始-->
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>  <!--适应移动设备页面展示-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--地图的结束-->
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <script src="/DripChain/views/static/js/amazeui.min.js"></script>
    <!--地图密钥-->
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=X62bMVYNWyuoXiE2n91bsylO9ssyZPwM"></script>
    <!--结束-->
    <!--图表引入-->
    <script type="text/javascript" src="http://echart s.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
    <script type="text/javascript"
            src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=X62bMVYNWyuoXiE2n91bsylO9ssyZPwM"></script>
    <script type="text/javascript"
            src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
    <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
    <script type="text/javascript"></script>
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
    <!--设置地图样式-->
    <style type="text/css">
        .tdhiden{
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        #r-result {
            width: 100%;
            font-size: 14px;
        }
    </style>
    <!--设置地图样式结束-->
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
                    <strong class="am-text-primary am-text-lg">设备列表</strong> /
                    <small>Device List</small>
                </div>
            </div>
            <hr/>
            <!--开始-->
            <div class="am-g">
                <!--第一个开始-->
                <div class="am-u-sm-12 am-u-md-4">
                    <section class="am-panel am-panel-default">
                        <header class="am-panel-hd">
                            <h3 class="am-panel-title">设备概况
                                <select id="doc-select-1">
                                    <option value="">...</option>
                                    <c:forEach var="li" items="${deviceList}">
                                        <option value="${li.id}">${li.sDeviceName}</option>
                                    </c:forEach>
                                </select></h3>
                        </header>
                        <div class="am-panel-bd">
                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div id="container" style="height: 100%"></div>
                            <!-- 开始引入 ECharts 文件 -->
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
                                    src="https://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
                            <script type="text/javascript"
                                    src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
                            <script type="text/javascript"
                                    src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
                            <!--结束 引入 ECharts 文件 -->
                            <script type="text/javascript">
                                var dom = document.getElementById("container");//获取Dom的id
                                var myChart = echarts.init(dom);//通过文件esl.js内封装好的require获得echarts接口后可实例化图表，echarts接口仅有一个方法init，执行init时传入一个具备大小（如果没有指定容器的大小将会按照0大小来处理即无法看到图表）的dom节点（width、height可被计算得到即可，不一定可见）后即可实例化出图表对象，
                                var app = {};
                                option = null;//设置图表选项，开始设置为空
                                app.title = '环形图';
                                //开始设置图表选项
                                option = {
                                    //设置提示框
                                    tooltip: {
                                        trigger: 'item',
                                        formatter: "{a} <br/>{b}: {c} ({d}%)"
                                    },
                                    //设置图列
                                    legend: {
                                        orient: 'vertical',
                                        x: 'left',
                                        data: ['在线', '下线']
                                    },
                                    //
                                    series: [
                                        {
                                            name: '设备概况',
                                            type: 'pie',
                                            radius: ['50%', '70%'],
                                            avoidLabelOverlap: false,
                                            label: {
                                                normal: {
                                                    show: false,
                                                    position: 'center'
                                                },
                                                emphasis: {
                                                    show: true,
                                                    textStyle: {
                                                        fontSize: '30',
                                                        fontWeight: 'bold'
                                                    }
                                                }
                                            },
                                            labelLine: {
                                                normal: {
                                                    show: false
                                                }
                                            },
                                            //动态显示的数据
                                            data: [
                                                {value: ${onlineNum}, name: '在线'},
                                                {value: ${pageBean.totalRecord-onlineNum}, name: '下线'},

                                            ]
                                        }
                                    ]
                                };//图表设置选项结束
                                ;
                                if (option && typeof option === "object") {
                                    myChart.setOption(option, true);
                                }
                            </script>
                        </div>
                    </section>
                </div>
                <!--第一个结束-->
                <!--第二个开始-->
                <div class="am-u-sm-12 am-u-md-4">
                    <section class="am-panel am-panel-default">
                        <header class="am-panel-hd">
                            <h3 class="am-panel-title">通讯协议
                                <select id="doc-select-3">
                                    <option value="">...</option>
                                    <option value="0">Modbus RTU</option>
                                    <option value="1">Modbus TCP</option>
                                    <option value="2">数据透传</option>
                                    <option value="3">DL/T645-97</option>
                                    <option value="4">DL/T645-07</option>
                                    <option value="5">烟感协议</option>
                                </select>
                            </h3>
                        </header>
                        <div class="am-panel-bd">
                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div id="container1" style="height: 100%"></div>
                            <!-- 开始引入 ECharts 文件 -->
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
                                    src="https://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
                            <script type="text/javascript"
                                    src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
                            <script type="text/javascript"
                                    src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
                            <!--结束 引入 ECharts 文件 -->
                            <script type="text/javascript">
                                var dom = document.getElementById("container1");//获取Dom的id
                                var myChart = echarts.init(dom);//通过文件esl.js内封装好的require获得echarts接口后可实例化图表，echarts接口仅有一个方法init，执行init时传入一个具备大小（如果没有指定容器的大小将会按照0大小来处理即无法看到图表）的dom节点（width、height可被计算得到即可，不一定可见）后即可实例化出图表对象，
                                var app = {};
                                option = null;//设置图表选项，开始设置为空
                                app.title = '环形图';
                                //开始设置图表选项
                                option = {
                                    //设置提示框
                                    tooltip: {
                                        trigger: 'item',
                                        formatter: "{a} <br/>{b}: {c} ({d}%)"
                                    },
                                    //设置图列
                                    legend: {
                                        orient: 'vertical',
                                        x: 'left',
                                        data: ['Modbus RTU','Modbus TCP','数据透传','DL/T645-97','DL/T645-07','烟感协议']
                                    },
                                    //
                                    series: [
                                        {
                                            name: '通讯协议',
                                            type: 'pie',
                                            radius: ['50%', '70%'],
                                            avoidLabelOverlap: false,
                                            label: {
                                                normal: {
                                                    show: false,
                                                    position: 'center'
                                                },
                                                emphasis: {
                                                    show: true,
                                                    textStyle: {
                                                        fontSize: '30',
                                                        fontWeight: 'bold'
                                                    }
                                                }
                                            },
                                            labelLine: {
                                                normal: {
                                                    show: false
                                                }
                                            },
                                            //动态显示的数据['Modbus RTU','Modbus TCP','数据透传','DL/T645-97','DL/T645-07','烟感协议']
                                            data: [
                                                {value: ${ModbusRTU}, name: 'Modbus RTU'},
                                                {value: ${ModbusTCP}, name: 'Modbus TCP'},
                                                {value: ${TCP}, name: '数据透传'},
                                                {value: ${DLT64597}, name: 'DL/T645-97'},
                                                {value: ${DLT64507}, name: 'DL/T645-07'},
                                                {value: ${smoke}, name: '烟感协议'}
                                            ]
                                        }
                                    ]
                                };//图表设置选项结束
                                ;
                                if (option && typeof option === "object") {
                                    myChart.setOption(option, true);
                                }
                            </script>
                        </div>
                    </section>
                </div>
                <!--第二个结束-->
                <!--第三个开始-->
                <div class="am-u-sm-12 am-u-md-4">
                    <section class="am-panel am-panel-default">
                        <header class="am-panel-hd">
                            <h3 class="am-panel-title">所属用户</h3>
                        </header>
                        <div class="am-panel-bd">
                            <table class="am-table">
                                <thead>
                                <tr>

                                    <th>设备数量</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>${pageBean.totalRecord}</td>
                                </tr>
                            </table>
                        </div>
                    </section>
                </div>
                <!--第三个结束-->
            </div>
            <!--结束-->
            <div class="am-g">
                <section class="am-panel am-panel-default">
                    <header class="am-panel-hd">
                        <h3 class="am-panel-title">设备地图</h3>
                    </header>
                    <div class="am-panel-bd">
                        <!--地图-->
                        <div style="width:100%;height:550px;z-index:1;" id="allmap">
                        </div>
                    </div>
                    <div class="am-panel-footer">
                        <label>经度: </label><input id="longitude" type="text" class="form-control" style="width:100px;margin-right:10px;display: inline-block;" />
                        <label>纬度: </label><input id="latitude" type="text" class="form-control" style="width:100px;margin-right:10px;display: inline-block;" />
                        <button type="button" id="btn0" class="am-btn am-btn-primary am-btn-xs">查询</button>
                        <label style="margin-left: 50px;">地址: </label><input id="address" type="text" class="form-control" style="width:100px; margin-right:10px;display: inline-block;" />
                        <button type="button" id="btn" class="am-btn am-btn-primary am-btn-xs">查询</button>
                        <button type="button" id="showAll" class="am-btn am-btn-primary am-btn-xs" style="margin-left: 50px;">显示全部</button>
                        <button type="button" id="showCurrentPage" class="am-btn am-btn-primary am-btn-xs" style="margin-left: 10px;">显示当前页</button>
                    </div>
                </section>
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
                            // alert(ids);
                            $.ajax({
                                url :"${pageContext.request.contextPath}/Device/delAllDevice",
                                data : "ids=" + ids,    //最原始的传参  "fname=Henry&lname=Ford"   可以用json字符串传JSON.stringify(param) 但是后端接受参数需要用 @ResponseBody int[] ids  contentType必须声明为"application/json;charset=utf-8",不然会报错
                                type : "post",
                                dataType : "json",
                                success : function(data) {
                                    // alert(data);
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
                                <a href="${pageContext.request.contextPath}/Device/addDevice" type="button" class="am-btn am-btn-success am-round">
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
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <form action="${pageContext.request.contextPath}/Device/deviceList" method="get">
                            <div class="am-input-group am-input-group-sm">
                                <input type="text" name="searchWord" placeholder="设备名称" class="am-form-field" value="${requestScope.searchWord}">
                                <span class="am-input-group-btn">
                                <input type="submit" class="am-btn am-btn-success" value="搜索"/>
                            </span>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="am-g">
                    <div class="am-u-sm-12">
                        <script>
                            $(function () {
                                var addDeviceMessage = "${param.addDeviceMessage}";
                                if (!$.isEmptyObject(addDeviceMessage)) {
                                    alert(addDeviceMessage);
                                    history.back();
                                }
                                var editDeviceMessage = "${param.editDeviceMessage}";
                                if (!$.isEmptyObject(editDeviceMessage)) {
                                    alert(editDeviceMessage);
                                    history.back();
                                }
                                var delDeviceMessage = "${param.delDeviceMessage}";
                                if (!$.isEmptyObject(delDeviceMessage)) {
                                    alert(delDeviceMessage);
                                }
                            });
                        </script>
                        <form class="am-form">
                            <table id="datTable" class="am-table am-table-striped am-table-hover table-main" style="table-layout: fixed;vertical-align:middle;">
                                <thead>
                                <tr>
                                    <th width="3%" class="table-check">
                                        <input id="checkAll" value="all" type="checkbox"/>
                                    </th>
                                    <th width="5%"  class="table-type">状态</th>
                                    <th width="10%"  class="table-title">名称/位置</th>
                                    <th  class="table-type">设备编号</th>
                                    <th  class="table-author">所属分组</th>
                                    <th  class="table-type">设备类型</th>
                                    <th  class="table-type">通讯协议</th>
                                    <th  class="table-type">采集频率</th>
                                    <th  class="table-author">所属用户</th>
                                    <th  class="table-date">修改时间</th>
                                    <th width="20%" class="table-set">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${pageBean.list}" var="li">
                                <tr>
                                    <td>
                                        <input class="checkChildren" value="${li.id}" type="checkbox"/>
                                    </td>
                                    <c:if test="${li.iDeviceStatus==0}">
                                        <td>离线</td>
                                    </c:if>
                                    <c:if test="${li.iDeviceStatus==1}">
                                        <td>在线</td>
                                    </c:if>
                                    <td width="100px" class="tdhiden">
                                        <a href="#allmap" onclick="centerAndZoom(${li.dDeviceLongitude},${li.dDeviceLatitude});" style="cursor: hand;">${li.sDeviceName}</a>
                                        <span class="am-icon-map-marker">${li.sDeviceAddress}</span>
                                    </td>
                                    <td width="100px" class="tdhiden">${li.sDeviceId}</td>
                                    <td>${li.deviceGroup.sGroupName}</td>
                                    <!-- 设备类型 -->
                                    <c:choose>
                                        <c:when test="${li.iDeviceType==0}"><td>默认设备</td></c:when>
                                        <c:when test="${li.iDeviceType==1}"><td>LoRa集中器</td></c:when>
                                        <c:when test="${li.iDeviceType==2}"><td>CoAP/NB-IoT</td></c:when>
                                        <c:when test="${li.iDeviceType==3}"><td>LoRa模块</td></c:when>
                                        <c:when test="${li.iDeviceType==4}"><td>网络io</td></c:when>
                                        <c:when test="${li.iDeviceType==5}"><td>二维码添加</td></c:when>
                                        <c:when test="${li.iDeviceType==6}"><td>LoRaWAN</td></c:when>
                                        <c:when test="${li.iDeviceType==7}"><td>电信 CoAP/NB-IoT</td></c:when>
                                        <c:when test="${li.iDeviceType==8}"><td>PLC云网关</td></c:when>
                                        <c:otherwise><td>未知设备类型:${li.iDeviceType}</td></c:otherwise>
                                    </c:choose>
                                    <!-- 通讯协议 -->
                                    <c:choose>
                                        <c:when test="${li.iProtocol==0}"><td>Modbus RTU</td></c:when>
                                        <c:when test="${li.iProtocol==1}"><td>Modbus TCP</td></c:when>
                                        <c:when test="${li.iProtocol==2}"><td>TCP透传</td></c:when>
                                        <c:when test="${li.iProtocol==3}"><td>DL/T645-97</td></c:when>
                                        <c:when test="${li.iProtocol==4}"><td>DL/T645-07</td></c:when>
                                        <c:when test="${li.iProtocol==5}"><td>烟感协议</td></c:when>
                                        <c:otherwise><td>未知协议类型:${li.iProtocol}</td></c:otherwise>
                                    </c:choose>
                                    <!-- 采集频率 -->
                                    <c:choose>
                                        <c:when test="${(li.iPollingInterval/60)<60}"><td>${li.iPollingInterval/60}分钟</td></c:when>
                                        <c:when test="${(li.iPollingInterval/3600)<24}"><td>${li.iPollingInterval/3600}小时</td></c:when>
                                        <c:when test="${(li.iPollingInterval/86400)<30}"><td>${li.iPollingInterval/86400}天</td></c:when>
                                        <c:otherwise><td>${li.iPollingInterval/86400.0}天</td></c:otherwise>
                                    </c:choose>
                                    <td>${li.company.sCompanyName}</td>
                                    <td class="am-hide-sm-only">${li.dUpdateTime}</td>
                                    <td>
                                        <div class="am-btn-toolbar">
                                            <div class="am-btn-group am-btn-group-xs">
                                                <a href="${pageContext.request.contextPath}/Device/editDevice/${li.id}" class="am-btn am-btn-primary am-btn-xs">
                                                    <span class="am-icon-pencil-square-o"></span> 编辑</a>
                                                <!--<a class="am-btn am-btn-success am-btn-xs am-hide-sm-only">
                                                    <span class="am-icon-copy"></span> 复制</a>-->
                                                <a href="${pageContext.request.contextPath}/Device/delDevice/${li.sDeviceId}" onclick="return confirm('确定删除？')" class="am-btn am-btn-danger am-btn-xs am-hide-sm-only">
                                                    <span class="am-icon-trash-o"></span> 删除</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <div class="am-cf">
                                共 ${pageBean.totalRecord} 个设备，共${pageBean.totalPage }页，当前为${pageBean.pageNum}页
                                <div class="am-fr">
                                    <ul class="am-pagination am-pagination-centered">
                                        <%--当前不是第一页--%>
                                        <c:choose>
                                            <c:when test="${pageBean.pageNum > 1}">
                                                <li>
                                                    <a href="${pageContext.request.contextPath}/Device/deviceList/${pageBean.pageNum-1}">«</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="am-disabled">
                                                    <a href="${pageContext.request.contextPath}/Device/deviceList/${pageBean.pageNum-1}">«</a>
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
                                                    <a href="${pageContext.request.contextPath}/Device/deviceList/${i}">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${pageBean.pageNum < pageBean.totalPage}">
                                                <li>
                                                    <a href="${pageContext.request.contextPath}/Device/deviceList/${pageBean.pageNum+1}">»</a>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="am-disabled">
                                                    <a href="${pageContext.request.contextPath}/Device/deviceList/${pageBean.pageNum+1}">»</a>
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
        </div>
    </div>
    <!-- content end -->
</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");    // 创建Map实例
    map.centerAndZoom(new BMap.Point(100.16, 25.69), 11);  // 初始化地图,设置中心点坐标和地图级别
    map.setCurrentCity("大理");          // 设置地图显示的城市 此项是必须设置的
    //map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
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
    }));//规定 Map 类型控件的默认启用/禁用状态
    map.addControl(new BMap.ScaleControl()); //添加比例尺控件
    var traffic = new BMap.TrafficLayer();        // 创建交通流量图层实例
    map.addTileLayer(traffic);                    // 将图层添加到地图上

    //地图初始化标注
    map.clearOverlays();//清空标注点
    <c:forEach var="li" items="${deviceList}">
    var marker = new BMap.Marker(new BMap.Point(${li.dDeviceLongitude}, ${li.dDeviceLatitude}));// 创建标注
    map.addOverlay(marker);
    </c:forEach>

    //显示全部按钮操作
    $("#showAll").click(function () {
        //地图初始化标注
        map.clearOverlays();//清空标注点
        <c:forEach var="li" items="${deviceList}">
        var marker = new BMap.Marker(new BMap.Point(${li.dDeviceLongitude}, ${li.dDeviceLatitude}));// 创建标注
        map.addOverlay(marker);
        </c:forEach>
    });
    //显示当前页按钮操作
    $("#showCurrentPage").click(function () {
        //地图初始化标注
        map.clearOverlays();//清空标注点
        <c:forEach var="li" items="${pageBean.list}">
        var marker = new BMap.Marker(new BMap.Point(${li.dDeviceLongitude}, ${li.dDeviceLatitude}));// 创建标注
        map.addOverlay(marker);
        </c:forEach>
    });

</script>
<script>
    //定位
    function setPlace(value) {
        var local, point, marker = null;
        local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: fn
        });
        local.search(value);
        function fn() {
            //如果搜索的有结果
            if (local.getResults() != undefined) {
                //map.clearOverlays(); //清除地图上所有覆盖物
                if (local.getResults().getPoi(0)) {
                    point = local.getResults().getPoi(0).point; //获取第一个智能搜索的结果
                    map.centerAndZoom(point, 12);
                } else {
                    alert("未匹配到地点!可拖动地图上的红色图标到精确位置");
                }
            } else {
                alert("未找到搜索结果")
            }
        }
    }
    // 按钮事件
    $("#btn").click(function () {
        setPlace($("#address").val());
    });
    $("#btn0").click(function () {
        var longitude_value=$("#longitude").val();//设置经度变量
        var latitude_value=$("#latitude").val();//设置纬度变量
        map.centerAndZoom(new BMap.Point(longitude_value, latitude_value), 11);
    });

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