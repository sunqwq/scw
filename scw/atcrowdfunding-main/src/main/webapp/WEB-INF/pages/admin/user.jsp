<%--
  Created by IntelliJ IDEA.
  User: 策
  Date: 2020/6/17
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="GB18030">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%--登录状态--%>
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
                    <form action="${PATH}/admin/index" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input value="${param.condition}" name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="bathDelAdmins" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">

                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--遍历admins 显示--%>
                            <c:choose>
                                <c:when test="${empty info.list}">
                                    <%--没有管理员数据--%>
                                    <tr>
                                        <td colspan="6" size="35px">没有查询到管理员数据</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <%--有管理员数据--%>
                                    <c:forEach varStatus="vs" items="${info.list}" var="admin">
                                       <tr>
                                        <td>${vs.count}</td>
                                        <td><input id="${admin.id}" type="checkbox"></td>
                                        <td>${admin.loginacct}</td>
                                        <td>${admin.username}</td>
                                        <td>${admin.email}</td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                            <button type="button" class="btn btn-primary btn-xs"><i onclick="window.location='${PATH}/admin/toEditPage?id=${admin.id}'" class=" glyphicon glyphicon-pencil"></i></button>
                                            <button adminid="${admin.id}" type="button" class="btn btn-danger btn-xs deleteBtn"><i class=" glyphicon glyphicon-remove"></i></button>
                                        </td>
                                       </tr>
                                    </c:forEach>

                                </c:otherwise>
                            </c:choose>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                        <%--<li class="disabled"><a href="#">上一页</a></li>
                                        <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
                                        <li><a href="#">2</a></li>
                                        <li><a href="#">3</a></li>
                                        <li><a href="#">4</a></li>
                                        <li><a href="#">5</a></li>
                                        <li><a href="#">下一页</a></li>--%>
                                        <c:choose>
                                            <c:when test="${info.isFirstPage}">
                                                <%--是第一页，上一页不能点击--%>
                                                <li class="disabled"><a href="javascript:void(0);">上一页</a> </li>

                                            </c:when>
                                            <c:otherwise>
                                                <%--不是第一页--%>
                                                <li ><a href="${PATH}/admin/index?pageNum=${info.pageNum-1}&condition=${param.condition}">上一页</a> </li>
                                            </c:otherwise>
                                        </c:choose>
                                            <%--中间页码--%>
                                            <c:forEach items="${info.navigatepageNums}" var="index">
                                                <c:choose>
                                                    <c:when test="${info.pageNum==index}">
                                                        <%--正在显示当前页码 高亮显示--%>
                                                        <li class="active"><a href="javascript:void(0);">${index}<span class="sr-only"(current)></span></a></li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%--不是当前页--%>
                                                        <li><a href="${PATH}/admin/index?pageNum=${index}&condition=${param.condition}">${index}</a></li>
                                                    </c:otherwise>
                                                </c:choose>

                                            </c:forEach>


                                            <%--下一页--%>
                                            <c:choose>
                                                <c:when test="${info.isLastPage}">
                                                    <%--是最后一页，下一页不能点击--%>
                                                    <li class="disabled"><a href="javascript:void(0);">上一页</a> </li>

                                                </c:when>
                                                <c:otherwise>
                                                    <%--不是最后一页--%>
                                                    <li ><a href="${PATH}/admin/index?pageNum=${info.pageNum+1}&condition=${param.condition}">下一页</a> </li>
                                                </c:otherwise>
                                            </c:choose>

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
<script type="text/javascript">

    /*全选全不选效果*/
    $("thead :checkbox").click(function () {
            $("tbody :checkbox").prop("checked",this.checked);
    });

    //给tbody内所有子复选框绑定选中状态
    $("tbody :checkbox").click(function () {
        //子复选框总数量
        var totalCount  = $("tbody :checkbox").length;
        //被选中的子复选框数量
        var checkedCount = $("tbody :checkbox:checked").length;
        $("thead :checkbox").prop("checked",totalCount==checkedCount);
    });

    //批量删除单击事件
    $("#bathDelAdmins").click(function () {
        var idsArr = new Array()//js数组

        if($("tbody :checkbox:checked").length==0){
            layer.msg("请选择需要删除的管理员");
            return;
        }

            //获取tbody中所有子复选框对应的id
        $("tbody :checkbox:checked").each(function () {
            idsArr.push(this.id);
        });
        //批量删除请求
        var idsStr = idsArr.join();
        window.location="${PATH}/admin/bathDelAdmins?ids="+idsStr;
    });

    //当前打开的是用户维护的页面，应该默认设置用户维护父菜单展开并设置用户维护高亮显示
    $("a:contains(' 用户维护')").parents("ul :hidden").show();//设置ul显示
    $(".list-group-item a:contains(' 用户维护')").css("color","red");//高亮显示
    $("a:contains(' 用户维护')").parents(".list-group-item").removeClass("tree-closed");



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
    /*$("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });*/

    $(".deleteBtn").click(function () {
        //this代表调用当前方法的对像，代表被点击的按钮dom对象
     var adminid =  $(this).attr("adminid");
        layer.confirm("你真的要删除该管理员吗？",{title:"删除提示",icon:3},function () {
            window.location.href = "${PATH}/admin/deleteAdmin?id="+adminid;
        });
    });
</script>
</body>
</html>
