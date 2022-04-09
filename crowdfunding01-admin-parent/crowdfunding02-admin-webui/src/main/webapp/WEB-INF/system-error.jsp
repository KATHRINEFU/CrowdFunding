<%--
  Created by IntelliJ IDEA.
  User: katefu
  Date: 4/9/22
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> </title>
</head>
<body>
  <h1>Ah, Error!</h1>
    <!-- 从请求域取出Exception对象，再进一步打印Message属性-->
    ${requestScope.exception.message}

</body>
</html>
