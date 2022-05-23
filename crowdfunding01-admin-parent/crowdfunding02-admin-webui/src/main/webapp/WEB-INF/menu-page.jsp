<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="include-head.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ztree/zTreeStyle.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    $(function (){
        //初始化树形结构
        generateTree();

        //给添加子节点的按钮绑定单击响函数
        $("#treeDemo").on("click", " .addBtn", function (){
            // alert("addBtn...");
            //将当前节点的id作为新节点的pid保存到全局变量
            window.pId = this.id;
            //打开模态框
            $("#menuAddModal").modal("show");
            return false;
        });

        //给添加子节点的模态框中的保存按钮绑定单击响函数
        $("#menuSaveBtn").click(function (){
            //收集表单项中用户输入的数据
            var name = $.trim($("#menuAddModal [name = name]").val());
            var url = $.trim($("#menuAddModal [name = url]").val());

            //单选按钮要定位到被选中的
            var icon = $.trim($("#menuAddModal [name = icon]:checked ").val());

            //发送ajax请求
            $.ajax({
                "url": "menu/save.json",
                "type": "post",
                "data":{
                    "pid": window.pId,
                    "name": name,
                    "url": url,
                    "icon": icon
                },
                "dataType":"json",
                "success": function (response){
                    var result = response.result;
                    if(result=="SUCCESS"){
                        layer.msg("Action Succeed!");
                    }
                    if(result=="FAILED"){
                        layer.msg("Action Failed!"+ response.message);
                    }
                },
                "failed": function (response){
                    layer.msg(response.status+" "+response.statusText);
                }
            });

            //关闭模态框
             $("menuAddModal").modal("hide");
             //重新加载树形结构
             generateTree();

             //清空表单，给reset按钮绑定单击响函数
            //jQuery对象点击click不穿参数表示点击
            $("#menuResetBtn").click()
        });

        //给更新子节点的按钮绑定单击响函数
        $("#treeDemo").on("click", " .editBtn", function (){
            console.log("clicking edit...")
            //将当前节点的id保存到全局变量
            window.id = this.id;
            //打开模态框
            $("#menuEditModal").modal("show");
            //获取zTree对象
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
            //根据id查询节点对象
            var key = "id";
            var value = window.id;
            var currentNode = zTreeObj.getNodeByParam(key,value);
            //回显表单数据
            $("#menuEditModal [name=name]").val(currentNode.name);
            $("#menuEditModal [name=url]").val(currentNode.url);
            // 回显radio可以这样理解：被选中的radio的value属性可以组成一个数组，
            // 然后再用这个数组设置回radio，就能够把对应的值选中
            $("#menuEditModal [name=icon]").val([currentNode.icon] );
            return false;
        });

        //给更新模态框中的更新按钮绑定单击响函数
        $("#menuEditBtn").click(function (){
            //收集表单数据
            var name = $("#menuEditModal [name=name]").val();
            var url = $("#menuEditModal [name=url]").val();
            var icon = $("#menuEditModal [name=icon]:checked").val();

            //发送ajax请求
            $.ajax({
                "url": "menu/update.json",
                "type": "post",
                "data":{
                    "id": window.id,
                    "name": name,
                    "url": url,
                    "icon": icon
                },
                "dataType":"json",
                "success": function (response){
                    var result = response.result;
                    if(result=="SUCCESS"){
                        layer.msg("Action Succeed!");
                        //重新加载树形结构
                        generateTree();
                    }
                    if(result=="FAILED"){
                        layer.msg("Action Failed!"+ response.message);
                    }
                },
                "failed": function (response){
                    layer.msg(response.status+" "+response.statusText);
                }
            });

            //关闭模态框
            $("menuEditModal").modal("hide");
        });

        //给删除按钮绑定单击响函数
        $("#treeDemo").on("click", ".removeBtn", function (){
            console.log("clicking delete...")
            //将当前节点的id保存到全局变量
            window.id = this.id;
            //打开模态框
            $("#menuConfirmModal").modal("show");
            //获取zTree对象
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
            //根据id查询节点对象
            var key = "id";
            var value = window.id;
            var currentNode = zTreeObj.getNodeByParam(key,value);

            $("#removeNodeSpan").text(currentNode.name);
        });
        //
        // //给确认模态框的ok按钮绑定单击响函数
        // $("#confirmBtn").click(function (){
        //     $.ajax({
        //         "url":"menu/remove.json",
        //         "type": "post",
        //         "data":{
        //             "id": window.id;
        //         },
        //         "dataType": "json",
        //         "success": function (response){
        //             var result = response.result;
        //             if(result=="SUCCESS"){
        //                 layer.msg("Action Succeed!");
        //                 //重新加载树形结构
        //                 generateTree();
        //             }
        //             if(result=="FAILED"){
        //                 layer.msg("Action Failed!"+ response.message);
        //             }
        //         },
        //         "failed": function (response){
        //             layer.msg(response.status+" "+response.statusText);
        //         }
        //     });
        //
        //     //关闭模态框
        //     $("menuConfirmModal").modal("hide");
        // });

        // 准备生成树形结构的数据
        function generateTree() {
            $.ajax({
                "url": "/crowdfunding02_admin_webui_war/menu/get/whole/tree.json",
                "type": "post",
                "dataType": "json",
                "success": function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        //创建一个json对象用于存储的ztree的设置
                        var setting = {
                            "view": {
                                "addDiyDom": myAddDiyDom,
                                "addHoverDom": myAddHoverDom,
                                "removeHoverDom": myRemoveHoverDom
                            },
                            "data": {
                                "key": {
                                    "url": "notExist"
                                }
                            }
                        };
                        var zNodes = response.data;
                        // 3.初始化树形结构
                        console.log("Initiating tree structure")
                        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    }

                    if (result == "FAILED") {
                        layer.msg(response.message);
                    }
                }
            });
        }

        //修改默认图标
        function myAddDiyDom(treeId, treeNode) {

            // treeId是整个树形结构附着的ul标签的id
            console.log("treeId="+treeId);

            // 当前树形节点的全部数据、
            console.log(treeNode);

            /*    zTree 生成 id 的规则
                例子： treeDemo_7_ico
                解析： ul 标签的 id_当前节点的序号_功能
                提示： “ul 标签的 id_当前节点的序号” 部分可以通过访问 treeNode 的 tId 属性得到
                根据 id 的生成规则拼接出来 span 标签的 id
            */
            var spanId = treeNode.tId + "_ico";

            // 根据控制图标的span标签的id找到这个span标签
            // 删除旧的class
            // 添加新的class
            $("#"+spanId).removeClass().addClass(treeNode.icon);
        }

        //在鼠标移入节点范围时添加按钮组
        function myAddHoverDom(treeId, treeNode){
            //按钮组的标签结构：<span><a><i>
            //按钮组出现的位置是节点中treeDemo_n_a超链接的后面
            //为了在需要移除按钮组时精确定位到按钮组所在的span，需要给span设置有规律的id
            var btnGroupId = treeNode.tId+"_btnGroup";

            //判断以前是否已经添加过
            if($("#"+btnGroupId).length>0){
                return;
            }

            //准备各个按钮的html标签
            var addBtn = "<a id='"+treeNode.id+"' class='addBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='Add Childern Node'>&nbsp;&nbsp;<i class='fa fa-fw fa-plus rbg '></i></a>";
            var removeBtn="<a id='"+treeNode.id+"' class='removeBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='Delete Node'>&nbsp;&nbsp;<i class='fa fa-fw fa-times rbg '></i></a>";
            var editBtn="<a id='"+treeNode.id+"' class='editBtn btn btn-info dropdown-toggle btn-xs' style='margin-left:10px;padding-top:0px;' href='#' title='Edit Node'>&nbsp;&nbsp;<i class='fafa-fw fa-edit rbg '></i></a>";

            //获取当前节点的level
            var level = treeNode.level;

            //声明变量存储拼装好的按钮
            var btnHtml = ""

            //判断当前节点的级别
            if(level==0){
                btnHtml= addBtn;
            }
            if(level==1){
                btnHtml = addBtn+" "+editBtn;
                //获取当前节点的子节点
                var length = treeNode.children.length;
                if(length==0){
                    btnHtml=btnHtml+" "+removeBtn;
                }
            }
            if(level==2){
                btnHtml=editBtn+" "+removeBtn;
            }

            //找到附着着按钮组的超链接
            var anchorId = treeNode.tId+"_a";
            //在超链接后面附加span元素
            $("#"+anchorId).after("<span  id='"+btnGroupId+"'>"+btnHtml+"</span>");
        }

        //在鼠标移开节点范围时删除按钮组
        function myRemoveHoverDom(treeId, treeNode){
            //拼接按钮组的id
            var btnGroupId = treeNode.tId+"_btnGroup";
            //移除d对应的元素
            $("#"+btnGroupId).remove();

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
                    <i class="glyphicon glyphicon-th-list"></i> Permission Menu List
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal">
                        <i class="glyphicon glyphicon-question-sign"></i>
                    </div>
                </div>
                <div class="panel-body">
                    <!-- zTree动态生成的标签所依附的静态节点 -->
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/modal-menu-add.jsp"%>
</body>
</html>