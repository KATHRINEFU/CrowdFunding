package com.crowdfunding.service.impl;

import com.crowdfunding.entity.Auth;
import com.crowdfunding.entity.AuthExample;
import com.crowdfunding.mapper.AuthMapper;
import com.crowdfunding.service.api.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName AuthServiceImpl
 * @Description Auth Service
 * @Author katefu
 * @Date 5/26/22 10:29 PM
 * @Version 1.0
 **/

@Service
public class AuthServiceImpl implements AuthService {
    @Autowired
    private AuthMapper authMapper;

    @Override
    public List<Auth> getAll() {
        return authMapper.selectByExample(new AuthExample() );
    }

    @Override
    public List<Integer> getAssignedAuthIdByRoleId(Integer roleId) {
        return authMapper.selectAssignedAuthIdByRoleId(roleId);
    }

    @Override
    public void saveRoleAuthRelationship(Map<String, List<Integer>> map) {
        // 1.获取roleId
        List<Integer> roleIdList = map.get("roleId");
        Integer roleId = roleIdList.get(0);
        // 2.删除旧的关系数据
        authMapper.deleteOldRelationship(roleId);
        // 3.获取authIdList
        List<Integer> authIdList = map.get("authIdArray");
        // 4.判断authIdList是否有效
        if(authIdList!=null && authIdList.size()>0){
            authMapper.insertNewRelationship(roleId, authIdList);
        }
    }

    @Override
    public List<String> getAssignedAuthNameByAdminId(Integer adminId) {
        return authMapper.selectAssignedAuthNameByAdminId(adminId);
    }
}
