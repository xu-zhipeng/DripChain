<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>水滴链 | 编辑设备</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!--百度地图-->
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <!--适应移动设备页面展示-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <!--结束-->
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <link rel="apple-touch-icon-precomposed" href="/DripChain/views/static/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/DripChain/views/static/css/admin.css">
    <script src="/DripChain/views/static/js/jquery2.1.4.min.js"></script>
    <!--百度地图的接口-->
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=3.0&ak=LBIgTRrLI5rhggci3fNeblOnDnO4PIjI"></script>
    <!--百度地图的接口的结束-->
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
    <!--设置地图样式-->
    <style type="text/css">
        #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑";
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
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">编辑设备</strong> /
                    <small>Edit Device</small>
                </div>
            </div>
            <hr/>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>设备类型</strong>
                                <hr/>
                            </div>
                            <P>默认设备：包含有人品牌的DTU、串口服务器等，添加完成后，系统自动分配ID，并通过软件写入设备内完成接入</p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>通讯协议</strong>
                                <hr/>
                            </div>
                            <p>透传云将根据设定的协议格式解析，并根据数据点的设定存入数据库、处理报警、推送给前端。</p>
                            <p>Modbus RTU：服务器将做Modbus RTU主机，主动向设备发送读取数据指令。</p>
                            <p>DL/T645：电表协议，可用于电力抄表，支持97和07两种格式。</p>
                            <p>数据透传：仅希望通过透传云获取数据流，可利用SDK获取设备数据流，也可利用透传组设定好透传关系。</p>
                        </div>
                    </div>
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>通讯密码</strong>
                                <hr/>
                            </div>
                            <p>设置默认设备接入的密码，支持密码自定义，实现不同设备接入密码不同。</p>
                            <p>设备一旦接入成功后轻易不要修改，否则会造成设备由于密码错误无法再次接入。</p>
                        </div>
                    </div>

                </div>
                <script>
                    //根据设备类型变化表单
                    var iDeviceGroupIdGroup = '<div class="am-form-group" id="iDeviceGroupIdGroup">\n' +
                        '                                <label for="iDeviceGroupId" class="am-u-sm-3 am-form-label">设备分组\n' +
                        '                                    <span style="color: red;">*</span>\n' +
                        '                                </label>\n' +
                        '                                <div class="am-u-sm-6">\n' +
                        '                                    <select name="iDeviceGroupId" id="iDeviceGroupId" required>\n' +
                        '                                        <option value="">请选择...</option>\n' +
                        '                                        <c:forEach items="${DeviceGroupList}" var="i">\n' +
                        '                                                <c:if test="${device.deviceGroup.id==i.id}">\n' +
                        '                                                    <option value="${i.id}" selected>${i.sGroupName}</option>\n' +
                        '                                                </c:if>\n' +
                        '                                                <c:if test="${device.deviceGroup.id!=i.id}">\n' +
                        '                                                    <option value="${i.id}">${i.sGroupName}</option>\n' +
                        '                                                </c:if>\n' +
                        '                                        </c:forEach>\n' +
                        '                                    </select>\n' +
                        '                                </div>\n' +
                        '                                <div class="am-u-sm-3"></div>\n' +
                        '                            </div>';
                    var sDeviceNameGroup = '<div class="am-form-group" id="sDeviceNameGroup">\n' +
                        '                            <label for="sDeviceName" class="am-u-sm-3 am-form-label">设备名称\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-9">\n' +
                        '                                <input type="text" id="sDeviceName" name="sDeviceName" value="${device.sDeviceName}" placeholder="设备名称" required>\n' +
                        '                                <small>输入你的设备名称。</small>\n' +
                        '                            </div>\n' +
                        '                        </div>';
                    var sDeviceIdGroupAuto = '<div class="am-form-group" id="sDeviceIdGroupAuto">\n' +
                        '                            <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="sDeviceIdLabel">设备ID\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-9">\n' +
                        '                                <input type="text" id="sDeviceId" name="sDeviceId" value="${device.sDeviceId}" placeholder="设备ID 自动生成" readonly>\n' +
                        '                            </div>\n' +
                        '                        </div>';
                    var sDeviceIdGroup = '<div class="am-form-group" id="sDeviceIdGroup">\n' +
                        '                            <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="sDeviceIdLabel">ID\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-9">\n' +
                        '                                <input type="text" id="sDeviceId" name="sDeviceId" value="${device.sDeviceId}" required>\n' +
                        '                            </div>\n' +
                        '                        </div>';
                    var sDevicePassGroup = '<div class="am-form-group" id="sDevicePassGroup">\n' +
                        '                            <label for="sDevicePass" class="am-u-sm-3 am-form-label">通讯密码\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-9">\n' +
                        '                                <input type="password" id="sDevicePass" name="sDevicePass" value="${device.sDevicePass}"\n' +
                        '                                       placeholder="请输入你的通讯密码 默认12345678" pattern="^$|^\\w{8}$"\n' +
                        '                                       style="width: 300px;height: 38px;display: inline-block;">&nbsp;&nbsp;&nbsp;<span\n' +
                        '                                    id="seepassword" class="am-icon-eye" style="cursor:pointer;"></span>\n' +
                        '                            </div>\n' +
                        '                        </div>';
                    var iPollingIntervalGroup = '<div class="am-form-group" id="iPollingIntervalGroup">\n' +
                        '                            <label for="iPollingInterval" class="am-u-sm-3 am-form-label">采集频率\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-6">\n' +
                        '                                <select name="iPollingInterval" id="iPollingInterval" required>\n' +
                        '                                    <option value="">请选择...</option>\n' +
                        '                                    <option value="60">1分钟</option>\n' +
                        '                                    <option value="180">3分钟</option>\n' +
                        '                                    <option value="300">5分钟</option>\n' +
                        '                                    <option value="600">10分钟</option>\n' +
                        '                                    <option value="1800">30分钟</option>\n' +
                        '                                    <option value="3600">1小时</option>\n' +
                        '                                    <option value="18000">5小时</option>\n' +
                        '                                    <option value="86400">1天</option>\n' +
                        '                                    <option value="432000">5天</option>\n' +
                        '                                    <option value="1296000">15天</option>\n' +
                        '                                </select>\n' +
                        '                            </div>\n' +
                        '                            <div class="am-u-sm-3"></div>\n' +
                        '                        </div>';
                    var DeviceSlaveGroup = '<div class="am-form-group" id="DeviceSlaveGroup">\n' +
                        '                                <label for="sImg" class="am-u-sm-3 am-form-label">从机\n' +
                        '                                </label>\n' +
                        '                                <div class="am-u-sm-9">\n' +
                        '                                    <div class="am-scrollable-horizontal">\n' +
                        '                                        <table id="deviceSlaveTable"\n' +
                        '                                               class="am-table am-table-bordered am-table-radius am-table-striped am-table-hover am-text-nowrap">\n' +
                        '                                            <thead>\n' +
                        '                                            <tr>\n' +
                        '                                                <td width="20%">序列号</td>\n' +
                        '                                                <td width="20%">名称</td>\n' +
                        '                                                <td width="20%">设备号</td>\n' +
                        '                                                <td width="25%">关联模板</td>\n' +
                        '                                                <td width="15%">操作</td>\n' +
                        '                                            </tr>\n' +
                        '                                            </thead>\n' +
                        '                                            <tbody>\n' +
                        '                                            <c:forEach var="slave" items="${device.deviceSlaves}">\n' +
                        '                                                <tr class="am-success">\n' +
                        '                                                    <td><input type="text" name="sSlaveIndex"\n' +
                        '                                                               value="${slave.sSlaveIndex}" required/></td>\n' +
                        '                                                    <td><input type="text" name="sSlaveName" value="${slave.sSlaveName}"\n' +
                        '                                                               required/></td>\n' +
                        '                                                    <td><input type="text" name="sSlaveAddr" value="${slave.sSlaveAddr}"\n' +
                        '                                                               required/></td>\n' +
                        '                                                    <td>\n' +
                        '                                                        <select name="iDataTemplateId" required>\n' +
                        '                                                            <option value="">请选择</option>\n' +
                        '                                                            <c:forEach items="${DataTemplateList}" var="i">\n' +
                        '                                                                <c:if test="${slave.dataTemplate.id==i.id}">\n' +
                        '                                                                    <option value="${i.id}" selected>${i.sTemplateName}</option>\n' +
                        '                                                                </c:if>\n' +
                        '                                                                <c:if test="${slave.dataTemplate.id!=i.id}">\n' +
                        '                                                                    <option value="${i.id}">${i.sTemplateName}</option>\n' +
                        '                                                                </c:if>\n' +
                        '                                                            </c:forEach>\n' +
                        '                                                        </select>\n' +
                        '                                                    </td>\n' +
                        '                                                    <td>\n' +
                        '                                                        <button type="button" onclick="deleteTr(this);"\n' +
                        '                                                                class="am-btn am-btn-danger am-radius">删除\n' +
                        '                                                        </button>\n' +
                        '                                                    </td>\n' +
                        '                                                </tr>\n' +
                        '                                            </c:forEach>\n' +
                        '                                            <tr class="am-success">\n' +
                        '                                                <td colspan="5" align="center">\n' +
                        '                                                    <button type="button" onclick="addTr();"\n' +
                        '                                                            class="am-btn am-btn-success am-radius">添加从机\n' +
                        '                                                    </button>\n' +
                        '                                                </td>\n' +
                        '                                            </tr>\n' +
                        '                                            </tbody>\n' +
                        '                                        </table>\n' +
                        '                                    </div>\n' +
                        '                                </div>\n' +
                        '                            </div>';
                    var sImgGroup = '<div class="am-form-group" id="sImgGroup">\n' +
                        '                                <label for="sImg" class="am-u-sm-3 am-form-label">设备图片\n' +
                        '                                </label>\n' +
                        '                                <div class="am-u-sm-6">\n' +
                        '                                    <input type="file" id="sImg" name="sImg">\n' +
                        '                                    <p class="am-form-help">请选择要上传的文件..</p>\n' +
                        '                                </div>\n' +
                        '                                <div class="am-u-sm-3">\n' +
                        '                                    <img src="/DripChain/${device.sImg}" width="80px" height="80px">\n' +
                        '                                </div>\n' +
                        '                            </div>';
                    var SNGroup = '<div class="am-form-group" id="SNGroup">\n' +
                        '                            <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="SNlabel">SN\n' +
                        '                                <span style="color: red;">*</span>\n' +
                        '                            </label>\n' +
                        '                            <div class="am-u-sm-9">\n' +
                        '                                <input type="text" id="sSn" name="sSn" value="${device.sSn}" required>\n' +
                        '                            </div>\n' +
                        '                        </div>';

                    function innitForm(value) {
                        switch (value) {
                            case 0:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup)
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup)
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroupAuto);
                                $("#iProtocolGroup").before(sDevicePassGroup);
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").show();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", true);
                                $("#iProtocolContent").children().not(".Type0").hide();
                                $("#iProtocolContent").children().filter(".Type0").show();
                                $("#DeviceFormContent").append(sImgGroup);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 6:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroup);
                                $("#iProtocolGroup").before(SNGroup);
                                $("#sDeviceIdLabel").html('devEUI<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").show();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", true);
                                $("#iProtocolContent").children().not(".Type6").hide();
                                $("#iProtocolContent").children().filter(".Type6").show();
                                $("#DeviceFormContent").append(sImgGroup);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 4:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroup);
                                $("#iProtocolGroup").before(SNGroup);
                                $("#sDeviceIdLabel").html('MAC/IMEI<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").hide();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", false);
                                $("#DeviceMap").hide();
                                $("#sDeviceAddress").attr("required", false);
                                $("#dDeviceLongitude").attr("required", false);
                                $("#dDeviceLatitude").attr("required", false);
                                break;
                            case 5:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                //这个位置是 iDeviceTypeGroup
                                $("#iDeviceTypeGroup").after(SNGroup);
                                $("#iDeviceTypeGroup").after(sDeviceIdGroup);
                                $("#sDeviceIdLabel").html('deviceId<span style="color: red;">*</span>');
                                $("#SNlabel").html('verifyCode<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").hide();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", false);
                                $("#DeviceMap").hide();
                                $("#sDeviceAddress").attr("required", false);
                                $("#dDeviceLongitude").attr("required", false);
                                $("#dDeviceLatitude").attr("required", false);
                                break;
                            case 3:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroup);
                                $("#iProtocolGroup").before(SNGroup);
                                $("#sDeviceIdLabel").html('ID<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").show();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", true);
                                $("#iProtocolContent").children().not(".Type327").hide();
                                $("#iProtocolContent").children().filter(".Type327").show();
                                $("#DeviceFormContent").append(sImgGroup);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 1:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iDeviceTypeGroup").after(sImgGroup);
                                $("#iDeviceTypeGroup").after(SNGroup);
                                $("#iDeviceTypeGroup").after(sDeviceIdGroup);
                                $("#sDeviceIdLabel").html('MAC<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN/校验码<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").hide();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", false);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 2:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroup);
                                $("#iProtocolGroup").before(SNGroup);
                                $("#sDeviceIdLabel").html('IMEI<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").show();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", true);
                                $("#iProtocolContent").children().not(".Type327").hide();
                                $("#iProtocolContent").children().filter(".Type327").show();
                                $("#DeviceFormContent").append(sImgGroup);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 7:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iProtocolGroup").before(sDeviceIdGroup);
                                $("#iProtocolGroup").before(SNGroup);
                                $("#sDeviceIdLabel").html('ID<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").show();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", true);
                                $("#iProtocolContent").children().not(".Type327").hide();
                                $("#iProtocolContent").children().filter(".Type327").show();
                                $("#DeviceFormContent").append(sImgGroup);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                            case 9:
                                $("#DeviceFormContent").children().not(".NoClear").remove();
                                $("#iDeviceTypeGroup").before(iDeviceGroupIdGroup);
                                $("#iDeviceTypeGroup").before(sDeviceNameGroup);
                                //这个位置是 iDeviceTypeGroup
                                $("#iDeviceTypeGroup").after(sImgGroup);
                                $("#iDeviceTypeGroup").after(SNGroup);
                                $("#iDeviceTypeGroup").after(sDeviceIdGroup);
                                $("#sDeviceIdLabel").html('MAC<span style="color: red;">*</span>');
                                $("#SNlabel").html('SN<span style="color: red;">*</span>');
                                //这个位置是 iProtocolGroup
                                $("#iProtocolGroup").hide();
                                $("input:radio[name='iProtocol']").attr("checked", false);
                                $("input:radio[name='iProtocol']").attr("required", false);
                                $("#DeviceMap").show();
                                $("#sDeviceAddress").attr("required", true);
                                $("#dDeviceLongitude").attr("required", true);
                                $("#dDeviceLatitude").attr("required", true);
                                break;
                        }
                        $("input:radio[name='iDeviceType'][value='"+value+"']").attr("checked", 'checked');
                    }

                    $(function () {
                        //初始化
                        innitForm(${device.iDeviceType});
                        var iProtocol=${device.iProtocol};
                        if(iProtocol==0 || iProtocol==1 || iProtocol==3 || iProtocol==4 ){
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                            $("#sImgGroup").before(iPollingIntervalGroup);
                            $("#sImgGroup").after(DeviceSlaveGroup);
                        }
                        //默认选择类型 radio
                        $("input:radio[name='iDeviceType'][value='${device.iDeviceType}']").attr("checked", 'checked');
                        //默认选择协议 radio
                        $("input:radio[name='iProtocol'][value='${device.iProtocol}']").attr("checked", 'checked');
                        //$("input:radio[name='iProtocol']").eq(${device.iProtocol}).attr("checked",'checked');
                        //默认选择 设备分组 采集频率 select
                        $("select[name='iPollingInterval']").val(${device.iPollingInterval});
                        $("select[name='iDeviceGroupId']").val(${device.deviceGroup.id});
                        //$("select[name='iPollingInterval'] option[value='${device.iPollingInterval}']").attr("selected", 'selected');

                        $("input:radio[name='iDeviceType'][value='0']").click(function () {
                            innitForm(0);
                            $("input:radio[name='iProtocol'][value='2']").attr("checked", 'checked');
                        });
                        $("input:radio[name='iDeviceType'][value='6']").click(function () {
                            innitForm(6);
                            $("input:radio[name='iProtocol'][value='2']").attr("checked", 'checked');
                        });
                        $("input:radio[name='iDeviceType'][value='4']").click(function () {
                            innitForm(4);
                        });
                        $("input:radio[name='iDeviceType'][value='5']").click(function () {
                            innitForm(5);
                        });
                        $("input:radio[name='iDeviceType'][value='3']").click(function () {
                            innitForm(3);
                            $("input:radio[name='iProtocol'][value='2']").attr("checked", 'checked');
                        });
                        $("input:radio[name='iDeviceType'][value='1']").click(function () {
                            innitForm(1);
                        });
                        $("input:radio[name='iDeviceType'][value='2']").click(function () {
                            innitForm(2);
                            $("input:radio[name='iProtocol'][value='2']").attr("checked", 'checked');
                        });
                        $("input:radio[name='iDeviceType'][value='7']").click(function () {
                            innitForm(7);
                            $("input:radio[name='iProtocol'][value='2']").attr("checked", 'checked');
                        });
                        $("input:radio[name='iDeviceType'][value='9']").click(function () {
                            innitForm(9);
                        });
                        //协议变化操作
                        $("input:radio[name='iProtocol'][value='0']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                            $("#sImgGroup").before(iPollingIntervalGroup);
                            $("#sImgGroup").after(DeviceSlaveGroup);
                        });
                        $("input:radio[name='iProtocol'][value='1']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                            $("#sImgGroup").before(iPollingIntervalGroup);
                            $("#sImgGroup").after(DeviceSlaveGroup);
                        });
                        $("input:radio[name='iProtocol'][value='2']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                        });
                        $("input:radio[name='iProtocol'][value='3']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                            $("#sImgGroup").before(iPollingIntervalGroup);
                            $("#sImgGroup").after(DeviceSlaveGroup);
                        });
                        $("input:radio[name='iProtocol'][value='4']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                            $("#sImgGroup").before(iPollingIntervalGroup);
                            $("#sImgGroup").after(DeviceSlaveGroup);
                        });
                        $("input:radio[name='iProtocol'][value='5']").change(function () {
                            $("#iPollingIntervalGroup").remove();
                            $("#DeviceSlaveGroup").remove();
                        });
                    });
                </script>
                <script>
                    $(function () {
                        var addDeviceMessage = "${param.addDeviceMessage}";
                        if (!$.isEmptyObject(addDeviceMessage)) {
                            alert(addDeviceMessage);
                            history.back();
                        }
                    });
                    $(function () {
                        //查看密码
                        $("#seepassword").click(function () {
                            var type = $("#sDevicePass").attr("type");
                            if (type == "password") {
                                $(this).removeClass("am-icon-eye");
                                $(this).addClass("am-icon-eye-slash");
                                $("#sDevicePass").attr("type", "text");
                            } else {
                                $(this).removeClass("am-icon-eye-slash");
                                $(this).addClass("am-icon-eye");
                                $("#sDevicePass").attr("type", "password");
                            }
                        });
                    });
                </script>
                <script>
                    //设备从机js
                    function deleteTr(obj) {
                        $(obj).parent().parent().remove();
                    }

                    function addTr() {
                        var tableLength = $("#deviceSlaveTable tbody").children("tr").length;
                        //alert(tableLength);
                        $("#deviceSlaveTable tbody").children("tr").eq(tableLength - 1).remove();
                        var tableHtml = $("#deviceSlaveTable tbody").html();
                        //alert(tableHtml);
                        $("#deviceSlaveTable tbody").append('<tr class="am-success">\n' +
                            '                                        <td><input type="text" name="sSlaveIndex" required/></td>\n' +
                            '                                        <td><input type="text" name="sSlaveName" required/></td>\n' +
                            '                                        <td><input type="text" name="sSlaveAddr" required/></td>\n' +
                            '                                        <td>\n' +
                            '                                            <select name="iDataTemplateId" required>\n' +
                            '                                                <option value="">请选择</option>\n' +
                            '                                                <c:forEach items="${DataTemplateList}" var="i">\n' +
                            '                                                    <option value="${i.id}">${i.sTemplateName}</option>\n' +
                            '                                                </c:forEach>\n' +
                            '                                            </select>\n' +
                            '                                        </td>\n' +
                            '                                        <td><button type="button" onclick="deleteTr(this);" class="am-btn am-btn-danger am-radius">删除</button></td>\n' +
                            '                                    </tr>');
                        $("#deviceSlaveTable tbody").append('<tr class="am-success">\n' +
                            '                                        <td colspan="5" align="center"><button type="button" onclick="addTr();" class="am-btn am-btn-success am-radius">添加从机</button></td>\n' +
                            '                                    </tr>');
                    }
                </script>
                <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                    <form class="am-form am-form-horizontal"
                          action="${pageContext.request.contextPath}/Device/doEditDevice" method="post"
                          enctype="multipart/form-data">
                        <!-- 设备ID值隐藏 -->
                        <input type="hidden" value="${device.id}" name="DevicePK">
                        <!-- 除地图外的表单元素 Start -->
                        <div id="DeviceFormContent">
                            <div class="am-form-group" id="iDeviceGroupIdGroup">
                                <label for="iDeviceGroupId" class="am-u-sm-3 am-form-label">设备分组
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-6">
                                    <select name="iDeviceGroupId" id="iDeviceGroupId" required>
                                        <option value="">请选择...</option>
                                        <c:forEach items="${DeviceGroupList}" var="i">
                                                <c:if test="${device.deviceGroup.id==i.id}">
                                                    <option value="${i.id}" selected>${i.sGroupName}</option>
                                                </c:if>
                                                <c:if test="${device.deviceGroup.id!=i.id}">
                                                    <option value="${i.id}">${i.sGroupName}</option>
                                                </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="am-u-sm-3"></div>
                            </div>
                            <div class="am-form-group" id="sDeviceNameGroup">
                                <label for="sDeviceName" class="am-u-sm-3 am-form-label">设备名称
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-9">
                                    <input type="text" id="sDeviceName" value="${device.sDeviceName}" name="sDeviceName"
                                           placeholder="设备名称" required>
                                    <small>输入你的设备名称。</small>
                                </div>
                            </div>
                            <div class="am-form-group NoClear" id="iDeviceTypeGroup">
                                <label class="am-u-sm-3 am-form-label">设备类型
                                </label>
                                <div class="am-u-sm-9">
                                    <label class="am-radio-inline">
                                        <input type="radio" value="0" name="iDeviceType" required/> 默认设备
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="6" name="iDeviceType" required/> LoRaWAN模块
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="4" name="iDeviceType" required/> 网络io
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="5" name="iDeviceType" required/> 二维码添加
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="3" name="iDeviceType" required/> LoRa模块
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="1" name="iDeviceType" required/> LoRa集中器
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="2" name="iDeviceType" required/> CoAP/NB-IoT
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="7" name="iDeviceType" required/> 电信CoAP/NB-IoT
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="9" name="iDeviceType" required/> PLC云网关
                                    </label>
                                </div>
                            </div>
                            <div class="am-form-group" id="sDeviceIdGroupAuto">
                                <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="sDeviceIdLabel">设备ID
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-9">
                                    <input type="text" id="sDeviceId" name="sDeviceId" value="${device.sDeviceId}"
                                           placeholder="设备ID 自动生成" readonly>
                                </div>
                            </div>
                            <div class="am-form-group" id="sDevicePassGroup">
                                <label for="sDevicePass" class="am-u-sm-3 am-form-label">通讯密码
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-9">
                                    <input type="password" id="sDevicePass" name="sDevicePass"
                                           value="${device.sDevicePass}" placeholder="请输入你的通讯密码 默认12345678"
                                           pattern="^$|^\w{8}$"
                                           style="width: 300px;height: 38px;display: inline-block;">&nbsp;&nbsp;&nbsp;<span
                                        id="seepassword" class="am-icon-eye" style="cursor:pointer;"></span>
                                </div>
                            </div>
                            <!-- 设备ID手动填写表单 -->
                            <%--<div class="am-form-group" id="sDeviceIdGroup">
                                <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="sDeviceIdLabel">ID\n' +
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-9">
                                    <input type="text" id="sDeviceId" name="sDeviceId" value="${device.sDeviceId}" required>
                                </div>
                            </div>--%>
                            <div class="am-form-group" id="SNGroup">
                                <label for="sDeviceId" class="am-u-sm-3 am-form-label" id="SNlabel">SN
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-9">
                                    <input type="text" id="sSn" name="sSn" value="${device.sSn}" required>
                                </div>
                            </div>
                            <div class="am-form-group NoClear" id="iProtocolGroup">
                                <label class="am-u-sm-3 am-form-label">通讯协议
                                </label>
                                <div class="am-u-sm-9" id="iProtocolContent">
                                    <label class="am-radio-inline Type0 Type327 Type6">
                                        <input type="radio" value="0" name="iProtocol" required/> Modbus RTU
                                    </label>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label class="am-radio-inline Type0">
                                        <input type="radio" value="1" name="iProtocol" required/> Modbus TCP
                                    </label>
                                    <label class="am-radio-inline Type0 Type327 Type6">
                                        <input type="radio" value="2" name="iProtocol" required/> 数据透传
                                    </label>
                                    <label class="am-radio-inline Type0 Type327">
                                        <input type="radio" value="3" name="iProtocol" required/> DL/T645-97
                                    </label>
                                    <label class="am-radio-inline Type0 Type327">
                                        <input type="radio" value="4" name="iProtocol" required/> DL/T645-07
                                    </label>
                                    <label class="am-radio-inline Type327">
                                        <input type="radio" value="5" name="iProtocol" required/> 有人烟感
                                    </label>
                                </div>
                            </div>
                            <div class="am-form-group" id="iPollingIntervalGroup">
                                <label for="iPollingInterval" class="am-u-sm-3 am-form-label">采集频率
                                    <span style="color: red;">*</span>
                                </label>
                                <div class="am-u-sm-6">
                                    <select name="iPollingInterval" id="iPollingInterval" required>
                                        <option value="">请选择...</option>
                                        <option value="60">1分钟</option>
                                        <option value="180">3分钟</option>
                                        <option value="300">5分钟</option>
                                        <option value="600">10分钟</option>
                                        <option value="1800">30分钟</option>
                                        <option value="3600">1小时</option>
                                        <option value="18000">5小时</option>
                                        <option value="86400">1天</option>
                                        <option value="432000">5天</option>
                                        <option value="1296000">15天</option>
                                    </select>
                                </div>
                                <div class="am-u-sm-3"></div>
                            </div>
                            <div class="am-form-group" id="DeviceSlaveGroup">
                                <label for="sImg" class="am-u-sm-3 am-form-label">从机
                                </label>
                                <div class="am-u-sm-9">
                                    <div class="am-scrollable-horizontal">
                                        <table id="deviceSlaveTable"
                                               class="am-table am-table-bordered am-table-radius am-table-striped am-table-hover am-text-nowrap">
                                            <thead>
                                            <tr>
                                                <td width="20%">序列号</td>
                                                <td width="20%">名称</td>
                                                <td width="20%">设备号</td>
                                                <td width="25%">关联模板</td>
                                                <td width="15%">操作</td>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="slave" items="${device.deviceSlaves}">
                                                <tr class="am-success">
                                                    <td><input type="text" name="sSlaveIndex"
                                                               value="${slave.sSlaveIndex}" required/></td>
                                                    <td><input type="text" name="sSlaveName" value="${slave.sSlaveName}"
                                                               required/></td>
                                                    <td><input type="text" name="sSlaveAddr" value="${slave.sSlaveAddr}"
                                                               required/></td>
                                                    <td>
                                                        <select name="iDataTemplateId" required>
                                                            <option value="">请选择</option>
                                                            <c:forEach items="${DataTemplateList}" var="i">
                                                                <c:if test="${slave.dataTemplate.id==i.id}">
                                                                    <option value="${i.id}" selected>${i.sTemplateName}</option>
                                                                </c:if>
                                                                <c:if test="${slave.dataTemplate.id!=i.id}">
                                                                    <option value="${i.id}">${i.sTemplateName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <button type="button" onclick="deleteTr(this);"
                                                                class="am-btn am-btn-danger am-radius">删除
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr class="am-success">
                                                <td colspan="5" align="center">
                                                    <button type="button" onclick="addTr();"
                                                            class="am-btn am-btn-success am-radius">添加从机
                                                    </button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="am-form-group" id="sImgGroup">
                                <label for="sImg" class="am-u-sm-3 am-form-label">设备图片
                                </label>
                                <div class="am-u-sm-6">
                                    <input type="file" id="sImg" name="sImg">
                                    <p class="am-form-help">请选择要上传的文件..</p>
                                </div>
                                <div class="am-u-sm-3">
                                    <img src="/DripChain/${device.sImg}" width="80px" height="80px">
                                </div>
                            </div>
                        </div>
                        <!-- 除地图外的表单元素 Start -->
                        <div class="am-form-group" id="DeviceMap">
                            <label for="allmap" class="am-u-sm-3 am-form-label">设备位置
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <div style="width: 500px;height:500px;clear: both;">
                                    <!--百度地图-->
                                    <div id="allmap"></div>
                                </div>
                                <div id="r-result">
                                    <div>
                                        <label>当前位置:</label>
                                        <span id="address"></span>
                                    </div>
                                    <div>
                                        <label>经度:</label>
                                        <span id="longitude"></span>
                                        <label>纬度:</label>
                                        <span id="latitude"></span>
                                    </div>
                                    <div>
                                        地址:<br>
                                        <input id="sDeviceAddress" name="sDeviceAddress" value="${device.sDeviceAddress}" type="text" style="width: 80%;display: inline-block;" required/>
                                        <button type="button" id="btn" class="am-btn am-btn-primary" >定位</button><br>
                                        经度:
                                        <input id="dDeviceLongitude" name="dDeviceLongitude"
                                               value="${device.dDeviceLongitude}" type="text" required/>
                                        纬度:
                                        <input id="dDeviceLatitude" name="dDeviceLatitude"
                                               value="${device.dDeviceLatitude}" type="text" required/>
                                    </div>
                                </div>
                                <!--结束-->
                            </div>
                        </div>
                        <div class="am-form-group" id="DeviceSubmit">
                            <div class="am-u-sm-9 am-u-sm-push-3">
                                <input type="submit" class="am-btn am-btn-primary" value="保存修改"/>
                            </div>
                        </div>
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
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
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
    $("#allmap").mouseenter(function () {
    });

    // 百度地图API功能
    var longitude_value;//设置经度变量
    var latitude_value;//设置纬度变量
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
    //map.removeTileLayer(traffic);                // 将图层移除

    //地图初始化标注
    var marker = new BMap.Marker(new BMap.Point(${device.dDeviceLongitude}, ${device.dDeviceLatitude}));// 创建标注
    map.addOverlay(marker);
    //单击获取经纬度和单击获取地名
    map.addEventListener("click", function (e) {
        longitude_value = e.point.lng;  //经度
        latitude_value = e.point.lat;  //纬度
        // alert(e.point.lng + "," + e.point.lat);
        //地图标注
        map.clearOverlays();//清空标注点
        var point = new BMap.Point(longitude_value, latitude_value);
        var marker = new BMap.Marker(point);// 创建标注
        map.addOverlay(marker);
        marker.enableDragging();
        marker.addEventListener("dragend", function (e) {//拖拽后更新经纬度
            longitude_value = e.point.lng;
            latitude_value = e.point.lat;
            document.getElementById("longitude").innerHTML = longitude_value; //经度
            document.getElementById("latitude").innerHTML = latitude_value;  //纬度
            document.getElementById("dDeviceLongitude").value = longitude_value;
            document.getElementById("dDeviceLatitude").value = latitude_value;
            var point = new BMap.Point(longitude_value, latitude_value);  //获取当前地理名称
            var gc = new BMap.Geocoder();
            gc.getLocation(point, function (rs) {
                var addComp = rs.addressComponents;//查询地址组对象
                document.getElementById("address").innerHTML = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                //将地址添加进隐藏表单进行提交
                document.getElementById("sDeviceAddress").value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
            });
        });
        document.getElementById("longitude").innerHTML = longitude_value; //经度
        document.getElementById("latitude").innerHTML = latitude_value;  //纬度
        //把经纬度添加进隐藏表单，进行提交
        document.getElementById("dDeviceLongitude").value = longitude_value;
        document.getElementById("dDeviceLatitude").value = latitude_value;
        var point = new BMap.Point(longitude_value, latitude_value);  //获取当前地理名称
        var gc = new BMap.Geocoder();
        gc.getLocation(point, function (rs) {
            var addComp = rs.addressComponents;//查询地址组对象
            document.getElementById("address").innerHTML = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
            //将地址添加进隐藏表单进行提交
            document.getElementById("sDeviceAddress").value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
        });
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
                map.clearOverlays(); //清除地图上所有覆盖物
                if (local.getResults().getPoi(0)) {
                    point = local.getResults().getPoi(0).point; //获取第一个智能搜索的结果
                    map.centerAndZoom(point, 12);
                    marker = new BMap.Marker(point); // 创建标注
                    map.addOverlay(marker); // 将标注添加到地图中
                    document.getElementById("longitude").innerHTML = point.lng; //经度
                    document.getElementById("latitude").innerHTML = point.lat;  //纬度
                    document.getElementById("dDeviceLongitude").value = point.lng;
                    document.getElementById("dDeviceLatitude").value = point.lat;
                    var gc = new BMap.Geocoder();
                    gc.getLocation(point, function (rs) {
                        var addComp = rs.addressComponents;//查询地址组对象
                        document.getElementById("address").innerHTML = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                        //将地址添加进隐藏表单进行提交
                        document.getElementById("sDeviceAddress").value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                    });
                    marker.enableDragging(); // 可拖拽
                    //alert("当前定位经度:" + point.lng + "纬度:" + point.lat);
                    marker.addEventListener("dragend", function (e) {//拖拽后更新经纬度
                        longitude_value = e.point.lng;
                        latitude_value = e.point.lat;
                        var point = new BMap.Point(longitude_value, latitude_value);  //获取当前地理名称
                        document.getElementById("longitude").innerHTML = longitude_value; //经度
                        document.getElementById("latitude").innerHTML = latitude_value;  //纬度
                        document.getElementById("dDeviceLongitude").value = longitude_value;
                        document.getElementById("dDeviceLatitude").value = latitude_value;
                        //alert("当前定位经度:" + longitude_value + "纬度:" + longitude_value);
                        var gc = new BMap.Geocoder();
                        gc.getLocation(point, function (rs) {
                            var addComp = rs.addressComponents;//查询地址组对象
                            document.getElementById("address").innerHTML = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                            //将地址添加进隐藏表单进行提交
                            document.getElementById("sDeviceAddress").value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                        });
                    });
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
        setPlace($("#sDeviceAddress").val());
    });
</script>