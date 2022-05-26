<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<%@include file="include-head.jsp" %>
<script type="text/javascript">
     $(function (){
         $("#toRightBtn").click(function (){
             //select是标签选择器
             //select:eq(0)表示选择页面上的第一个
             //>表示选择子元素
             //：selected表示被选中的option
             // appendTo表示将jQuery对象添加到指定位置
             $("select:eq(0)>option:selected").appendTo("select:eq(1)");
         });

         $("#toLeftBtn").click(function (){
             //select是标签选择器
             //select:eq(0)表示选择页面上的第一个
             //>表示选择子元素
             //：selected表示被选中的option
             // appendTo表示将jQuery对象添加到指定位置
             $("select:eq(1)>option:selected").appendTo("select:eq(0)");
         });

         $("#submitBtn").click(function (){
             $("select:eq(1)>option").prop("selected", "selected");
         })
     });
</script>
<body>
<%@include file="include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">Main</a></li>
                <li><a href="#">Data List</a></li>
                <li class="active">Assign Roles</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form action="assign/do/role/assign.html" method="post" role="form" class="form-inline">
                        <input type="hidden" name="adminId" value="${param.adminId}">
                        <input type="hidden" name="pageNum" value="${param.pageNum}">
                        <input type="hidden" name="keyword" value="${param.keyword}">
                        <div class="form-group">
                            <label>Unassigned Role List</label><br>
                            <select class="form-control" multiple="" size="10" style="width:100px;overflow-y:auto;">
                                <c:forEach items="${requestScope.unAssignedRoleList}" var="role">
                                    <option value="${role.id}">${role.name }</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="toRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="toLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label>Assigned Role List</label><br>
                            <select name="roleIdList" class="form-control" multiple="multiple" size="10" style="width:100px;overflow-y:auto;">
                                <c:forEach items="${requestScope.assignedRoleList}" var="role">
                                    <option value="${role.id}">${role.name }</option>
                                </c:forEach>
                            </select>
                        </div>
                        <br/><br><br>
                        <button id="submitBtn" type="submit" style="width: 150px; margin: 20px 100px;" class="btn btn-lg btn-success btn-block">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>