<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/1
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息</title>
    <link type="text/css" rel="stylesheet" href="/css/userInfo.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="top">
        <span>用户信息</span>
    </div>
    <div class="content">
        <div class="left">用户名</div><div class="right"><label id="account"></label></div>
        <div class="left">E-mail</div><div class="right"><label id="mail"></label></div>
        <div class="left">地址</div><div class="right"><label id="adds"></label></div>
        <div class="left">电话</div><div class="right"><label id="tel"></label></div>
    </div>
    <div class="button">
        <input type="button" id="btnModify" value="修改信息">
    </div>
</div>
<script>
    $(function () {
        $("#account").text("${member.account}");
        $("#mail").text("${member.mail}");
        $("#adds").text("${member.adds}");
        $("#tel").text("${member.tel}");

        $("#btnModify").on("click",function () {
            parent.location.href="/modifyMemberInfo";
        })

    })
</script>
</body>
</html>
