<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/3
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商品列表</title>
    <link type="text/css" rel="stylesheet" href="/css/productList.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div id="productArea">
    <c:forEach var="hw" items="${initial}">
        <div class="product" productId="${hw.id}">
            <div class="title">${hw.name}</div>
            <div class="image" style="background-image: url('${hw.pic}')"></div>
            <div class="price">会员价：${hw.price}元</div>
            <div class="button">
                <input type="button" class="btnDetails" value="详情">
                <input type="button" class="btnOrder" value="订购">
            </div>
        </div>
    </c:forEach>
</div>
<div class="fenye">
    <input type="button" value="上一页" id="before">
    <input type="button" value="下一页" id="after">
</div>

<script>
    $(function () {
        var pagenum=1;//页号，第几页
        maxPageNum = ${maxPageNum};//最大分页数
        if(maxPageNum==1){//只有一页
            $("#before").prop('disabled',true);//禁用上一页
            $("#after").prop('disabled',true);  //禁用下一页
        }else{//多于一页
            $("#before").prop('disabled',true);//禁用上一页
            $("#after").removeAttr('disabled'); //启用下一页
        }

        var container;//商品区域容器
        //上一页
        $("#before").on("click",function () {
            pagenum--;
            changeDisabled(pagenum);
            loadProduct(pagenum);
        });
        //下一页
        $("#after").on("click",function () {
            pagenum++;
            changeDisabled(pagenum);
            loadProduct(pagenum);
        });
        //根据pagenum确定翻页键的禁用与启动
        function changeDisabled(pagenum) {
            if(maxPageNum==1){//只有一页
                $("#before").prop('disabled',true);//禁用上一页
                $("#after").prop('disabled',true);  //禁用下一页
            }else{//多于一页
                if(pagenum==1){//首页
                    $("#before").prop('disabled',true);//禁用上一页
                    $("#after").removeAttr('disabled'); //启用下一页
                }else if(pagenum==maxPageNum){//尾页
                    $("#before").removeAttr('disabled');//启用上一页
                    $("#after").prop('disabled',true);  //禁用下一页
                }else {//在中间页
                    $("#before").removeAttr('disabled');//启用上一页
                    $("#after").removeAttr('disabled'); //启用下一页
                }
            }
        }
        //加载商品函数
        function loadProduct(pagenum) {
            if(pagenum==0){
                pagenum=1;
            }
            //移除productArea区域中的商品div
            $("#productArea .product").remove();
            //加载新的商品div
            $.ajax({
                type: "POST",
                url: "/changeProductList",
                data:{
                    "pagenum":pagenum
                },
                success: function(data){
                    for(var i=0;i<data.productList.length;i++ ){
                        //创建div
                        var html='<div class="product" productId="'+data.productList[i].id+'">'
                                    +'<div class="title">'+data.productList[i].name+'</div>'
                                    +"<div class=\"image\" style=\"background-image: url('"+data.productList[i].pic+"')\"></div>"
                                    +'<div class="price">会员价：'+data.productList[i].price+'元</div>'
                                    +'<div class="button">'
                                        +'<input type="button" class="btnDetails" value="详情">'
                                        +'<input type="button" class="btnOrder" value="订购">'
                                    +'</div>'
                                 +'</div>';

                        $("#productArea").append(html);
                    }
                },
                error:function () {
                }
            });
        }

        //详情键
        $(document).on('click','.btnDetails',function () {
            //得到商品的id
            var productId = $(this).parent().parent().attr("productId");
            $.ajax({
                type:"post",
                url:"/details",
                dataType:"json",
                data:{
                    "productId":productId
                },
                success:function (result) {
                    //给父页面的details变量赋值
                    parent.details.name = result.details.name;
                    parent.details.price = result.details.price;
                    parent.details.count = result.details.count;
                    parent.details.date = result.details.date;
                    parent.details.info = result.details.info;
                    //调用父页面的displayDetails()函数，来展示商品详情
                    parent.displayDetails();
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //订购键
        $(document).on('click','.btnOrder',function () {
            //得到商品的id
            var productId = $(this).parent().parent().attr("productId");
            $.ajax({
                type:"post",
                url:"/order",
                dataType:"json",
                data:{
                    "productId":productId
                },
                success:function (result) {
                    if(result.isLogin){//登录了
                        if(result.isOrder){//订购成功
                            console.log("订购成功！");
                            alert("订购成功！")
                        }else {
                            console.log("订购失败！");
                        }
                    }else {
                        alert("您还没有登录！");
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
