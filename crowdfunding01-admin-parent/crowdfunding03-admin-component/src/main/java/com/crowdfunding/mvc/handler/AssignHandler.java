package com.crowdfunding.mvc.handler;

import com.crowdfunding.entity.Auth;
import com.crowdfunding.entity.Role;
import com.crowdfunding.service.api.AdminService;
import com.crowdfunding.service.api.AuthService;
import com.crowdfunding.service.api.RoleService;
import com.crowdfunding.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @ClassName AssignHandler
 * @Description TODO
 * @Author katefu
 * @Date 5/24/22 10:14 PM
 * @Version 1.0
 **/

@Controller
public class AssignHandler {
    @Autowired
    private AdminService adminService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private AuthService authService;

    @ResponseBody
    @RequestMapping("/assign/do/role/assign/auth.json")
    public ResultEntity<String> saveRoleAuthRelationship(
            @RequestBody Map<String, List<Integer>> map
            ){
        authService.saveRoleAuthRelationship(map);
        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("/assign/get/assigned/auth/id/by/role.json")
    public ResultEntity<List<Integer>> getAssignedAuthIdByRoleId(@RequestParam("roleId") Integer roleId){
        List<Integer> authIdList = authService.getAssignedAuthIdByRoleId(roleId);
        return ResultEntity.successWithData(authIdList);
    }

    @ResponseBody
    @RequestMapping("/assign/get/all/auth.json")
    public ResultEntity<List<Auth>> getAllAuth(){
        List<Auth> authList = authService.getAll();
        return ResultEntity.successWithData(authList);
    }

    @RequestMapping("/assign/do/role/assign.html")
    public String saveAdminRoleRelationship(
            @RequestParam("adminId") Integer adminId,
            @RequestParam("pageNum") Integer pageNum,
            @RequestParam("keyword") String keyword,
            //????????????????????????????????????????????????????????????????????????????????????
            @RequestParam(value = "roleIdList", required = false) List<Integer> roleIdList
    ){
        adminService.saveAdminRoleRelationship(adminId, roleIdList);
        return "redirect:/admin/get/page.html?pageNum="+pageNum+"&keyword="+keyword;
    }

    @RequestMapping("/assign/to/assign/role/page.html")
    public String toAssignRolePage(
            @RequestParam("adminId") Integer adminId,
            ModelMap modelMap){
        // 1.???????????????????????????
        List<Role> assignedRoleList= roleService.getAssignedRole(adminId);
        // 2???????????????????????????
        List<Role> unAssignedRoleList= roleService.getUnAssignedRole(adminId);
        // 3???????????????????????????request.setAttribute("attrName", attrValue)
         modelMap.addAttribute("assignedRoleList", assignedRoleList);
         modelMap.addAttribute("unAssignedRoleList", unAssignedRoleList);

         return "assign-role";
    }
}
