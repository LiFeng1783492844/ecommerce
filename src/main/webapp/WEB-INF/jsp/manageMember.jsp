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
    <title>用户管理</title>
    <link type="text/css" rel="stylesheet" href="/css/manageMember.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="content">
    <div class="header">
        <div class="account">用户账号</div>
        <div class="pass">用户密码</div>
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
            loadMember(pagenum);
        });
        //下一页
        $("#after").on("click",function () {
            pagenum++;
            changeDisabled(pagenum);
            loadMember(pagenum);
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
        //加载用户函数
        function loadMember(pagenum) {
            if(pagenum==0){
                pagenum=1;
            }
            //移除main区域中的用户div
            $(".main .member").remove();
            //加载新的用户div
            $.ajax({
                type: "POST",
                url: "/bgChangeMemberList",
                data:{
                    "pagenum":pagenum
                },
                success: function(data){
                    for(var i=0;i<data.memberList.length;i++ ){
                        //创建div
                        var html='<div class="member" id="'+data.memberList[i].id+'">'
                                    +'<div><input type="text" class="account" value="'+data.memberList[i].account+'" disabled></div>'
                                    +'<div><input type="password" class="pass" value="'+data.memberList[i].pass+'"></div>'
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

        //初始化
        changeDisabled(pagenum);
        loadMember(pagenum);
        //删除键
        $(document).on('click','.delete',function () {
            //得到用户的id
            var memberId = $(this).parent().attr("id");
            $.ajax({
                type:"post",
                url:"/manageMember/delete",
                dataType:"json",
                data:{
                    "memberId":memberId
                },
                success:function (result) {
                    console.log(result.msg);
                    maxPageNum=result.maxPageNum;
                    if(pagenum>result.maxPageNum){
                        pagenum--;
                    }
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadMember(pagenum); //重新加载这一页的用户
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //修改
        $(document).on('click','.modify',function () {
            //得到商品的信息
            var memberId = $(this).parent().attr("id");
            var pass = $(this).parent().find('.pass').val();
            if(pass=="" || pass ==null){
                alert("密码为空！");
                return;
            }
            $.ajax({
                type:"post",
                url:"/manageMember/modify",
                dataType:"json",
                data:{
                    "id":memberId,
                    "pass":pass
                },
                success:function (result) {
                    console.log(result.msg);
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadMember(pagenum); //重新加载这一页的照片
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
