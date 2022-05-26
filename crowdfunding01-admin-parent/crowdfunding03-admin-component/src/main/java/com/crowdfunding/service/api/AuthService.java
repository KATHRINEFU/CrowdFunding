package com.crowdfunding.service.api;

import com.crowdfunding.entity.Auth;

import java.util.List;

public interface AuthService {
    List<Auth> getAll();

    List<Integer> getAssignedAuthIdByRoleId(Integer roleId);
}
