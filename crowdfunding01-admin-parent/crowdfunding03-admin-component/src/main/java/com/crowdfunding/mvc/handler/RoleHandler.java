package com.crowdfunding.mvc.handler;

import com.crowdfunding.entity.Role;
import com.crowdfunding.service.api.RoleService;
import com.crowdfunding.util.ResultEntity;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName RoleHandler
 * @Description RoleHandler(Controller)
 * @Author katefu
 * @Date 5/13/22 4:36 PM
 * @Version 1.0
 **/

@Controller
public class RoleHandler {

    @Autowired
    private RoleService roleService;

    @ResponseBody
    @RequestMapping("role/update.json")
    public ResultEntity<String> updateRole(Role role) {
        roleService.updateRole(role);
        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("role/save.json")
    public ResultEntity<String> saveRole(@RequestParam("roleName") String roleName) {

        System.out.println(roleName);
        roleService.saveRole(new Role(null, roleName));

        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("/role/get/page/info.json")
    public ResultEntity<PageInfo<Role>> getPageInfo(
            @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
            @RequestParam(value = "keyword", defaultValue = "") String keyword
    ){
        PageInfo<Role> pageInfo = roleService.getPageInfo(pageNum, pageSize, keyword);
        return ResultEntity.successWithData(pageInfo);
    }


}
