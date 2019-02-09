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
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">添加警报</strong> /
                    <small>Add Alarm</small>
                </div>
            </div>

            <hr/>

            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;"><strong>超标预警设置</strong>
                                <hr/>
                            </div>
                            <p> &nbsp;&nbsp;&nbsp;&nbsp;超标预警可以设置不同的设备和数据点绑定不同的报警方式。<br> &nbsp;&nbsp;&nbsp;&nbsp;当设备触发报警条件时会进入报警状态，服务器推送报警消息，后面的报警信息将不再推送，直到恢复正常数据时推送设备恢复消息。<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;触发器仅支持非数据透传的通讯协议设备。</p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>触发规则</strong>
                                <hr/>
                            </div>
                            <p> 默认触发规则为状态切换报警：</p>
                            <p>例：温度大于40报警；温度到50会触发报警推送并存储报警信息，再次上传“60”不会触发报警且不保存数据。温度到30，会触发恢复报警推送并存储报警消息。</p>
                        </div>
                    </div>


                </div>

                <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                    <form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/Alarm/doAddAlarm" method="post">
                        <div class="am-form-group">
                            <label for="sTriggerName" class="am-u-sm-3 am-form-label">名称<span style="color: red;">*</span></label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sTriggerName" id="sTriggerName" placeholder="名称" required>
                                <small>输入你的报警名称。</small>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="iDatapointId" class="am-u-sm-3 am-form-label">选择设备<span
                                    style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-6">
                                <select name="iDeviceId" id="iDeviceId" required>
                                    <option value="">请选择...</option>
                                    <c:forEach items="${DeviceList}" var="li">
                                        <option value="${li.id}">${li.sDeviceName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="iDatatemplateId" class="am-u-sm-3 am-form-label">选择数据模板<span
                                    style="color: red;">*</span></label>
                            <div class="am-u-sm-6">
                                <select name="iDatatemplateId" id="iDatatemplateId" required>
                                    <option value="">请选择...</option>
                                    <c:forEach items="${DataTemplateList}" var="i">
                                        <option value="${i.id}">${i.sTemplateName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>
                        <script>
                            $(function () {
                                $("#iDatatemplateId").change(function () {
                                    var value=$("#iDatatemplateId").val();
                                    $("#iDatapointId").val("");
                                    $("#iDatapointId").children().not("."+value).hide();
                                    $("#iDatapointId").children().eq(0).show();
                                    $("#iDatapointId").children().filter("."+value).show();
                                });
                                $("#sTriggerCondition").change(function () {
                                    var value=$("#sTriggerCondition").val();
                                    if(value==2 || value==6 || value==3){
                                        //先移除表单
                                        $("input[name='iMax']").remove();
                                        $("input[name='iMin']").remove();
                                        $("#sTriggerCondition").css({"width": "40%","display":"inline-block"});
                                        $("#sTriggerConditionContent").append('<input type="text" name="iMin" placeholder="A" style="width: 40%;display: inline-block;" required>');
                                    }else if(value==4 || value==5){
                                        $("input[name='iMax']").remove();
                                        $("input[name='iMin']").remove();
                                        $("#sTriggerCondition").css({"width": "30%","display":"inline-block"});
                                        $("#sTriggerConditionContent").append('<input type="text" name="iMin" placeholder="A" style="width: 30%;display: inline-block;" required>\n' +
                                            '                                <input type="text" name="iMax" placeholder="B" style="width: 30%;display: inline-block;" required>');
                                    }else{
                                        $("input[name='iMax']").remove();
                                        $("input[name='iMin']").remove();
                                        $("#sTriggerCondition").css("width","64.5%");
                                    }

                                });
                            });
                        </script>
                        <div class="am-form-group">
                            <label for="iDatapointId" class="am-u-sm-3 am-form-label">选择数据点<span
                                    style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-6">
                                <select name="iDatapointId" id="iDatapointId" required>
                                    <option value="">请选择...</option>
                                    <c:forEach items="${DataTemplateList}" var="li">
                                        <c:forEach var="i" items="${li.dataPoints}">
                                            <option class="${li.id}" value="${i.id}">${i.sName}</option>
                                        </c:forEach>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="sTriggerCondition" class="am-u-sm-3 am-form-label">报警条件<span
                                    style="color: red;">*</span>
                            </label>
                            <div id="sTriggerConditionContent" class="am-u-sm-9">
                                <select name="sTriggerCondition" id="sTriggerCondition" style="width: 64.5%;" required>
                                    <option value="">请选择...</option>
                                    <option value="0">开关ON</option>
                                    <option value="1">开关OFF</option>
                                    <option value="2">数值低于A</option>
                                    <option value="3">数值高于A</option>
                                    <option value="4">数值在AB之间</option>
                                    <option value="5">数值高于B低于A</option>
                                    <option value="6">数值等于A</option>
                                </select>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">保存规则
                                <button style="border: none;" type="button" class="am-btn am-btn-default am-round"
                                        data-am-popover="{theme: 'secondary xs',content: '<p>保存规则指的是报警数据的保存规则： </p><p><strong>保存</strong></p> <p>保存触发器触发报警时的数据，以及从报警状态恢复到正常状态时的数据。</p> <p><strong>不保存</strong></p> <p>不保存报警数据。</p>', trigger: 'hover focus'}">
                                    ？
                                </button>
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="iInsertType" required/> 保存
                                </label>&nbsp;&nbsp;&nbsp;&nbsp;
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="iInsertType" required/> 不保存
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">报警方式
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline" style="padding-left: 0px;">
                                    <input type="checkbox" value="0" name="alarmModes" id="alarmModes0" /> 短信
                                </label>&nbsp;&nbsp;&nbsp;&nbsp;
                                <label class="am-radio-inline">
                                    <input type="checkbox" value="1" name="alarmModes" id="alarmModes1" /> 微信
                                </label>
                                <label class="am-radio-inline">
                                    <input type="checkbox" value="2" name="alarmModes" id="alarmModes2" /> 邮件
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">立即启用
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="iStatus" required/> 不启用
                                </label>&nbsp;&nbsp;&nbsp;&nbsp;
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="iStatus" required/> 启用
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="iContactId" class="am-u-sm-3 am-form-label">报警联系人<span
                                    style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-6 s">
                                <select name="iContactId" id="iContactId" required>
                                    <option value="">请选择...</option>
                                    <c:forEach items="${ContactList}" var="i">
                                        <option value="${i.id}">${i.sName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="sAbnormalContent" class="am-u-sm-3 am-form-label">报警推送内容<span
                                    style="color: red;">*</span></label>
                            <div class="am-u-sm-9">
                                <textarea class="" rows="5" name="sAbnormalContent" id="sAbnormalContent" placeholder="触发警报时推送的消息" required></textarea>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="sNomalContent" class="am-u-sm-3 am-form-label">恢复正常推送内容<span
                                    style="color: red;">*</span></label>
                            <div class="am-u-sm-9">
                                <textarea class="" rows="5" name="sNomalContent" id="sNomalContent" placeholder="警报解除时推送的消息" required></textarea>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-9 am-u-sm-push-3">
                                <input type="submit" onclick="return check();" class="am-btn am-btn-primary" value="保存修改" />
                            </div>
                        </div>
                        <script>
                            function check() {
                                if($("#alarmModes0").is(":checked") || $("#alarmModes1").is(":checked") || $("#alarmModes2").is(":checked")) {
                                    return true;
                                }else{
                                    alert("请选择报警方式,并勾选按钮!");
                                    return false;
                                }
                            }
                        </script>
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