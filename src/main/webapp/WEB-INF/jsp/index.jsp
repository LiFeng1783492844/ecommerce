<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/7
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
    <link type="text/css" rel="stylesheet" href="/css/index.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="header">
    <span>电子商务平台</span>
    <div class="right">
        <a href="basket">购物车</a>
    </div>
</div>
<div class="main">
    <div class="left">
            <iframe src="login" width="200px" height="127px" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
        <div class="left-middle">
            <div class="title">公告</div>
            <p>&nbsp;&nbsp;欢迎使用本电子商务网站</p>
        </div>
        <div class="left-bottom">
            <div class="title">友情链接</div><br>
            <a href="http://www.acfun.cn/">A站</a><br><br>
            <a href="https://www.bilibili.com/">B站</a><br><br>
            <a href="http://www.tucao.one/index.php">C站</a><br><br>
            <a href="http://www.dilidili.name/">D站</a><br>
        </div>
    </div>
    <div class="right">
        <iframe src="productList" width="600px" height="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
    </div>
</div>
</body>
</html>
