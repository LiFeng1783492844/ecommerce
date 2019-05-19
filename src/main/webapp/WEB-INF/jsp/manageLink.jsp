<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/5/19
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>链接管理</title>
    <link type="text/css" rel="stylesheet" href="/css/manageLink.css">

    <script src="/js/jquery-3.3.1.js"></script>
</head>
<body>
<div class="content">
    <div class="header">
        <div class="name">链接名称</div>
        <div class="url">链接地址</div>
        <div class="operate">操作</div>
    </div>
    <div class="main">
    </div>
    <div class="fenye">
        <input type="button" value="上一页" id="before">
        <input type="button" value="下一页" id="after">
    </div>
    <div class="addArea">
        <div><input type="text" class="name" value=""></div>
        <div><input type="text" class="url" value=""></div>
        <div class="add">添加链接</div>
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
            loadLink(pagenum);
        });
        //下一页
        $("#after").on("click",function () {
            pagenum++;
            changeDisabled(pagenum);
            loadLink(pagenum);
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
        function loadLink(pagenum) {
            if(pagenum==0){
                pagenum=1;
            }
            //移除main区域中的用户div
            $(".main .link").remove();
            //加载新的用户div
            $.ajax({
                type: "POST",
                url: "/bgChangeAdList",
                data:{
                    "pagenum":pagenum
                },
                success: function(data){
                    for(var i=0;i<data.adList.length;i++ ){
                        //创建div
                        var html='<div class="link" id="'+data.adList[i].id+'">'
                            +'<div><input type="text" class="name" value="'+data.adList[i].name+'"></div>'
                            +'<div><input type="text" class="url" value="'+data.adList[i].url+'"></div>'
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
        loadLink(pagenum);
        //删除键
        $(document).on('click','.delete',function () {
            //得到用户的id
            var adId = $(this).parent().attr("id");
            $.ajax({
                type:"post",
                url:"/manageAd/delete",
                dataType:"json",
                data:{
                    "adId":adId
                },
                success:function (result) {
                    console.log(result.msg);
                    maxPageNum=result.maxPageNum;
                    if(pagenum>result.maxPageNum){
                        pagenum--;
                    }
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadLink(pagenum); //重新加载这一页的用户
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //修改
        $(document).on('click','.modify',function () {
            //得到商品的信息
            var adId = $(this).parent().attr("id");
            var name = $(this).parent().find('.name').val();
            var url = $(this).parent().find('.url').val();
            if(name=="" || name ==null){
                alert("名称为空！");
                return;
            }
            if(url=="" || url ==null){
                alert("url为空！");
                return;
            }
            $.ajax({
                type:"post",
                url:"/manageAd/modify",
                dataType:"json",
                data:{
                    "id":adId,
                    "name":name,
                    "url":url
                },
                success:function (result) {
                    console.log(result.msg);
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadLink(pagenum); //重新加载这一页的照片
                },
                error:function () {
                    alert("ajax错误！");
                }
            })
        });

        //添加链接
        $(document).on('click','.add',function () {
            var name = $(this).parent().find('.name').val();
            var url = $(this).parent().find('.url').val();
            if(name=="" || name ==null){
                alert("名称为空！");
                return;
            }
            if(url=="" || url ==null){
                alert("url为空！");
                return;
            }
            $.ajax({
                type:"post",
                url:"/manageAd/add",
                dataType:"json",
                data:{
                    "name":name,
                    "url":url
                },
                success:function (result) {
                    console.log(result.msg);
                    alert("添加成功！")
                    $('.addArea .name').val("");
                    $('.addArea .url').val("");
                    changeDisabled(pagenum);//改变翻页键的可用性
                    loadLink(pagenum); //重新加载这一页的照片
                },
                error:function () {
                    alert("ajax错误！");
                    $('.addArea .name').val("");
                    $('.addArea .url').val("");
                }
            })
        })
    })
</script>
</body>
</html>
