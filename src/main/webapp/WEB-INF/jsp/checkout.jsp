<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/1
  Time: 20:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户信息</title>
    <link type="text/css" rel="stylesheet" href="/css/modify.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="container">
    <div class="top">
        <span>谢谢您从本站购物！您的订单号为：${subNum}</span>
    </div>
    <div class="content">
        <div class="left">姓名：</div><div class="right"><input type="text" id="name"></div><br>
        <div class="left">地址：</div><div class="right"><input type="text" id="adds"></div><br>
        <div class="left">邮编：</div><div class="right"><input type="text" id="postcode"></div><br>
        <div class="left">电话：</div><div class="right"><input type="text" id="tel"></div><br>
        <div class="left">E-mail：</div><div class="right"><input type="text" id="mail"></div><br>
    </div>
    <div class="button">
        <input type="button" id="btnConfirm" value="确认">
        <input type="button" id="btnReset" value="清除">
    </div>
</div>
<script>
    $(function () {
        $("#mail").val("${member.mail}");
        $("#tel").val("${member.tel}");
        $("#postcode").val("${member.postcode}");
        $("#adds").val("${member.pass}");
        $("#name").val("${member.name}");

        //确认
        $("#btnConfirm").on("click",function () {
            //判断输入的信息是否合法
            //真实姓名
            var name = $("#name").val();
            if(name.trim()==""){
                alert("真实姓名不能为空！");
                return;
            }
            //地址
            var adds = $("#adds").val();
            if(adds.trim()==""){
                alert("地址不能为空！");
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

            $.ajax({
                type:"post",
                url:"/modify",
                dataType:"json",
                data:{
                    "account":${member.account},
                    "pass":${member.pass},
                    "mail":mail,
                    "tel":tel,
                    "postcode":postcode,
                    "adds":adds,
                    "name":name
                },
                success:function (result) {
                    if(result.flag){//更新成功
                        window.location.href="/basket";
                    }else {
                        alert("订购失败！");
                    }
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //清空
        $("#btnReset").on("click",function () {
            $("#mail").val("");
            $("#tel").val("");
            $("#postcode").val("");
            $("#adds").val("");
            $("#name").val("");
        })

    })
</script>
</body>
</html>
