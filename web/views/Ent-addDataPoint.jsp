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
                    <strong class="am-text-primary am-text-lg">添加数据点</strong> /
                    <small>Add DataPoint</small>
                </div>
            </div>

            <hr/>

            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;"><strong>寄存器</strong>
                                <hr/>
                            </div>
                            <p>
                                与组态软件的寄存器写法相同，填十进制寄存器地址，寄存器为起始地址+1。<br>
                                如：<br>
                                功能码03H或06H，起始地址0000H，则填：40001；<br>
                                功能码04H，起始地址000AH，则填：30011；<br>
                                功能码01H或05H，起始地址0002H，则填：00003；<br>
                                功能码02H，起始地址0003H，则填：10004。
                            </p>
                            <p> &nbsp;&nbsp;&nbsp;&nbsp;超标预警可以设置不同的设备和数据点绑定不同的报警方式。<br> &nbsp;&nbsp;&nbsp;&nbsp;当设备触发报警条件时会进入报警状态，服务器推送报警消息，后面的报警信息将不再推送，直到恢复正常数据时推送设备恢复消息。<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;触发器仅支持非数据透传的通讯协议设备。</p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>数据类型</strong>
                                <hr/>
                            </div>
                            <p> AB CD：大端在前<br>
                                CD AB：小端在前<br>
                                如：<br>
                                4字节无符号整数(AB CD)：123456 为 0x0001 0xE240<br>
                                4字节无符号整数(CD AB)：123456 为 0xE240 0x0001<br>
                                4字节有符号整数(AB CD)：-123456为 0xFFFE 0x1DC0<br>
                                4字节有符号整数(CD AB)：-123456为 0x1DC0 0xFFFE<br>
                                4字节浮点型(AB CD)：12.3 为 0x3F9D 0x70A4<br>
                                4字节浮点型(CD AB)：12.3 为 0x70A4 0x3F9D
                            </p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>公式</strong>
                                <hr/>
                            </div>
                            <p> 公式中的‘%s’为占位符，是固定字段。<br>
                                如：<br>
                                加：%s+10<br>
                                减：%s-10<br>
                                乘：%s*10<br>
                                除：%s/10<br>
                                余数：%s%10<br>
                                提示：支持输入简单的js函数，如：(%s/1000).toFixed(2)，效果为数据点值除1000后保留两位小数
                            </p>
                        </div>
                    </div>

                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div am-u-md-12 style="text-align: center;">
                                <strong>数据存储</strong>
                                <hr/>
                            </div>
                            <p>
                                数据默认存储35天数据，当不选择数据存储时，数据库只会默认存储最新的一条数据。
                            </p>
                        </div>
                    </div>


                </div>
                <script>
                    function innitForm(value){
                        switch (value) {
                            case 0:
                                $("#iDecimalAccuracyGroup").hide();
                                $("#iDecimalAccuracy").attr("required",false);
                                $("#iValueKindGroup").show();
                                $("#iValueKind").attr("required",true);
                                $("#iLengthGroup").hide();
                                $("#iLength").attr("required",false);
                                $("#sUnitGroup").show();
                                $("#sFormulaGroup").show();
                                $("#sReverseFormulaGroup").show();
                                $("#iValueKind").children().not(".0").hide();
                                $("#iValueKind").children().eq(0).show();
                                $("#iValueKind").children().filter(".0").show();
                                break;
                            case 1:
                                $("#iDecimalAccuracyGroup").hide();
                                $("#iDecimalAccuracy").attr("required",false);
                                $("#iValueKindGroup").hide();
                                $("#iValueKind").attr("required",false);
                                $("#iLengthGroup").hide();
                                $("#iLength").attr("required",false);
                                $("#sUnitGroup").hide();
                                $("#sFormulaGroup").hide();
                                $("#sReverseFormulaGroup").hide();
                                break;
                            case 3:
                                $("#iDecimalAccuracyGroup").hide();
                                $("#iDecimalAccuracy").attr("required",false);
                                $("#iValueKindGroup").show();
                                $("#iValueKind").attr("required",true);
                                $("#iLengthGroup").hide();
                                $("#iLength").attr("required",false);
                                $("#sUnitGroup").show();
                                $("#sFormulaGroup").hide();
                                $("#sReverseFormulaGroup").hide();
                                $("#iValueKind").children().not(".3").hide();
                                $("#iValueKind").children().eq(0).show();
                                $("#iValueKind").children().filter(".3").show();
                                break;
                            case 4:
                                $("#iDecimalAccuracyGroup").hide();
                                $("#iDecimalAccuracy").attr("required",false);
                                $("#iValueKindGroup").show();
                                $("#iValueKind").attr("required",true);
                                $("#iLengthGroup").show();
                                $("#iLength").attr("required",true);
                                $("#sUnitGroup").show();
                                $("#sFormulaGroup").hide();
                                $("#sReverseFormulaGroup").hide();
                                $("#iValueKind").children().not(".4").hide();
                                $("#iValueKind").children().eq(0).show();
                                $("#iValueKind").children().filter(".4").show();
                                break;
                        }
                    }
                    $(function () {
                        //默认选中
                        $("input:radio[name='iType'][value='0']").attr("checked",'checked');
                        $("input:radio[name='iWriteRead'][value='0']").attr("checked",'checked');
                        $("input:radio[name='iStorage'][value='1']").attr("checked",'checked');
                        innitForm(0);

                        $("input:radio[name='iType'][value='0']").change(function () {
                            innitForm(0);
                        });
                        $("input:radio[name='iType'][value='1']").change(function () {
                            innitForm(1);
                        });
                        $("input:radio[name='iType'][value='3']").change(function () {
                            innitForm(3);
                        });
                        $("input:radio[name='iType'][value='4']").change(function () {
                            innitForm(4);
                        });
                        //浮点型时显示保留的小数位数
                        $("#iValueKind").change(function () {
                            var iTypeValue = $("input:radio[name='iType'][value='0']").attr("checked");
                            var value=$("#iValueKind").val();
                            if(value==4 || value==10){
                                $("#iDecimalAccuracyGroup").show();
                                $("#iDecimalAccuracy").attr("required",true);
                            }else{
                                $("#iDecimalAccuracyGroup").hide();
                                $("#iDecimalAccuracy").attr("required",false);
                            }
                        });
                    });
                </script>
                <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                    <form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/DataManage/doAddOrUpdateDataPoint" method="post">
                        <div class="am-form-group">
                            <label for="sName" class="am-u-sm-3 am-form-label">名称<span style="color: red;">*</span></label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sName" id="sName" placeholder="名称" required>
                                <small>输入你的数据点名称。</small>
                            </div>
                        </div>
                        <script>
                            $(function () {
                               //默认选中模板
                                $("select[name='iDataTemplateId']").val(${iDataTemplateId});
                            });
                        </script>

                        <div class="am-form-group">
                            <label for="iDatatemplateId" class="am-u-sm-3 am-form-label">选择数据模板<span
                                    style="color: red;">*</span></label>
                            <div class="am-u-sm-6">
                                <select name="iDataTemplateId" id="iDataTemplateId" required>
                                    <option value="">请选择...</option>
                                    <c:forEach items="${DataTemplateList}" var="i">
                                        <option value="${i.id}">${i.sTemplateName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="am-u-sm-3"></div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">数据类型
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="iType" required/> 数值型
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="iType" required/> 开关型
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="3" name="iType" required/> 定位型
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="4" name="iType" required/> 字符型
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="sRegister" class="am-u-sm-3 am-form-label">寄存器<span style="color: red;">*</span></label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sRegister" id="sRegister" placeholder="功能码03H或06H，起始地址0000H，则填：40001；" required>
                                <small>输入你的寄存器地址。</small>
                            </div>
                        </div>

                        <div class="am-form-group" id="iValueKindGroup">
                            <label for="iValueKind" class="am-u-sm-3 am-form-label">数值类型<span
                                    style="color: red;">*</span>
                            </label>
                            <div  class="am-u-sm-9">
                                <select name="iValueKind" id="iValueKind" style="width: 64.5%;">
                                    <option value="">请选择...</option>
                                    <option class="0" value="0">两字节无符号整数</option>
                                    <option class="0" value="1">两字节有符号等数</option>
                                    <option class="0" value="2">四字节无符号整数（AB CD）</option>
                                    <option class="0" value="6">四字节无符号整数（CD AB）</option>
                                    <option class="0" value="3">四字节有符号整数（AB CD）</option>
                                    <option class="0" value="8">四字节有符号整数（CD AB）</option>
                                    <option class="0" value="4">四字节浮点型（AB CD）</option>
                                    <option class="0" value="10">四字节浮点型（CD AB）</option>
                                    <option class="3" value="11">10字节基站定位</option>
                                    <option class="3" value="12">8字节GPS定位</option>
                                    <option class="3" value="13">16字节GPS定位</option>
                                    <option class="4" value="14">String</option>
                                </select>
                            </div>
                        </div>

                        <div class="am-form-group" id="iDecimalAccuracyGroup">
                            <label for="iDecimalAccuracy" class="am-u-sm-3 am-form-label">小数位数<span
                                    style="color: red;">*</span>
                            </label>
                            <div  class="am-u-sm-9">
                                <select name="iDecimalAccuracy" id="iDecimalAccuracy" style="width: 64.5%;">
                                    <option value="">请选择...</option>
                                    <option value="0">0(小数位数)</option>
                                    <option value="1">1(小数位数)</option>
                                    <option value="2">2(小数位数)</option>
                                    <option value="3">3(小数位数)</option>
                                    <option value="4">4(小数位数)</option>
                                </select>
                            </div>
                        </div>

                        <div class="am-form-group" id="iLengthGroup">
                            <label for="iDecimalAccuracy" class="am-u-sm-3 am-form-label">字节长度<span
                                    style="color: red;">*</span>
                            </label>
                            <div  class="am-u-sm-9">
                                <input type="number" name="iLength" min="0" max="100" value="4">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">读写
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="iWriteRead" required/> 只读
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="iWriteRead" required/> 读写
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="2" name="iWriteRead" required/> 只写
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label class="am-u-sm-3 am-form-label">数据存储
                                <span style="color: red;">*</span>
                            </label>
                            <div class="am-u-sm-9">
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="iStorage" required/> 不存储
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="iStorage" required/> 存储
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="2" name="iStorage" required/> 变化时存储
                                </label>
                            </div>
                        </div>

                        <div class="am-form-group" id="sUnitGroup">
                            <label for="sUnit" class="am-u-sm-3 am-form-label">单位</label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sUnit" id="sUnit" >
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="sDescription" class="am-u-sm-3 am-form-label">变量描述</label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sDescription" id="sDescription">
                            </div>
                        </div>

                        <div class="am-form-group" id="sFormulaGroup">
                            <label class="am-u-sm-3 am-form-label">公式
                                <button style="border: none;" type="button" class="am-btn am-btn-default am-round"
                                        data-am-popover="{theme: 'secondary xs',content: '设备上行数据经公式计算后显示； ', trigger: 'hover focus'}">
                                    ？
                                </button>
                            </label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sFormula" id="sFormula">
                            </div>
                        </div>

                        <div class="am-form-group" id="sReverseFormulaGroup">
                            <label class="am-u-sm-3 am-form-label">反向运算公式
                                <button style="border: none;" type="button" class="am-btn am-btn-default am-round"
                                        data-am-popover="{theme: 'secondary xs',content: '主动向设备写数据经反向运算公式后下发；', trigger: 'hover focus'}">
                                    ？
                                </button>
                            </label>
                            <div class="am-u-sm-9">
                                <input type="text" name="sReverseFormula" id="sReverseFormula">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-9 am-u-sm-push-3">
                                <input type="submit" class="am-btn am-btn-primary" value="保存修改" />
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