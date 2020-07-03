<%--
  Created by IntelliJ IDEA.
  User: 策
  Date: 2020/6/19
  Time: 10:41
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

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="conditionInp" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryRoleBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchDelRoleBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="showAddModalBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/include/base_js.jsp"%>

<%--新增角色的model 模态框：默认不会显示--%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称</label>
                        <input  name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<%--给角色分配权限的model 模态框：默认不会显示--%>
<div class="modal fade" id="assignPermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel2">权限分配</h4>
            </div>
            <div class="modal-body">
        <%--显示权限树的容器--%>
                <ul id="permissionTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="assignPermissionBtn" type="button" class="btn btn-primary">分配</button>
            </div>
        </div>
    </div>
</div>

<%--更新角色的model 模态框：默认不会显示--%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel1">更新角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称</label>
                        <input  name="name" type="text" class="form-control" id="recipient-name1">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var pages;
    var page;
    var rId;
    /*=====================================================================================权限分配的代码*/
        //给重新分配权限的模态框的提交按钮绑定单击事件
        $("#assignPermissionModal #assignPermissionBtn").click(function () {
            //1.获取请求参数
            //角色id
            //选中的要分配的权限id集合
            var $treeObj = $.fn.zTree.getZTreeObj("permissionTree");
            var $checkedNodes = $treeObj.getCheckedNodes(true);
            var idsArr = new Array();
            $.each($checkedNodes,function () {
                idsArr.push(this.id);

            });
            var idsStr = idsArr.join();
            //2,发送异步请求
            $.ajax({
                type:"get",
                data:{"roleId":rId,"permissionIds":idsStr},
                url:"${PATH}/role/reAssginPermissionToRole",
                success:function (data) {
                    if(data=="ok"){
                        layer.msg("更新权限列表成功");
                        $("#assignPermissionModal").modal("hide");
                    }
                }
            });

        });


        function assignPermission(roleId){
            rId = roleId;
            $.ajax({
                type:"get",
                url:"${PATH}/permission/getPermissions",
                success:function (permissions) {
                    var zNodes = permissions;//数据源
                    //在查询权限集合成功的方法中再次异步请求查询该角色已分配权限id集合
                    $.ajax({
                        type:"get",
                        url:"${PATH}/permission/getAssignedPermissionIds",
                        data:{"roleId":roleId},
                        success:function (list) {
                            console.log(list);

                            //console.log(zNodes);
                            $.each(zNodes,function () {
                                // this.checked=true;
                                if(list.indexOf(this.id)>=0){
                                    this.checked=true;
                                }
                            });
                            var setting = {
                                //设置每个节点左侧显示复选框
                                check: {
                                    enable: true
                                },
                                data:{
                                    key:{
                                        name:"title"//指定节点名称
                                    },
                                    simpleData:{
                                        enable:true,
                                        pIdKey: "pid"//指定加载父子关系
                                    }
                                },
                                view:{
                                    addDiyDom:function (treeId,treeNode) {
                                        //移除默认的图标
                                        $("#"+treeNode.tId+"_ico").remove();
                                        //创建自定义图标的标签
                                        $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                                    }
                                }
                            }//配置
                            var $zTreeObj = $.fn.zTree.init($("#permissionTree"),setting,zNodes);
                            //自动展开
                            $zTreeObj.expandAll(true);
                            $("#assignPermissionModal").modal("show");

                        }
                    });


                }
            });
        }


    /*=====================================================================================角色更新的代码*/
        $("tbody").delegate(".showUpdateRoleModalBtn","click",function () {
                //1.获取要更新的角色id
                var roleId =this.id;
                //2.异步请求id对应的角色信息
            $.get("${PATH}/role/getRole",{id:roleId},function (role) {
                //将服务器响应role数据显示到模态框
                $("#updateRoleModal input[name='id']").val(role.id);
                $("#updateRoleModal input[name='name']").val(role.name);
                //显示更新模态框
                $('#updateRoleModal').modal('toggle');

            });
        });
        //给更新模态框的提交按钮设置单击事件
        $("#updateRoleModal #updateRoleBtn").click(function () {
            $.ajax({
                type:"post",
                url:"${PATH}/role/updateRole",
                data:$("#updateRoleModal form").serialize(),
                success:function (data) {
                    if(data=="ok"){
                        //关闭模态框
                        $('#updateRoleModal').modal('hide');
                        //刷新当前页面
                        initRoleTable(page);
                    }
                }
            });
        });


    /*=====================================================================================角色批量删除的代码*/
        //1.给全选框绑定单击事件
        $("thead :checkbox").click(function () {
            //查找子复选框，可以直接查找
            $("tbody :checkbox").prop("checked",this.checked);
        });
        //2.给所有子复选框绑定单击事件
        $("tbody").delegate(":checkbox","click",function () {
                var totalCount = $("tbody :checkbox").length;
                var checkedCount = $("tbody :checkbox:checked").length;
            $("thead :checkbox").prop("checked",totalCount==checkedCount);
        });

        //3.给批量删除绑定单击事件
        $("#batchDelRoleBtn").click(function () {
            var roleIdsArr = new  Array();
            $("tbody :checkbox:checked").each(function () {
                    var roleId = this.id;//要删除的角色id
                    roleIdsArr.push(roleId);
            });
            //提交批量删除请求
               var roleIdsStrs =  roleIdsArr.join();
               $.ajax({
                   type:"get",
                   data:{ids:roleIdsStrs},
                   url:"${PATH}/role/batchDelRole",
                   success:function (data) {
                        if(data=="ok"){
                            layer.msg("批量删除成功");
                            //刷新当前页面
                            initRoleTable(pageNum);
                        }
                   }

               });
        });









    /*=====================================================================================角色新增的代码*/
        //单击新增按钮弹出模态框的单击事件
        $("#showAddModalBtn").click(function () {
            $('#addRoleModal').modal('toggle');
        });

        //给模态框提交按钮绑定单击事件
        $("#addRoleModal #addRoleBtn").click(function () {
                $.ajax({
                    type:"post",
                    data:$("#addRoleModal form").serialize(),
                    url:"${PATH}/role/addRole",
                    success:function (data) {
                        if(data == "ok"){
                            //关闭模态框
                            $('#addRoleModal').modal('toggle');
                            //跳转到最后一页
                            initRoleTable(pages+1);
                        }
                    }
                });
        });



    /*=====================================================================================以下是角色异步查询解析显示*/

    //当前打开的是用户维护的页面，应该默认设置用户维护父菜单展开并设置用户维护高亮显示
    $("a:contains(' 角色维护')").parents("ul :hidden").show();//设置ul显示
    $(".list-group-item a:contains(' 角色维护')").css("color","red");//高亮显示
    $("a:contains(' 角色维护')").parents(".list-group-item").removeClass("tree-closed");


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
    });

    // $("tbody .btn-success").click(function(){
    //     window.location.href = "assignPermission.html";
    // });




    initRoleTable(1)
    //在指定区域监控，当有标签生成时检查是tfoot的a标签就绑定单击事件
    //delegate动态委派方法 ：参数1要动态绑定事件的标签的选择器字符串，参数2：事件类型，参数3事件处理函数
    $("tfoot ul").delegate(".navA","click",function () {
            var pageNum = $(this).attr("pageNum");
            // alert(pageNum);
        var condition = $("#conditionInp").val();
        initRoleTable(pageNum,condition);

    });

    //将异步请求分页角色集合并解析的代码块提取成函数
    function initRoleTable(pageNum,condition) {
        //每次加载分页的角色列表时，需要将之前的分页数据清除
        $("tbody").empty();//掏空
        $("tfoot ul").empty();
        //通过ajax请求第一页数据显示
        $.ajax({
            type:"get",
            url:"${PATH}/role/getRoles",
            data:{"pageNum":pageNum,"condition":condition},
            success:function (pageInfo) {
                page = pageInfo.pageNum
                //pageInfo中的总页码
                pages = pageInfo.pages;
                //服务器响应回调函数
                layer.msg("请求role成功。。。");
                console.log(pageInfo);
                //1.dom解析将pageInfo的数据遍历显示到表格
                initRoleList(pageInfo);

                //2.生成分页导航栏
                initRoleNav(pageInfo);

                //3.给分页导航栏a标签绑定单击事件
                /*$("tfoot ul.navA").click(function () {
                        alert("hehe");
                });*/

            }
        });
    }


    function initRoleList(pageInfo) {
        $.each(pageInfo.list,function (i) {//i代表元素索引
            $('<tr>\n' +
                '<td>'+(++i)+'</td>\n' +
                '<td><input id="'+this.id+'" type="checkbox"></td>\n' +
                '<td>'+this.name+'</td>\n' +
                '<td>\n' +
                '<button onclick="assignPermission('+this.id+')" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\n' +
                '<button type="button" id="'+this.id+'" class="btn btn-primary btn-xs showUpdateRoleModalBtn"><i class=" glyphicon glyphicon-pencil"></i></button>\n' +
                '<button type="button" id="'+this.id+'" class="btn btn-danger btn-xs delRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\n' +
                '</td>\n' +
                '</tr>').appendTo("tbody");
        });
        //在role集合遍历显示完成之后绑定单击事件
        $("tbody .delRoleBtn").click(function () {
            var roleId = this.id;//获取删除按错所在行的id
            $.get("${PATH}/role/delRole",{id:roleId},function (data) {
                if(data=="ok"){
                    //删除成功
                    layer.msg("删除成功");
                    initRoleTable(pageNum);
                }
            });
        });

    }

    function initRoleNav(pageInfo) {
        //上一页
        if(pageInfo.isFirstPage){
            //当前是第一页禁用
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }else {
            //当前不是这一页
            $('<li ><a pageNum="'+(pageInfo.pageNum-1)+'" class="navA" href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }

        //中间页码
        $.each(pageInfo.navigatepageNums,function () {
            //this代表正在遍历的页码
            if(this==pageInfo.pageNum){
                $('<li class="active"><a href="javascript:void(0);">'+this+' <span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul.pagination");
            }else{
                $('<li><a pageNum="'+this+'" href="javascript:void(0);" class="navA">'+this+'</apageNum></li>').appendTo("tfoot ul.pagination");
            }
        });
        //下一页
        if(pageInfo.isLastPage){
            //当前是最好一页禁用
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }else {
            //当前不是最后一页
            $('<li ><a class="navA" pageNum="'+(pageInfo.pageNum+1)+'" href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }
    }

    //给带条件查询绑定单击事件
    $("#queryRoleBtn").click(function () {
        //1.条件
        var condition = $("#conditionInp").val();
        //2.页码
        var pageNum = 1;
        initRoleTable(pageNum,condition);

    });

</script>
</body>
</html>
