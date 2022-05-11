<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="include-head.jsp" %>

<body>
<%@include file="include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="/admin/to/main/page.html">Main</a></li>
                <li><a href="/admin/get/page.html">DataList</a></li>
                <li class="active">Update</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">List<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form action="admin/update.html" method="post" role="form">
                        <input type="hidden" name="id" value="${admin.id }">
                        <input type="hidden" name="pageNum" value="${param.pageNum}">
                        <input type="hidden" name="keyword" value="${param.keyword}">
                        <p>${requestScope.exception.message}</p>
                        <div class="form-group">
                            <label for="InputLogin">Account</label>
                            <input type="text" name="login" value="${requestScope.admin.login}" class="form-control" id="InputLogin" placeholder="Enter Login Account">
                        </div>
                        <div class="form-group">
                            <label for="InputUserName">Username</label>
                            <input type="text" name="userName" value="${requestScope.admin.userName}" class="form-control" id="InputUserName" placeholder="Enter Username">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email</label>
                            <input type="email" name="email" value="${requestScope.admin.email}" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
                            <p class="help-block label label-warning">Please enter legal address：xxx@xxx.xxx</p>
                        </div>
                        <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> Update</button>
                        <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> Reset</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>