<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="details">
    <div class="details-panel">
        <div class="title">商品详情<input type="button" id="btnBack" value="返回"></div>
        <div class="left">商品名称：</div><div class="right" id="name"></div>
        <div class="left">商品价格：</div><div class="right" id="price"></div>
        <div class="left">商品数量：</div><div class="right" id="count"></div>
        <div class="left">商品日期：</div><div class="right" id="date"></div>
        <div class="info-title">商品信息：</div>
        <div class="info" id="info"></div>
    </div>
</div>
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
            <div class="notice">${notice}</div>
        </div>
        <div class="left-bottom">
            <div class="title">友情链接</div>
            <div class="link">
                <c:forEach var="link" items="${linkList}">
                    <a href="${link.url}">${link.name}</a><br>
                </c:forEach>
            </div>
        </div>
        <div class="background-area">
            <span id="background">后台管理</span>
        </div>
    </div>
    <div class="right">
        <iframe src="productList" width="600px" height="100%" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
    </div>
</div>
<script>
    //定义一个商品详情变量
    var details = {
        name:null,
        price:null,
        count:0,
        date:null,
        info:null
    }
    //定义一个展示商品详情的函数
    function displayDetails() {
        $('#name').text(details.name);
        $('#price').text(details.price);
        $('#count').text(details.count);
        $('#date').text(details.date);
        $('#info').text(details.info);
        //显示详情，并置于顶层
        $('.details').css('display','block');
        $('.details').css('z-index','999');
    }
    $(function () {

        //返回按钮点击事件
        $('#btnBack').on('click',function () {
            $('.details').css('display','none');
            $('.details').css('z-index','-999');
        })

        //后台管理
        $('#background').on('click',function () {
            window.location.href='/background';
        })
    })
</script>`
</body>
</html>
