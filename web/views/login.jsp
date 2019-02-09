<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="/DripChain/views/static/images/dripicon.png">
    <!-- 引入JQuery -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <!-- 引入amazeui.css -->
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css">
    <!-- 引入bootstrap.css和bootstrap.js -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- 引入自定义css和js -->
    <script src="/DripChain/views/static/js/my.js"></script>
    <script>
        $(function () {
            $("#modal-container").modal({show: true, keyboard: false, backdrop: false});
        });

    </script>
</head>

<body>
<%--测试路径--%>
<%--<img src="/DripChain/views/static/images/drip.png">--%>
<%--<img src="../drip.png">--%>
<!-- 内容开始 -->
<div id="content" class="col-sm-12" style="height: 700px;">

    <!-- <a id="modal-525545" href="#modal-container" role="button" class="btn" data-toggle="modal">触发遮罩窗体</a> -->

    <div class="modal fade" id="modal-container" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                    <div class="tabbable col-sm-12">
                        <ul id="myTab" class="nav nav-pills">
                            <li class="active col-sm-6 text-center " style="padding: 0;margin: 0;">
                                <a href="#login" data-toggle="tab">登录</a>
                            </li>
                            <li class="col-sm-6 text-center " style="padding: 0;margin: 0;">
                                <a href="#register" data-toggle="tab">注册</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- <div class="modal-body">

                </div> -->
                <div class="modal-footer" style="text-align: left;">
                    <div class="container col-sm-12">
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade in active" id="login">
                                <form id="loginForm" class="form-horizontal" role="form"
                                      action="${pageContext.request.contextPath}/Login/doLogin" method="post">
                                    <div class="form-group">
                                        <label for="sUserName_login" class="col-sm-2 control-label">用户名：</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="sUserName_login" id="sUserName_login"
                                                   class="form-control" placeholder="请输入用户名/邮箱/电话" required/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="sPassword_login" class="col-sm-2 control-label">密码：</label>
                                        <div class="col-sm-10">
                                            <input type="password" name="sPassword_login" id="sPassword_login"
                                                   class="form-control" placeholder="请输入密码" required/>
                                            <small>${param.errorMessage}</small>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="checkCode" class="col-sm-2 control-label">验证码：</label>
                                        <div class="col-sm-6">
                                            <input type="text" name="checkCode" id="checkCode" class="form-control"
                                                   placeholder="请输入验证码" required/>
                                            <small>${param.checkCodeError}</small>
                                        </div>
                                        <div class="col-sm-4">
                                            <img id="checkCodeImage" width="150" height="40"
                                                 src="${pageContext.request.contextPath}/AuthImage"
                                                 onclick="javascript:changeImg()"/>
                                        </div>
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" checked="checked"/>记住密码(7天)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" onsubmit="return tijiao();" class="btn btn-lg btn-info btn-block">登录</button>
                                            <script>
                                                $("#loginForm").submit(function () {
                                                    var sPassword_login = $("#sPassword_login").val().MD5(32);
                                                    $("#sPassword_login").val(sPassword_login);
                                                    //alert($("#sPassword_login").val());
                                                });
                                            </script>
                                        </div>
                                    </div>
                                </form>
                                <!-- 触发JS刷新验证码-->
                                <script>
                                    function changeImg() {
                                        var checkCodeImage = document.getElementById("checkCodeImage");
                                        checkCodeImage.src = "${pageContext.request.contextPath}/AuthImage?date=" + new Date();
                                    }
                                </script>
                            </div>
                            <div class="tab-pane fade" id="register">
                                <form id="registerForm" role="form" action="${pageContext.request.contextPath}/Login/doRegister"
                                      method="post">
                                    <div class="form-group">
                                        <label for="sUserName">用户名</label>
                                        <input type="text" name="sUserName" id="sUserName" class="form-control"
                                               placeholder="请输入用户名，只能为数字、英文字母（不区分大小写）或“_”"/>
                                        <small>${param.sUserNameError}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="sPassword">密码</label>
                                        <input type="password" name="sPassword" id="sPassword" class="form-control"
                                               placeholder="请输入密码"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="sPassword">确认密码</label>
                                        <input type="password" id="RePassword" class="form-control"
                                               placeholder="请再次输入密码"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="sGoc">政府机构</label>
                                        <select name="sGoc" id="sGoc" class="form-control">
                                            <option value="">请选择</option>
                                            <option value="532901101000">下关镇政府</option>
                                            <option value="532901106000">挖色镇政府</option>
                                            <option value="532901104000">喜洲镇政府</option>
                                            <option value="532901109000">双廊政府</option>
                                            <option value="532901102000">大理镇</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="sCompanyName">公司名</label>
                                        <input type="text" name="sCompanyName" id="sCompanyName" class="form-control"
                                               placeholder="请输入公司名称"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="sCompanyType">公司类型</label>
                                        <select name="sCompanyType" id="sCompanyType" class="form-control">
                                            <option value="">请选择</option>
                                            <option value="企业">企业</option>
                                            <option value="客栈">客栈</option>
                                            <option value="餐厅">餐厅</option>
                                            <option value="学校">学校</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="sCompanyAddress">公司地址</label>
                                        <input type="text" name="sCompanyAddress" id="sCompanyAddress"
                                               class="form-control" placeholder="请输入公司地址"/>
                                    </div>
                                    <div class="form-group">
                                        <div>
                                            <label for="sCompanyTelephone">公司电话</label>
                                        </div>
                                        <div class="col-sm-8" style="padding-left: 0;">
                                            <input type="text" name="sCompanyTelephone" id="sCompanyTelephone"
                                                   pattern="0?(13|14|15|17|18|19)[0-9]{9}" class="form-control"
                                                   placeholder="请输入公司的联系方式"/>
                                            <small>${pange.sCompanyTelephoneError}</small>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="hidden" id="sessionPhoneCheckCode" value="${sessionScope.phoneCheckCode}">
                                            <button id="getCode" type="button" class="btn btn-default form-control">发送短信验证码</button>
                                        </div>

                                    </div>
                                    <script>
                                        $('#getCode').unbind('click').click(function (event){
                                            var pattern = /0?(13|14|15|17|18|19)[0-9]{9}/;
                                            var phone = $("#sCompanyTelephone").val();
                                            if (pattern.test(phone)) {
                                                $.get("${pageContext.request.contextPath}/PhoneCheckCode?phone="+phone, function (data, status) {
                                                    //alert("Data: " + data + "Status: " + status);
                                                    var arr=new Array();
                                                    arr=data.split(',');
                                                    $("#sessionPhoneCheckCode").val(arr[1]);
                                                    if(arr[0]!=="1"){
                                                        alert("系统错误请稍后尝试！");
                                                    }
                                                });
                                                event.preventDefault();
                                                time(this);
                                            } else {
                                                alert("手机号码格式不正确！");
                                            }
                                        });
                                        var wait=60;
                                        function time(o) {
                                            if (wait == 0) {
                                                o.removeAttribute("disabled");
                                                o.innerHTML="发送短信验证码";
                                                wait = 60;
                                            } else {
                                                o.setAttribute("disabled", true);
                                                o.innerHTML="重新发送(" + wait + ")";
                                                wait--;
                                                setTimeout(function() { time(o) }, 1000)
                                            }
                                        }
                                    </script>
                                    <br><br>
                                    <script>
                                        $(function () {
                                            $("#checkRight").hide();
                                            $("#checkError").hide();
                                            $("#phoneCheckCode").change(function () {
                                                if($("#phoneCheckCode").val()!=""){
                                                    var phoneCheckCode=$("#sessionPhoneCheckCode").val();

                                                    if(phoneCheckCode!="" && $.trim(phoneCheckCode) == $.trim($("#phoneCheckCode").val())){
                                                        $("#checkRight").show();
                                                        $("#checkError").hide();
                                                    }else{
                                                        $("#checkRight").hide();
                                                        $("#checkError").show();
                                                    }
                                                } else{
                                                    $("#checkRight").hide();
                                                    $("#checkError").hide();
                                                }
                                            });
                                        });
                                    </script>
                                    <div class="form-group">
                                        <label for="phoneCheckCode" class="col-sm-6 control-label"
                                               style="padding-left: 0px;line-height: 34px;">请输入短信验证码：
                                            <span id="checkRight" style="color: green;" class="am-success am-icon-check"></span>
                                            <span id="checkError" style="color: red;" class="am-success am-icon-close"></span>
                                        </label>
                                        <div class="col-sm-6">
                                            <input type="text" name="phoneCheckCode" id="phoneCheckCode" pattern="[1-9]\d{3}"
                                                   class="form-control" placeholder="请输入短信验证码"/>
                                        </div>
                                    </div>
                                    <div style="clear: both;width: 100%;"></div>
                                    <div class="form-group">
                                        <label for="sEmail">公司邮箱</label>
                                        <input type="text" name="sEmail" id="sEmail" class="form-control"
                                               placeholder="请输入公司邮箱"/>
                                        <small>${param.sEmailError}</small>
                                    </div>
                                    <input type="submit" class="btn btn-lg btn-default btn-block"/>
                                    <script>
                                        $("#registerForm").submit(function () {
                                            var sPassword = $("#sPassword").val();
                                            var RePassword = $("#RePassword").val();
                                            if (sPassword == RePassword) {
                                                //密码进行MD5加密传输
                                                $("#sPassword").val(sPassword.MD5(32));
                                                $("#RePassword").val(RePassword.MD5(32));
                                                return true;
                                            }else{
                                                alert("密码不一致！");
                                                return false;
                                            }
                                        });
                                    </script>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>
<!-- 内容结束 -->
</body>

</html>