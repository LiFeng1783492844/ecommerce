<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/18
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品管理</title>
    <link type="text/css" rel="stylesheet" href="/css/manageProduct.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="content">
    <div class="header">
        <div class="name">商品名称</div>
        <div class="price">价格</div>
        <div class="count">数量</div>
        <div class="date">日期</div>
        <div class="operate">操作</div>
    </div>
    <div class="main">
    </div>
    <div class="fenye">
        <input type="button" value="上一页" id="before">
        <input type="button" value="下一页" id="after">
    </div>
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
            $(".main .product").remove();
            //加载新的商品div
            $.ajax({
                type: "POST",
                url: "/bgChangeProductList",
                data:{
                    "pagenum":pagenum
                },
                success: function(data){
                    for(var i=0;i<data.productList.length;i++ ){
                        //创建div
                        var html='<div class="product" id="'+data.productList[i].id+'">'
                                    +'<div><input type="text" class="name" value="'+data.productList[i].name+'"></div>'
                                    +'<div><input type="text" class="price" value="'+data.productList[i].price+'"></div>'
                                    +'<div><input type="text" class="count" value="'+data.productList[i].count+'"></div>'
                                    +'<div><input type="text" class="date" value="'+data.productList[i].date+'"></div>'
                                    +'<div class="delete">删除</div>'
                                    +'<div class="modify">修改</div>'
                                +'</div>';

                        $(".main").append(html);
                    }
                },
                error:function () {
                }
            });
        }

        changeDisabled(pagenum);//改变翻页键的可用性
        loadProduct(pagenum); //重新加载这一页的照片
        //删除键
        $(document).on('click','.delete',function () {
            //得到商品的id
            var productId = $(this).parent().attr("id");
            $.ajax({
                type:"post",
                url:"/manageProduct/delete",
                dataType:"json",
                data:{
                    "productId":productId
                },
                success:function (result) {
                    console.log(result.msg);
                    maxPageNum=result.maxPageNum;
                    if(pagenum>result.maxPageNum){
                        pagenum--;
                    }
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadProduct(pagenum); //重新加载这一页的照片
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //修改
        $(document).on('click','.modify',function () {
            //得到商品的信息
            var productId = $(this).parent().attr("id");
            var name = $(this).parent().find('.name').val();
            var price = $(this).parent().find('.price').val();
            var count = $(this).parent().find('.count').val();
            var date = $(this).parent().find('.date').val();
            $.ajax({
                type:"post",
                url:"/manageProduct/modify",
                dataType:"json",
                data:{
                    "id":productId,
                    "name":name,
                    "price":price,
                    "count":count,
                    "date":date
                },
                success:function (result) {
                    console.log(result.msg);
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadProduct(pagenum); //重新加载这一页的照片
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });


    })
</script>
</body>
</html>
