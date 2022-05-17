package com.crowdfunding.service.api;

import com.crowdfunding.entity.Role;
import com.github.pagehelper.PageInfo;

public interface RoleService {
    PageInfo<Role> getPageInfo(Integer pageNum, Integer pageSize, String keyword);

    void saveRole(Role role);

    void updateRole(Role role);
}
