<%--
  Created by IntelliJ IDEA.
  User: katefu
  Date: 3/24/22
  Time: 9:38 PM
  To change this template use File | Settings | File Templates.
--%>

<!--
<a href="${pageContext.request.contextPath}/test/ssm.html">test SSM integration environment</a>
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
    <!-- http://localhost:8080/crowdfunding02_admin_webui_war/-->
    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <script type="text/javascript" src="jquery/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script type="text/javascript">
        $(function (){
            $("#btn4").click(function (){
                layer.msg("Layer's Pop-up");
            });


            $("#btn3").click(function (){
                // prepare data \
                var student = {
                    stuId: 5,
                    stuName: "tom",
                    address: {
                        province: "South Australia",
                        city: "Adelaide",
                        street: "Waymouth Street"
                    },
                    subjectList: [
                        {
                            subName: "java",
                            subScore: 100
                        },
                        {
                            subName: "c++",
                            subScore: 98
                        }
                    ],
                    map:{
                        key1: "value1",
                        key2: "value2"
                    }
                };
                // 将JSON对象转换为JSON字符串
                var requestBody = JSON.stringify(student);
                // 发送Ajax请求
                $.ajax({
                    url: "send/compose/object.json",
                    type: "post",
                    data: requestBody,
                    contentType: "application/json;character=UTF-8",
                    dataType: "json",
                    success: function (resp){
                        console.log(resp)
                    },
                    error: function (resp) {
                        console.log(resp)
                    }
                });
            });

            $("#btn2").click(function (){
                //prepare data ready to send
                var array = [5,8,12]; //json array passed as ['5','8','12']
                console.log(array.length);//3
                //convert json array to json string
                var requestBody = JSON.stringify(array);
                console.log(requestBody.length);//8

                $.ajax({
                    "url":"send/array/two.html", //request target resource address
                    "type":"post",  //request type
                    "data":requestBody,
                    "contentType":"application/json;charset=UTF-8", //content type of request body
                    "dataType":"text", //how to treat the data returned by server
                    "success":function (response){ //The callback function called after the server successfully processes the request
                        alert(response);                                //response：response body data
                    },
                    "error":function (response){ //The callback function called after the server side failed process the request
                        alert(response);
                    }
                });
            });


            $("#btn1").click(function (){
                $.ajax({
                    "url":"send/array/one.html", //request target resource address
                    "type":"post",  //request type
                    "data":{
                        "array":[5,8,12] //passed with [0][1][2]
                    }, //request param
                    "dataType":"text", //how to treat the data returned by server
                    "success":function (response){ //The callback function called after the server successfully processes the request
                        alert(response);                                //response：response body data
                    },
                    "error":function (response){ //The callback function called after the server side failed process the request
                        alert(response);
                    }
                });
            });
        });
    </script>
</head>
<body>
    <a href="${pageContext.request.contextPath}/test/ssm.html">test SSM integration environment</a>
    <br/>
    <button id="btn1">Send [5,8,12] One</button>
    <br/>
    <button id="btn2">Send [5,8,12] Two</button>
    <br/>
    <button id="btn3">Send Compose Subject</button>
    <br/>
    <button id="btn4">Click Me for Pop-ups</button>
</body>
</html>
