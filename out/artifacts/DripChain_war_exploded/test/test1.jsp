<%--
  Created by IntelliJ IDEA.
  User: Mc江南雨
  Date: 2018/10/10
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试页面</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>

    <script>
        $(document).ready(function(){
            // 开始写 jQuery 代码...
            $("button").click(function(){
                /*$.post("https://cloudapi.usr.cn/usrCloud/tbUser/login",{
                    account:"许志鹏",
                    password:"d4cc91f36c5bb6da1c26059a8e47fbc8"
                },
                function(data,status){
                    alert("数据: \n" + data + "\n状态: " + status);
                    document.write(data['status']);
                    document.write("<br>");
                    document.write(data.account);
                });*/
                $.ajax({
                    url:"https://cloudapi.usr.cn/usrCloud/dev/getDevs",
                    type:'POST',
                    async:true,
                    data:{
                        token:"eyJhIUzI1NiJ9.eyJzdWOTc4MDI2fQ.6NmtfC5hEPdRhXcxc..."
                    },
                    success:function(result){
                        alert("数据: \n" + result);
                        for (var i in result) {
                            var item=result[i];
                            document.write(i+":"+item);
                        }
                    }
                });
            });
        });

    </script>
</head>
<body>
这是一个测试页面
<button>取数据</button>
</body>
</html>
