<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/19
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公告管理</title>
    <link type="text/css" rel="stylesheet" href="/css/manageNotice.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="main">
        <div class="title">公告管理</div>
        <div class="notice">
            <textarea class="content">${content}</textarea>
        </div>
        <div class="btn">
            <input type="button" class="save" value="保存">
            <input type="button" class="reset" value="重置">
        </div>
    </div>
</div>
<script>
    $(function () {
        $('.save').on('click',function () {
            var content = $('.content').val();
            $.ajax({
                type:'post',
                url:'/manageNotic/save',
                dataType:'json',
                data:{
                    'notice':content
                },
                success:function (result) {
                    if(result.flag){
                        alert("保存成功！");
                        window.location.href='/manageNotice';
                    }else {
                        alert(result.msg);
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        })
        //重置
        $('.reset').on('click',function () {
            $('.content').text("");
        })
    })
</script>
</body>
</html>
