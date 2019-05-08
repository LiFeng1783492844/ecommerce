<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/1
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
    <link type="text/css" rel="stylesheet" href="/css/register.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="top">
        <span>用户注册</span>
    </div>
    <div class="content">
        <span>用户名：</span><input type="text" id="account"><br>
        <span>密码：</span><input type="password" id="pwd"><br>
        <span>密码确认：</span><input type="password" id="rePwd"><br>
        <span>E-mail：</span><input type="email" id="mail"><br>
        <span>地址：</span><input type="text" id="adds"><br>
        <span>电话：</span><input type="tel" id="tel"><br>
        <span>邮编：</span><input type="text" id="postcode"><br>
        <span>真实姓名：</span><input type="text" id="name">
    </div>
    <div class="button">
        <input type="button" id="btnConfirm" value="确认">&nbsp;&nbsp;
        <input type="button" id="btnReset" value="清除">
    </div>
</div>
<script>
    $(function () {
        //确认
        $("#btnConfirm").on("click",function () {
            //防止多次点击确认按钮
            if($("#btnConfirm").hasClass("registering")){
                return;
            }

            //判断输入的信息是否合法
            //用户名
            var account = $("#account").val();
            if(account.trim()==""){
                alert("用户名为空！");
                return;
            }
            //密码
            var pwd = $("#pwd").val();
            if(pwd.trim()==""){
                alert("密码为空！");
                return;
            }
            //密码确认
            var rePwd = $("#rePwd").val();
            if(rePwd.trim()!=pwd){
                alert("两次密码不一致！");
                return;
            }
            //邮箱
            var mail = $("#mail").val();
            var isEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            if(mail.trim()==""){
                alert("邮箱为空！");
                return;
            }
            if(isEmail.test(mail)==false){
                alert("邮箱格式不合法！");
                return;
            }
            //地址
            var adds = $("#adds").val();
            if(adds.trim()==""){
                alert("地址不能为空！");
                return;
            }
            //电话
            var tel = $("#tel").val();
            var isTel=/^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
            if(tel.trim()==""){
                alert("电话不能为空！");
                return;
            }
            if(isTel.test(tel)==false){
                alert("电话格式不合法");
                return;
            }
            //邮编
            var postcode = $("#postcode").val();
            var isPostcode = /^[1-9][0-9]{5}$/;
            if(postcode.trim()==""){
                alert("邮编为空！");
                return;
            }
            if(isPostcode.test(postcode)==false){
                alert("邮编不合法！");
                return;
            }
            //真实姓名
            var name = $("#name").val();
            if(name.trim()==""){
                alert("真实姓名不能为空！");
                return;
            }

            //使按钮无法再次触发
            $("#btnConfirm").addClass("registering");
            $("#btnConfirm").val("注册中...");

            //使用ajax与后台传数据
            $.ajax({
                type:"post",
                url:"/doRegister",
                dataType:"json",
                data:{
                    "account":account,
                    "pass":pwd,
                    "mail":mail,
                    "adds":adds,
                    "tel":tel,
                    "postcode":postcode,
                    "name":name
                },
                success:function (result) {
                    $("#btnConfirm").removeClass("registering");
                    $("#btnConfirm").val("确认");
                    if(!result.isExist){
                        alert(result.msg);
                        window.location.href="/index";
                    }else {
                        alert("用户已注册！");
                    }
                },
                error:function () {
                    $("#btnConfirm").removeClass("registering");
                    $("#btnConfirm").val("确认");
                    alert("ajax错误！");
                }
            })

        });

        //清除
        $("#btnReset").on("click",function () {
            $("#account").val("");
            $("#pwd").val("");
            $("#rePwd").val("");
            $("#mail").val("");
            $("#adds").val("");
            $("#tel").val("");
            $("#postcode").val("");
            $("#name").val("");
        })
    })
</script>
</body>
</html>
