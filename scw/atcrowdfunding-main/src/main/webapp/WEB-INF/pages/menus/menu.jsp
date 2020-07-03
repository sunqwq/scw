<%--
  Created by IntelliJ IDEA.
  User: 策
  Date: 2020/6/21
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/include/base_css.jsp"%>
    <%--&lt;%&ndash;引入zTree的样式文件&ndash;%&gt;
    <link rel="stylesheet" href="ztree/zTree/zTreeStyle.css">--%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%@include file="/WEB-INF/include/admin_loginbar.jsp"%>

            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/include/admin_menubar.jsp"%>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%--新增菜单的model 模态框：默认不会显示--%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel1">新增菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="pid"/>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input  name="name" type="text" class="form-control" id="recipient-name1">
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input  name="icon" type="text" class="form-control" id="recipient-name2">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<%--更改菜单的model 模态框：默认不会显示--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel2">更新菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input  name="name" type="text" class="form-control" id="recipient-name3">
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input  name="icon" type="text" class="form-control" id="recipient-name4">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/include/base_js.jsp"%>

<script type="text/javascript">
    //ztree树按钮的单击事件
    //1.添加菜单
    function addMenu(pid) {
        //显示模态框
        $("#addMenuModal form [name='pid']").val(pid);
        $("#addMenuModal").modal("toggle");

        //给模态框里的提交按钮绑定单击事件
        $("#addMenuModal #addMenuBtn").click(function () {
            $.ajax({
                type:"post",
                url:"${PATH}/menu/addMenu",
                data: $("#addMenuModal form").serialize(),
                success:function (data) {
                    if(data=="ok"){
                        layer.msg("新增成功");
                        //关闭模态框
                        $("#addMenuModal").modal("toggle");
                        //刷新菜单数
                        initMenuTree();
                    }
                }
            });
        });
    }
    //2.删除菜单
    function deleteMenu(id) {
        layer.confirm("你真的要删除吗",{icon: 3,title:"删除标签"},function () {
            $.ajax({
                type:"get",
                url:"${PATH}/menu/deleteMenu",
                data:{"id":id},
                success:function (data) {
                    if(data=="ok"){
                        layer.closeAll();
                        layer.msg("删除成功");
                    initMenuTree();
                    }
                }
            });
        })

    }
    //3.更新菜单
    function updateMenu(id) {
        //查询要更新的菜单的数据
        $.getJSON("${PATH}/menu/getMenu",{"id":id},function (menu) {
            //回显到模态框中
            $("#updateMenuModal form [name='id']").val(menu.id);
            $("#updateMenuModal form [name='name']").val(menu.name);
            $("#updateMenuModal form [name='icon']").val(menu.icon);
            //显示模态框
            $("#updateMenuModal").modal("toggle");

        });
    }
    //给更新按钮绑定单击事件
    $("#updateMenuModal #updateMenuBtn").click(function () {
        $.ajax({
            type:"post",
            url:"${PATH}/menu/updateMenu",
            data:$("#updateMenuModal form").serialize(),
            success:function (data) {
                if(data=="ok"){
                    layer.msg("更新成功");
                    //关闭模态框
                    $("#updateMenuModal").modal("toggle");
                    //刷新菜单
                    initMenuTree();
                }
            }
        });
    });
    //创建ztree的配置
    var settings={
        view:{
            /*//自定义鼠标离开节点时需要的操作
            removeHoverDom:function (treeId,treeNode) {
                $("#"+treeNode.tId+"_btnGroup").remove();
            },
            //自定义鼠标悬停时显示的标签
            addHoverDom:function(treeId,treeNode){//参数2鼠标悬停的节点对象
                if($("#"+treeNode.tId+"_btnGroup").length>0)return;
                //获取触发事件的节点的a标签，给他右侧添加一组按钮
                $("#"+treeNode.tId+"_a").after("<span id='"+treeNode.tId+"_btnGroup'>" +
                    "<span class='button'>添加</span>" +
                    "<span class='button'>删除</span>" +
                    "<span class='button'>修改</span>" +
                    "</span>");
            },*/
            addHoverDom: function(treeId, treeNode){
                var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                aObj.attr("href", "javascript:void(0);");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {//根节点
                    //只能拼接添加按钮
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {//枝节点
                    //修改按钮
                    s += '<a onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children == null || treeNode.children.length == 0  ) {
                        //删除按钮
                        s += '<a onclick="deleteMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    //添加按钮
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {//叶子节点
                    //修改按钮
                    s += '<a onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    //删除按钮
                    s += '<a onclick="deleteMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },

            removeHoverDom: function(treeId, treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            },

            //自定义ztree书每一个标签创建的函数
            addDiyDom: function (treeId,treeNode) {
                //修改所有节点的标签名称
                $("#"+treeNode.tId+"_span").text(treeNode.name);
                //移除正在使用的标签
                $("#"+treeNode.tId+"_ico").remove();
                //设置class属性值为当前节点的字体图标值
                $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")

                //获取当前节点的a标签
                $("#"+treeNode.tId+"_a").prop("target","");
            }
        },
        data: {
            key:{
                url:"uihegriiuerigkjk"//填写不存在的属性名
            },
            simpleData: {
                enable: true,
                pIdKey: "pid"
            }
        }};
    //数据源
    var zNodes;

    initMenuTree();
    function initMenuTree(){
        //异步请求获取菜单列表的json数据
        $.ajax({
            type:"get",
            url:"${PATH}/menu/getMenus",
            success:function (menus) {
                console.log(menus);
                zNodes=menus;
                menus.push({id:0,name:"系统权限菜单",icon:"glyphicon glyphicon-random"});
                //初始化解析ztree树
                //参数1：ztree容器，参数2：ztree解析的配置，参数3：数据源
                var $zTreeObj = $.fn.zTree.init($("#treeDemo"), settings, zNodes);
                //自动展开
                $zTreeObj.expandAll(true);
            }
        });
    }





    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });

        /*var setting = {
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + treeNode.icon).css("background","");
                    }
                },
                addHoverDom: function(treeId, treeNode){
                    var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                    aObj.attr("href", "javascript:;");
                    if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                    var s = '<span id="btnGroup'+treeNode.tId+'">';
                    if ( treeNode.level == 0 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 1 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        if (treeNode.children.length == 0) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                        }
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                    } else if ( treeNode.level == 2 ) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }

                    s += '</span>';
                    aObj.after(s);
                },
                removeHoverDom: function(treeId, treeNode){
                    $("#btnGroup"+treeNode.tId).remove();
                }
            },
            async: {
                enable: true,
                url:"tree.txt",
                autoParam:["id", "name=n", "level=lv"]
            },
            callback: {
                onClick : function(event, treeId, json) {

                }
            }
        };
        //$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据

        var d = [{"id":1,"pid":0,"seqno":0,"name":"系统权限菜单","url":null,"icon":"fa fa-sitemap","open":true,"checked":false,"children":[{"id":2,"pid":1,"seqno":0,"name":"控制面板","url":"dashboard.htm","icon":"fa fa-desktop","open":true,"checked":false,"children":[]},{"id":6,"pid":1,"seqno":1,"name":"消息管理","url":"message/index.htm","icon":"fa fa-weixin","open":true,"checked":false,"children":[]},{"id":7,"pid":1,"seqno":1,"name":"权限管理","url":"","icon":"fa fa-cogs","open":true,"checked":false,"children":[{"id":8,"pid":7,"seqno":1,"name":"用户管理","url":"user/index.htm","icon":"fa fa-user","open":true,"checked":false,"children":[]},{"id":9,"pid":7,"seqno":1,"name":"角色管理","url":"role/index.htm","icon":"fa fa-graduation-cap","open":true,"checked":false,"children":[]},{"id":10,"pid":7,"seqno":1,"name":"许可管理","url":"permission/index.htm","icon":"fa fa-check-square-o","open":true,"checked":false,"children":[]}]},{"id":11,"pid":1,"seqno":1,"name":"资质管理","url":"","icon":"fa fa-certificate","open":true,"checked":false,"children":[{"id":12,"pid":11,"seqno":1,"name":"分类管理","url":"cert/type.htm","icon":"fa fa-th-list","open":true,"checked":false,"children":[]},{"id":13,"pid":11,"seqno":1,"name":"资质管理","url":"cert/index.htm","icon":"fa fa-certificate","open":true,"checked":false,"children":[]}]},{"id":15,"pid":1,"seqno":1,"name":"流程管理","url":"process/index.htm","icon":"fa fa-random","open":true,"checked":false,"children":[]},{"id":16,"pid":1,"seqno":1,"name":"审核管理","url":"","icon":"fa fa-check-square","open":true,"checked":false,"children":[{"id":17,"pid":16,"seqno":1,"name":"实名认证人工审核","url":"process/cert.htm","icon":"fa fa-check-circle-o","open":true,"checked":false,"children":[]}]}]}];
        $.fn.zTree.init($("#treeDemo"), setting, d);*/
    });

    //当前打开的是用户维护的页面，应该默认设置用户维护父菜单展开并设置用户维护高亮显示
    $("a:contains(' 菜单维护')").parents("ul :hidden").show();//设置ul显示
    $(".list-group-item a:contains(' 菜单维护')").css("color","red");//高亮显示
    $("a:contains(' 菜单维护')").parents(".list-group-item").removeClass("tree-closed");
</script>
</body>
</html>
