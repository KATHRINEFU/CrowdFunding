<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css">
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript">
    $(function () {
        // 1.对分页操作初始化数据
        window.pageNum = 1;
        window.pageSize = 5;
        window.keyword = "";

        // 2.调用执行分页的函数，显示分页效果
        generatePage();

        // 3.给查询按钮单机相应函数
        $("#searchBtn").click(function () {
            // 1)获取关键词
            window.keyword = $("#keywordInput").val();
            // 2)调用分页函数刷新页码
            generatePage();
        })

        // 4.点击新增按钮打开模态框
        // $(".panel-body").on("click", "#showAddModalBtn",function (){
        //     console.log("show modal clicked");
        //     $("#addModal").modal("show");
        // })

        $("#showAddModalBtn").click(function () {
            console.log("show model clicked");
            $("#addModal").modal("show");
        });

        // 5.给模态框中的保存按钮绑定相应函数
        $("#saveRoleBtn").click(function () {
            // 1)获取用户在文本框中输入的角色名称
            // #addModal表示找到整个模态框，空格表示在后代元素中继续查找 name[modal]表示匹配name属性=roleName的元素
            var roleName = $.trim($("#addModal [name=roleName]").val());
            console.log("Print：roleName" + roleName);
            // 2)发送ajax请求
            $.ajax({
                "url": "role/save.json",
                "type": "post",
                "data": {
                    "roleName": roleName
                },
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("Action Succeed!");

                        //将页码定位到最后一页
                        //重新加载分页
                        window.pageNum = 99999;
                        generatePage();
                    }

                    if (result == "FAILED") {
                        layer.msg("Action Failed!" + response.message);
                    }
                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            })

            // 关闭模态框
            $("addModal").modal("hide");

            //清理模态框
            $("#addModal [name=roleName]").val("");
        });

        //给页面的pencilBtn绑定单击响函数，目的是打开模态框
        //传统的事件绑定方式只能在第一个页面生效，翻页后失效，因为会重新绘制按钮
        // $(".pencilBtn").click(function (){
        //     console.log("clicking pencil Btn");
        // })

        //使用jQuery的on函数可以解决
        //1)首先找到所有动态生成元素所附着的静态元素
        //2) on函数第一个参数是事件类型，第二个是真正要绑定事件的选择器，第三个参数是事件的相应函数
        $("#rolePageBody").on("click", ".pencilBtn", function () {
            console.log("clicking update...");
            $("#editModal").modal("show");
            //获取表格中当前行中的角色名称
            //为了让执行更新的按能够获取到值，放到全局变量中
            window.roleName = $(this).parent().prev().text();
            //获取当前角色的id 依据是这段代码中roleId设置到了id属性中
            window.roleId = this.id;
            //使用rolename的值设置文本框
            $("#editModal [name = roleName]").val(roleName);
        });

        //给更新模态框中的更新按钮绑定单击相应函数

        // 发送更新请求
        $("#updateRoleBtn").click(function () {
            // 这里值获取错了会导致内存泄漏
            var roleName = $("#editModal [name=roleName]").val();
            $.ajax({
                "url": "role/update.json",
                "type": "post",
                "data": {
                    "id": window.roleId,
                    "name": roleName
                },
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg(response.message)
                        // 重新加载分页
                        generatePage();
                    }
                    if (result == "FAILED") {
                        layer.msg("更新失败！")
                    }
                },
                "error": function (response) {
                    layer.msg(response.status + " " + response.statusText)
                }
            });
            // 更新请求发完关闭模态框
            $("#editModal").modal("hide");
        });


        //执行分页，生成页面效果，调用该函数重新加载页面
        function generatePage() {
            console.log("generating role page...")
            // 1。获取分页数据
            var pageInfo = getPageInfoRemote();
            // 2.填充表格
            fillTableBody(pageInfo);
        }

        //远程访问服务器端程序，获取pageInfo数据
        function getPageInfoRemote() {
            console.log("getting info from remote...")

            var ajaxResult = $.ajax({
                "url": "role/get/page/info.json",
                "type": "post",
                "data": {
                    "pageNum": window.pageNum,
                    "pageSize": window.pageSize,
                    "keyword": window.keyword
                },
                "dataType": "json",
                "async": false,
            });

            console.log(ajaxResult)
            var statusCode = ajaxResult.status;

            //如果当前相应失败
            if (statusCode != 200) {
                layer.msg("Server-side program call failed! Response code: " + status)
                return null;
            }
            // 如果响应状态码是 200, 说明请求处理成功 获取pageInfo
            var resultEntity = ajaxResult.responseJSON;
            var result = resultEntity.result;
            if (result == "FAILED") {
                layer.msg(resultEntity.message);
                return null;
            }
            console.log("getting result succeed...")
            var pageInfo = resultEntity.data;
            return pageInfo;
        }

        //填充表格
        function fillTableBody(pageInfo) {
            $("#rolePageBody").empty();
            // 这里清空是为了让没有搜索结果时不显示页面
            $("#Pagination").empty();
            if (pageInfo == null || pageInfo == undefined || pageInfo.list.length == 0) {
                // 向role-page.jsp 中的 rolePageBody ID中追加数据
                $("#rolePageBody").append("<tr><td colspan='4'>Sorry! you do not have permission or the data you are looking for</td></tr>")
                return;
            }
            for (var i = 0; i < pageInfo.list.length; i++) {
                var role = pageInfo.list[i];
                var roleId = role.id;
                var roleName = role.name;
                var numberTd = "<td>" + (i + 1) + "</td>";
                // 这里的id 后面遍历循环删除时用到
                var checkboxTd = "<td><input id='" + roleId + "' class='itemBox' type='checkbox'></td>";
                var roleNameTd = "<td>" + roleName + "</td>";
                // Role页面的第一个按钮 [权限分配]
                var checkBtn = "<button id= '" + roleId + "' type='button' class='btn btn-success btn-xs checkBtn'><i class=' glyphicon glyphicon-check'></i></button>";
                // 把roleId值传递到button按钮的单击响应函数中，在单击响应函数中使用this.id
                var pencilBtn = "<button id='" + roleId + "' type='button' class='btn btn-primary btn-xs pencilBtn'><i class=' glyphicon glyphicon-pencil'></i></button>";
                var removeBtn = "<button id='" + roleId + "' type='button' class='btn btn-danger btn-xs removeBtn'><i class=' glyphicon glyphicon-remove'></i></button>";
                var buttonTd = "<td>" + checkBtn + " " + pencilBtn + " " + removeBtn + "</td>";
                // 组装表格
                var tr = "<tr>" + numberTd + checkboxTd + roleNameTd + buttonTd + "</tr>";
                $("#rolePageBody").append(tr);
            }
            // 生成分页导航条
            generateNavigator(pageInfo);
        }

        //生成分页页码导航条
        function generateNavigator(pageInfo) {
            console.log("generating navigator...")
            // 获取总记录数
            var totalRecord = pageInfo.total;
            // 声明相关属性
            var properties = {
                "num_edge_entries": 3,
                "num_display_entries": 4,
                "callback": paginationCallBack,
                "items_per_page": pageInfo.pageSize,
                "current_page": pageInfo.pageNum - 1,
                "prev_text": "Prev",
                "next_text": "Next"
            }
            // 调用pagination()函数
            $("#Pagination").pagination(totalRecord, properties);
        }

        //翻页时的回调函数
        function paginationCallBack(pageIndex, jQuery) {
            console.log("calling back...")
            //修改全局变量pageNum
            window.pageNum = pageIndex + 1;
            //调用分页函数 不回递归循环，因为不是同步调用的，回调函数在很后面
            generatePage();
            //取消页码超链接的默认行为
            return false;
        }
    });
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
                <div id="panelBody" class="panel-body">
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
                                <th>Role</th>
                                <th width="100">Operation</th>
                            </tr>
                            </thead>
                            <tbody id="rolePageBody">
<%--                            <tr>--%>
<%--                                <td>1</td>--%>
<%--                                <td><input type="checkbox"></td>--%>
<%--                                <td>PM - Project Manager</td>--%>
<%--                                <td>--%>
<%--                                    <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>--%>
<%--                                    <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>--%>
<%--                                    <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>--%>
<%--                                </td>--%>
<%--                            </tr>--%>
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
<%@include file="/WEB-INF/modal-role-edit.jsp"%>
</body>
</html>