<%--
  Created by IntelliJ IDEA.
  User: Mc江南雨
  Date: 2018/10/23
  Time: 19:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>登录注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="static/images/dripicon.png">
    <!-- 引入JQuery -->
    <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
    <!-- 引入amazeui.css -->
    <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css">
    <!-- 引入bootstrap.css和bootstrap.js -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- 引入自定义css和js -->
    <script src="static/js/my.js"></script>
    <script>
        $(function() {
            $("#modal-container").modal({ show: true, keyboard: false, backdrop: false });
        });

    </script>
</head>

<body>
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
                                <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/Login/doLogin" >
                                    <div class="form-group">
                                        <label for="sUserName_login" class="col-sm-2 control-label">用户名：</label>
                                        <div class="col-sm-10">
                                            <input type="text" name="sUserName_login" id="sUserName_login" class="form-control" placeholder="请输入用户名/邮箱/电话"  />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="sPassword_login" class="col-sm-2 control-label">密码：</label>
                                        <div class="col-sm-10">
                                            <input type="password" name="sPassword_login" id="sPassword_login" class="form-control" placeholder="请输入密码" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="checkCode" class="col-sm-2 control-label">验证码：</label>
                                        <div class="col-sm-6">
                                            <input type="text" name="checkCode" id="checkCode" class="form-control" placeholder="请输入验证码" />
                                        </div>
                                        <div class="col-sm-4">
                                            <img id="checkCodeImage" width="150" height="40" src="${pageContext.request.contextPath}/AuthImage" onclick="javascript:changeImg()" />
                                        </div>
                                        <div class="col-sm-offset-2 col-sm-6">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" />记住密码(7天)</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" class="btn btn-lg btn-info btn-block">登录</button>
                                        </div>
                                    </div>
                                </form>
                                <!-- 触发JS刷新-->
                                <script>
                                    function changeImg(){
                                        var checkCodeImage = document.getElementById("checkCodeImage");
                                        checkCodeImage.src = "${pageContext.request.contextPath}/AuthImage?date=" + new Date();;
                                    }
                                </script>
                            </div>
                            <div class="tab-pane fade" id="register">
                                <form role="form" action="${pageContext.request.contextPath}/Login/doRegister">
                                    <div class="form-group">
                                        <label for="sUserName">用户名</label>
                                        <input type="text" name="sUserName" id="sUserName" class="form-control" placeholder="只能为数字、英文字母（不区分大小写）或“_”,其他特殊字符不可以使用" />
                                        <small>用户名不为空！</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="sPassword">密码</label>
                                        <input type="password" name="sPassword" id="sPassword" class="form-control"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="sGOC">政府机构码</label>
                                        <input type="text" name="sGOC" id="sGOC" class="form-control"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="sCompanyName">公司名</label>
                                        <input type="text" name="sCompanyName" id="sCompanyName" class="form-control"  />
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
                                        <input type="text" name="sCompanyAddress" id="sCompanyAddress" class="form-control"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="sCompanyTelephone">公司电话</label>
                                        <input type="text" name="sCompanyTelephone" id="sCompanyTelephone" class="form-control"  />
                                    </div>
                                    <div class="form-group">
                                        <label for="sEmail">公司邮箱</label>
                                        <input type="text" name="sEmail" id="sEmail" class="form-control"  />
                                    </div>
                                    <!-- <div class="form-group">
                                        <label for="exampleInputFile">File input</label>
                                        <input type="file" id="exampleInputFile" />
                                        <p class="help-block">
                                            Example block-level help text here.
                                        </p>
                                    </div> -->
                                    <!-- <div class="checkbox">
                                        <label>
                                            <input type="checkbox" />Check me out</label>
                                    </div> -->
                                    <input type="submit" class="btn btn-lg btn-default btn-block" />
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">保存</button> -->
                </div>
            </div>

        </div>

    </div>
</div>
<!-- 内容结束 -->
</body>

</html>