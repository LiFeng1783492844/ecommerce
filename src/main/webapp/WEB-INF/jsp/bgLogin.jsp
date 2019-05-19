<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/18
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台登录</title>
    <link type="text/css" rel="stylesheet" href="/css/bgLogin.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="content">
    <div class="title">电子商务平台后台登录</div>
    <div class="main">
        <div class="left">用户名：</div><div class="right"><input type="text" id="account"></div>
        <div class="left">密码：</div><div class="right"><input type="password" id="pass"></div>
        <div class="button">
            <input type="button" id="login" value="登录">
            <input type="button" id="reset" value="重置">
        </div>
    </div>
</div>
<script>
    $(function () {
        $('#login').on('click',function () {
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
                url:"/bgLogin",
                dataType:"json",
                data:{
                    "account":account,
                    "pass":pass
                },
                success:function (result) {
                    if(result.flag){    //登录成功
                        window.location.href="/bgIndex";
                    }else { //登录失败
                        alert(result.msg);
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        })

        //重置
        $('#reset').on('click',function () {
            $('#account').val('');
            $('#pass').val('');
        })
    })
</script>
</body>
</html>
