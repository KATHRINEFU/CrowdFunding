package com.crowdfunding.service.impl;

import com.crowdfunding.entity.Auth;
import com.crowdfunding.entity.AuthExample;
import com.crowdfunding.mapper.AuthMapper;
import com.crowdfunding.service.api.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
