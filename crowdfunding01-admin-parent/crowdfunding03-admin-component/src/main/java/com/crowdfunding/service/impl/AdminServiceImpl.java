package com.crowdfunding.service.impl;

import com.crowdfunding.entity.Admin;
import com.crowdfunding.entity.AdminExample;
import com.crowdfunding.mapper.AdminMapper;
import com.crowdfunding.service.api.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void saveAdmin(Admin admin) {
        adminMapper.insert(admin);
    }

    @Override
    public List<Admin> getAll() {
        //查询全部，给一个空的example
        return adminMapper.selectByExample(new AdminExample());
    }


}
