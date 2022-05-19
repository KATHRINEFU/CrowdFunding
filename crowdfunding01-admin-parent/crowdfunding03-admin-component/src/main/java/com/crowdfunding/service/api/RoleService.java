package com.crowdfunding.service.api;

import com.crowdfunding.entity.Role;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface RoleService {
    PageInfo<Role> getPageInfo(Integer pageNum, Integer pageSize, String keyword);

    void saveRole(Role role);

    void updateRole(Role role);

    void removeRole(List<Integer> roleIdList);
}
