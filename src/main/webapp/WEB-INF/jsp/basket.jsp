<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/2
  Time: 9:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
    <link type="text/css" rel="stylesheet" href="/css/basket.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="top">
        <span>所选购的商品信息</span>
    </div>
    <div class="border">
        <div class="title">
            <div class="name1">商品名称</div>
            <div class="price1">商品单价</div>
            <div class="count1">订购数量</div>
            <div class="confirm1">确认购买</div>
        </div>
        <div class="content-basket" id="content-basket">
            <c:forEach var="basket" items="${basketList}">
                <div class="product">
                    <div class="name">${basket.name}</div>
                    <div class="price">${basket.price}</div>
                    <div class="count-basket">
                        <select name="count">
                            <option value="1" selected="selected">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                    <div class="confirm">
                        <input type="button" class="btnConfirm" id="${basket.id}" value="确认">
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="top">
        <span>收银台</span>
    </div>
    <div class="border">
        <div class="title">
            <div class="name1">商品名称</div>
            <div class="price1">商品单价</div>
            <div class="count1">订购数量</div>
            <div class="date1">订购时间</div>
        </div>
        <div class="content-checkout">
            <c:forEach var="checkout" items="${checkoutList}">
                <div class="product">
                    <div class="name">${checkout.name}</div>
                    <div class="price">${checkout.price}</div>
                    <div class="count-checkout">${checkout.count}</div>
                    <div class="date">
                        <fmt:formatDate value="${checkout.date}" pattern="yy-MM-dd HH:mm:ss"/>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="total">合计：${total} 元</div>
    </div>
    <div class="button">
        <input type="button" id="btnClean" value="清空购物车">
        <input type="button" id="btnCleanCheckout" value="清空收银台">
        <input type="button" id="btnCheckout" value="收银台结账">
    </div>
</div>
<script>
    $(function () {
        //确认购买按钮
        $(".btnConfirm").on("click",function () {
            //获得确认购买的basketId和count
            var basketId = $(this).attr("id");
            var basketCount = $(this).parent().prev().children().val();
//            console.log(basketId+"  "+basketCount);
            $.ajax({
                type:"post",
                url:"/confirm",
                dataType:"json",
                data:{
                    "id":basketId,
                    "count":basketCount
                },
                success:function (result) {
                    if(result.flag){//更新成功
                        window.location.href="/basket";
                    }else {
                        alert("更新失败！");
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //清空购物车按钮
        $("#btnClean").on("click",function () {
            $.ajax({
                type:"post",
                url:"/cleanBasket",
                dataType:"json",
                data:{},
                success:function (result) {
                    if(result.flag){//更新成功
                        window.location.href="/basket";
                    }else {
                        alert("删除失败！");
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //清空收银台按钮
        $("#btnCleanCheckout").on("click",function () {
            $.ajax({
                type:"post",
                url:"/cleanCheckout",
                dataType:"json",
                data:{},
                success:function (result) {
                    if(result.isLogin){ //登录了
                        if(result.flag){//更新成功
                            window.location.href="/basket";
                            console.log("清空收银台成功！")
                        }else {
                            alert("清空收银台失败！");
                        }
                    }else {
                        console.log("没登录！");
                    }

                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });
        
        //收银台结账
        $("#btnCheckout").on("click",function () {
            window.location.href="/checkout";
        })

    })
</script>
</body>
</html>
