<%--
  Created by IntelliJ IDEA.
  User: 策
  Date: 2020/6/16
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>

<%--<%@include file="/WEB-INF/include/base_css.jsp"%>
    <%@include file="/WEB-INF/include/base_js.jsp"%>
    <%@include file="/WEB-INF/include/admin_loginbar.jsp"%>
    <%@include file="/WEB-INF/include/admin_menubar.jsp"%>
--%>
<script type="text/javascript">
$("#logoutA").click(function () {
//弹出确认框
layer.confirm("您确定注销吗?" , {title:"注销确认:" ,icon:4} ,function (index) {
layer.close(index);
//用户点击确定按钮式的单击事件
<%--window.location.href = "/admin/logout";//修改浏览器地址栏地址--%>
    $("#loginForm").submit();
} );
});
</script>