//执行分页，生成页面效果，调用该函数重新加载页面
function generatePage(){
    // 1。获取分页数据
    var pageInfo = getPageInfoRemote();
    // 2.填充表格
    fillTableBody(pageInfo);
    // 3.
}

//远程访问服务器端程序，获取pageInfo数据
function getPageInfoRemote(){
    var ajaxResult = $.ajax({
        "url": "/role/get/page/info.json",
        "type": "post",
        "data": {
            "pageNum": window.pageNum,
            "pageSize": window.pageSize,
            "keyword": window.keyword
        },
        "async":false,
        "dataType": "json",
    });
    console.log(ajaxResult)
    var statusCode = ajaxResult.status;

    //如果当前相应失败
    if(statusCode!=200){
        layer.msg("Server side calling failed, Response Code = "+statusCode+"Message = "+ajaxResult.statusText);
        return null;
    }

    var resultEntity = ajaxResult.responseJSON;
    //从resultEntity获取result属性
    var result = resultEntity.result;
    //判断result是否成功
    if(result=="FAILED"){
        layer.msg(resultEntity.message);
        return null;
    }
    //确认result成功，获取pageInfo
    var pageInfo = resultEntity.data;
    //返回
    return pageInfo;
}

//填充表格
function fillTableBody(pageInfo){
    //清除tbody中的旧数据
    $("#rolePageBody").empty();
    //没有搜索结果时不显示分页
    $("#Pagination").empty();

    //判断pageInfo是否有效
    if(pageInfo==null || pageInfo==undefined || pageInfo.list==null || pageInfo.list.length==0){
        $("rolePageBody").append("<tr><td colspan='4'>Sorry, no data found!</td></tr>");
        return ;
    }

    //使用pageInfo填充tbody
    for(var i=0; i<pageInfo.list.length; i++){
        var role = pageInfo.list[i];
        var roleId = role.id;
        var roleName = role.name;
        var numberTd = "<td>"+(i+1)+"</td>";
        var checkboxTd = "<td><input type='checkbox'></td>";
        var roleNameTd = "<td>"+roleName+"</td>";
        var checkBtn = "<button type=\"button\" class=\"btn btn-success btn-xs\"><i class=\" glyphicon glyphicon-check\"></i></button>";
        var pencilBtn = "<button type=\"button\" class=\"btn btn-primary btn-xs\"><i class=\" glyphicon glyphicon-pencil\"></i></button>";
        var removeBtn = "<button type=\"button\" class=\"btn btn-danger btn-xs\"><i class=\" glyphicon glyphicon-remove\"></i></button>";

        var buttonTd = "<td>"+checkBtn+" "+pencilBtn+" "+removeBtn+"</td>";
        var tr = "<tr>"+numberTd+checkboxTd+roleNameTd+buttonTd+"</tr>";
        $("rolePageBody").append(tr);
    }

    //生成导航条
    generateNavigator(pageInfo);
}

//生成分页页码导航条
function generateNavigator(pageInfo){
    //获取总记录数
    var totalRecord = pageInfo.total;
    //声明其他相关属性
    var properties={
        "num_edge_entries":3,
        "num_display_entries":5,
        "callback":paginationCallBack(),
        "items_per_page":pageInfo.pageSize,
        "current_page":pageInfo.pageNum-1,
        "prev_test":"Pre",
        "next_text":"Next"
    }
    //调用pagination初始化函数
    $("#Pagination").pagination(totalRecord,properties);

}

//翻页时的回调函数
function paginationCallBack(pageIndex, jQuery){
    //修改全局变量pageNum
    window.pageNum = pageIndex+1;
    //调用分页函数 不回递归循环，因为不是同步调用的，回调函数在很后面
    generatePage();
    //取消页码超链接的默认行为
    return false;
}