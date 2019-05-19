<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/18
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <link type="text/css" rel="stylesheet" href="/css/bgIndex.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="main">
    <div class="content">
        <div class="title">使用帮助</div>
        <div class="option" id="back">返回首页</div>
        <div class="option" id="logout">注销登录</div>
        <div class="title">商品管理</div>
        <div class="option" id="add">添加新商品</div>
        <div class="option" id="manageProduct">查看与修改</div>
        <div class="title">用户管理</div>
        <div class="option" id="manageMember">管理网站用户</div>
        <div class="title">网站信息管理</div>
        <div class="option" id="manageNotice">首页公告设置</div>
        <div class="title">网站常规管理</div>
        <div class="option" id="manageLink">友情链接管理</div>
    </div>
    <iframe id="content" src="manageProduct" width="600px" height="602px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
</div>
<script>
    $(function () {
        //回到前台
        $('#back').on('click',function () {
            window.location.href="/backIndex";
        })
        //注销登录
        $('#logout').on('click',function () {
            window.location.href="/background/login";
        })
        //添加新商品
        $('#add').on('click',function () {
            $('#content').attr('src','addProduct');
        })
        //商品管理
        $('#manageProduct').on('click',function () {
            $('#content').attr('src','manageProduct')
        })
        //用户管理
        $('#manageMember').on('click',function () {
            $('#content').attr('src','manageMember')
        })
        //商品管理
        $('#manageNotice').on('click',function () {
            $('#content').attr('src','manageNotice')
        })//商品管理
        $('#manageLink').on('click',function () {
            $('#content').attr('src','manageLink')
        })
    })
</script>
</body>
</html>
