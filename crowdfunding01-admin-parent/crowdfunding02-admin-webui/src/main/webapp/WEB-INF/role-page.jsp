<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/zTreeStyle.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/jquery.ztree.all-3.5.min.js"></script>
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

        //6. 给页面的pencilBtn绑定单击响函数，目的是打开模态框
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

        //7. 给更新模态框中的更新按钮绑定单击相应函数

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

        //8.点击确认模态框的确认删除按钮执行删除
        $("#removeRoleBtn").click(function () {
            //从全局变量获取roleId数组转化为json
            var requestBody = JSON.stringify(window.roleIdArray);
            $.ajax({
                "url": "role/remove/by/role/id/array.json",
                "type": "post",
                "data": requestBody,
                "contentType": "application/json;charset=UTF-8",
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

            $("#confirmModal").modal("hide");
        });

        //9.给单条删除按钮绑定单击相应函数
        $("#rolePageBody").on("click",".removeBtn", function (){
            //从当前按钮出发获取roleName
            var roleName = $(this).parent().prev().text();
            //创建role对象
            var roleArray = [{
                roleId:this.id,
                roleName:roleName
            }]
            //打开模态框
             showConfirmModal(roleArray);
        });

        //10.给总的checkbox绑定单击相应函数
        $("#summaryBox").click(function (){
            console.log("clicking summary box...")
            //1)获取当前多选框自身的状态
            var currentStatus = this.checked;
            //2)用当前多选框状态设置其他多选框
            $(".itemBox").prop("checked", currentStatus);
        });

        //11.全选的反向操作
        $("#rolePageBody").on("click", ".itemBox", function (){
            //获取当前已经选中的.itemBox的数量
            var checkedBoxCount = $(".itemBox:checked").length;
            //获取全部.itemBox的数量
            var totalBoxCount = $(".itemBox").length;
            //使用二者的比较结果设置summaryBox
            $("#summaryBox").prop("checked", checkedBoxCount==totalBoxCount);
        })

        //12.给批量删除的按钮绑定单击函数
        $("#batchRemoveBtn").click(function (){
            //创建数组对象，用来存放后面获取到的角色对象
            var roleArray = [];
            //遍历当前选中的checkbox
            $(".itemBox:checked").each(function (){
                //使用this引用当前遍历得到的checkbox
                var roleId = this.id;
                //通过DOM操作获取角色名称
                var roleName = $(this).parent().next().text();
                roleArray.push({
                    "roleId":roleId,
                    "roleName":roleName
                });
            });
            //检查roleArray长度是否为0
            if(roleArray.length==0){
                layer.msg("Please at least select one to delete");
                return;
            }

            //打开模态框
            showConfirmModal(roleArray);
        });

        // 13.给分配权限按钮绑定单击响函数
        $("#rolePageBody").on("click", ".checkBtn", function (){
            console.log("clicking assign auth...")
            //把当前角色id存入全局
            window.roleId = this.id;
            $("#assignModal").modal("show");
            //装载Auth树形结构数据
            fillAuthTree();
        });

        // 14.给分配权限模态框中的"分配"按钮绑定单击响函数
        $("#assignBtn").click(function (){
            // 1)收集树形结构的各个节点中被勾选的节点
            // 声明一个数组存放id
            var authIdArray = [];
            // 获取ztreeobj
            let zTreeObj = $.fn.zTree.getZTreeObj("authTreeDemo");
            // 获取全部被勾选的节点
            var checkedNodes = zTreeObj.getCheckedNodes();
            // 遍历
            for(var i=0; i<checkedNodes.length; i++){
                var checkedNode = checkedNodes[i];
                var authId = checkedNode.id;
                authIdArray.push(authId);
            }

            alert(authIdArray);
            // 2）发送请求执行分配
            var requestBody = {
                "authIdArray": authIdArray,
                //为了服务器端handler方法统一使用List<Integer>方法接受数据，统一使用数组输入
                "roleId": [window.roleId]
            };
            requestBody = JSON.stringify(requestBody);
            $.ajax({
                "url":"assign/do/role/assign/auth.json",
                "type": "post",
                "data": requestBody,
                "contentType": "application/json;charset=UTF-8",
                "dataType": "json",
                "success": function (response){
                    var result = response.result;
                    if(result=="SUCCESS"){
                        layer.msg("Action Success")
                    }
                    if(result=="Failed"){
                        layer.msg("Action Failed"+response.message);
                    }
                },
                "error": function (response){
                    layer.msg(response.status+" "+response.statusText);
                }
            });
            $("#assignModal").modal("hide");
        })
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

        //声明专门的函数显示确认模态框
        function showConfirmModal(roleArray){
            $("#confirmModal").modal("show");
            //清除旧数据
            $("#roleNameDiv").empty();
            //在全局变量范围，创建数组存放角色id
            window.roleIdArray = [];
            //遍历roleArray数组
            for(var i=0; i<roleArray.length; i++){
                var role = roleArray[i];
                var roleName = role.roleName;
                $("#roleNameDiv ").append(roleName+"<br/>");
                var roleId = role.roleId;
                //调用数组对象的push方法
                window.roleIdArray.push(roleId);
            }
        }

    // 声明专门的函数用来在分配Auth的模态框中显示Auth的树形结构数据
    function fillAuthTree(){

        // a.发送ajax请求查询Auth数据
        var ajaxReturn = $.ajax({
            url: "assign/get/all/auth.json",
            type: "post",
            dataType: "json",
            async: false
        });

        if (ajaxReturn.status !== 200) {
            layer.msg("Request Failed："+ajaxReturn.status+" Detail："+ajaxReturn.statusText);
            return ;
        }

        console.log("getting auth json...")
        // b.从响应结果中获取Auth的JSON数据
        // 从服务器端查询到的 list 不需要组装成树形结构， 这里我们交给 zTree 去组装
        var authList = ajaxReturn.responseJSON.data;

        // c.准备对 zTree 进行设置的 JSON 对象
        var setting = {
            data: {
                simpleData: {
                    // 开启简单JSON功能
                    enable: true,

                    // 使用 categoryId属性关联父节点，不用pid
                    pIdKey: "categoryId"
                },
                key: {
                    // 使用 title 属性显示节点名称， 不用默认的 name 作为属性名
                    name: "title"
                }
            },
            check: {
                enable: true
            }
        };

        console.log("generating auth tree...")
        // d.生成树形结构
        $.fn.zTree.init($("#authTreeDemo"), setting, authList);

        // 获取 zTreeObj 对象
        let zTreeObj = $.fn.zTree.getZTreeObj("authTreeDemo");

        // 调用 zTreeObj 对象的方法， 把节点展开
        zTreeObj.expandAll(true);

        // e. 查询已分配的Auth的id组成的数组
        ajaxReturn = $.ajax({
            "url" : "/assign/get/assigned/auth/id/by/role.json",
            "type":"post",
            "data":{
                "roleId":window.roleId
            },
            "dataType":"json",
            "async": false
        });

        if (ajaxReturn.status !== 200) {
            layer.msg("Request Failed："+ajaxReturn.status+" Detail："+ajaxReturn.statusText);
            return ;
        }
        //从相应结果中获取authIdArray
        var authIdArray = ajaxReturn.responseJSON.data;
        alert(authIdArray);

        // f. 根据 authIdArray 把树形结构中对应的节点勾选上
        for(var i = 0; i < authIdArray.length; i++) {
            var authId = authIdArray[i];
            // ②根据 id 查询树形结构中对应的节点
            var treeNode = zTreeObj.getNodeByParam("id", authId);
            // ③将 treeNode 设置为被勾选
            // checked 设置为 true 表示节点勾选
            var checked = true;
            // checkTypeFlag 设置为 false， 表示不“联动”， 不联动是为了避免把不该勾选的勾选上
            var checkTypeFlag = false;
            // 执行
            zTreeObj.checkNode(treeNode, checked, checkTypeFlag);
        }
    }

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
                    <button id="batchRemoveBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> Delete</button>
                    <button type="button" id="showAddModalBtn" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> Add</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="summaryBox" type="checkbox"></th>
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
<%@include file="/WEB-INF/modal-role-confirm.jsp"%>
<%@include file="/WEB-INF/modal-role-assign-auth.jsp"%>
</body>
</html>