<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/1
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link type="text/css" rel="stylesheet" href="/css/login.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="top">
        <span>用户登录</span>
    </div>
    <div class="content">
        <span>用户名</span><input type="text" id="account"><br>
        <span>密码</span><input type="password" id="pass"><br>
    </div>
    <div class="button">
        <input type="button" id="btnRegister" value="注册">&nbsp;&nbsp;
        <input type="button" id="btnLogin" value="登录">
    </div>
</div>
<script>
    $(function () {
        //注册
        $("#btnRegister").on("click",function () {
            parent.location.href="/register"
        });

        //登录
        $("#btnLogin").on("click",function () {
            //输入验证
            var account = $("#account").val();
            if(account.trim()==""){
                alert("用户名为空！");
                return;
            }
            var pass = $("#pass").val();
            if(pass.trim()==""){
                alert("密码为空！");
                return;
            }

            $.ajax({
                type:"post",
                url:"/doLogin",
                dataType:"json",
                data:{
                    "account":account,
                    "pass":pass
                },
                success:function (result) {
                    if(result.flag){    //登录成功
                        window.location.href="/userInfo";
                    }else { //登录失败
                        alert(result.msg);
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })

        })
    })
</script>

</body>
</html>
