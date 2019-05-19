<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/19
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品添加</title>
    <link type="text/css" rel="stylesheet" href="/css/addProduct.css">
    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="main">
        <div class="header row">商品添加</div>
        <div class="name row">
            <div class="title">商品名称：</div>
            <input type="text" class="right" id="name">
        </div>
        <div class="price row">
            <div class="title">商品价格：</div>
            <input type="text" class="right"  id="price">
        </div>
        <div class="info">
            <div class="info-title">商品信息：</div>
            <textarea id="info"></textarea>
        </div>
        <div class="pic row">
            <div class="title">商品图片：</div>
            <%--<form id="imgForm">--%>
                <input type="file" class="right"  id="pic" accept="image/png, image/jpeg, image/gif, image/jpg">
            <%--</form>--%>
        </div>
        <div class="count row">
            <div class="title">商品数量：</div>
            <input type="text" class="right"  id="count">
        </div>
        <div class="date row">
            <div class="title">商品日期：</div>
            <input type="text" class="right"  id="date">
        </div>
        <div class="btn row">
            <input type="button" id="submit" value="提交">
            <input type="button" id="reset" value="重置">
        </div>
    </div>
</div>
<script>
    $(function () {
        var name,price,info,pic,count,date;
        var imgBase64;//base64数据

        //提交
        $('#submit').on('click',function () {
            name = $('#name').val();
            price = $('#price').val();
            info = $('#info').val();
            pic = $("#pic")[0].files[0];
            count = $('#count').val();
            date = $('#date').val();

            if (name==null||name==""){
                alert("商品名称不能为空！");
                return;
            }
            if (price==null||name==""){
                alert("商品价格不能为空！");
                return;
            }
            if (pic==null||name==""){
                alert("商品图片不能为空！");
                return;
            }
            if (count==null||name==""){
                alert("商品数量不能为空！");
                return;
            }
            if (date==null||name==""){
                alert("商品日期不能为空！");
                return;
            }
            var reader = new FileReader();
            var picUrlBase64 = reader.readAsDataURL(pic);
            var allowImgFileSize = 2100000; //上传图片最大值(单位字节)（ 2 M = 2097152 B ）超过2M上传失败
            reader.onload = function (e) {
                //var ImgFileSize = reader.result.substring(reader.result.indexOf(",") + 1).length;//截取base64码部分（可选可不选，需要与后台沟通）
                if (allowImgFileSize != 0 && allowImgFileSize < reader.result.length) {
                    alert( '上传失败，请上传不大于2M的图片！');
                    return;
                }else {
                    console.log(reader.result);
                    console.log(name);
                    imgBase64 = reader.result;
                    $.ajax({
                        type:"post",
                        url:"/manageProduct/add",
                        dataType:"json",
                        data:{
                            "name":name,
                            "price":price,
                            "info":info,
                            "imgBase64":imgBase64,
                            "count":count,
                            "date":date
                        },
                        success:function (result) {
                            alert(result.msg);
                            window.location.href="/addProduct";
                        },
                        error:function () {
                            alert("ajax错误！");
                        }
                    })
                }
            }
        })

        //重置
        $('#reset').on('click',function () {
            $('#name').val("");
            $('#price').val("");
            $('#info').val("");
            $('#count').val("");
            $('#date').val("");
        })
    })
</script>
</body>
</html>
