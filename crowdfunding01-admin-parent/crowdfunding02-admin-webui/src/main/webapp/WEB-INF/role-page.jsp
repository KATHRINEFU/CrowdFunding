<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css">
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" src="/crowd/my-role.js"></script>
<script type="text/javascript">
    $(function (){
        // 1.对分页操作初始化数据
        window.pageNum=1;
        window.pageSize=5;
        window.keyword="";

        // 2.调用执行分页的函数，显示分页效果
        generatePage();

        // 3.给查询按钮单机相应函数
        $("#searchBtn").click(function (){
            // 1)获取关键词
            window.keyword = $("#keywordInput").val();
            // 2)调用分页函数刷新页码
            generatePage();
        })

        // 4.点击新增按钮打开模态框
        $("#showAddModalBtn").click(function () {
            $("#addModal").modal("show");
        });

        // 5.给模态框中的保存按钮绑定相应函数
        $("#saveRoleBtn").click(function (){
            // 1)获取用户在文本框中输入的角色名称
            // #addModal表示找到整个模态框，空格表示在后代元素中继续查找 name[modal]表示匹配name属性=roleName的元素
            var roleName =$.trim( $("#addModal [name=roleName]").val());
            console.log("Print：roleName" + roleName);
            // 2)发送ajax请求
            $.ajax({
                "url": "role/save.json",
                "type": "post",
                "data": {
                    "roleName": roleName
                },
                "dataType": "json",
                "success":function (response){
                    var result = response.result;
                    if(result=="SUCCESS"){
                        layer.msg("Action Succeed!");

                        //将页码定位到最后一页
                        //重新加载分页
                        window.pageNum=99999;
                        generatePage();
                    }

                    if(result=="FAILED"){
                        layer.msg("Action Failed!"+response.message);
                    }
                },
                "error": function (response){
                    layer.msg(response.status+" "+response.statusText);
                }
            })

            // 关闭模态框
            $("addModal").modal("hide");

            //清理模态框
            $("#addModal [name=roleName]").val("");

        })
    })
</script>
<body>
<%@include file="include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@include file="include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> DataList</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">Search keyword</div>
                                <input id="keywordInput" class="form-control has-success" type="text" placeholder="Enter keyword">
                            </div>
                        </div>
                        <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> Search</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> Delete</button>
                    <button type="button" id="showAddModalBtn" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> Add</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">Operation</th>
                            </tr>
                            </thead>
                            <tbody id="rolePageBody">
                            <tr>
                                <td>1</td>
                                <td><input type="checkbox"></td>
                                <td>PM - Project Manager</td>
                                <td>
                                    <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                    <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                    <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                </td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"><!--这里显示分页--></div>
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

    <%@include file="/WEB-INF/modal-role-add.jsp"%>
</body>
</html>