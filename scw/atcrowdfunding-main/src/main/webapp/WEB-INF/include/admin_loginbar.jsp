<%--
  Created by IntelliJ IDEA.
  User: 策
  Date: 2020/6/17
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul class="nav navbar-nav navbar-right">
    <li style="padding-top:8px;">
        <div class="btn-group">
            <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><sec:authentication property="name"></sec:authentication> <%--${admin.loginacct} --%><span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                <li class="divider"></li>

                <li><a id="logoutA" href="javascript:void(0);"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>

            </ul>
            <form id="loginForm" action="${PATH}/admin/logout" method="post"></form>
        </div>
    </li>
    <li style="margin-left:10px;padding-top:8px;">
        <button type="button" class="btn btn-default btn-danger">
            <span class="glyphicon glyphicon-question-sign"></span> 帮助
        </button>
    </li>
</ul>
