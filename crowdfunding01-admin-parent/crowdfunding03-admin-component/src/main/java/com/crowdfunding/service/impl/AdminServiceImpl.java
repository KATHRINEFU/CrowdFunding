package com.crowdfunding.service.impl;

import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.entity.Admin;
import com.crowdfunding.entity.AdminExample;
import com.crowdfunding.exception.LoginFailedException;
import com.crowdfunding.mapper.AdminMapper;
import com.crowdfunding.service.api.AdminService;
import com.crowdfunding.util.CrowdUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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

    @Override
    public Admin getAdminByLoginAcct(String loginAcct, String userPswd) {
        // 1.根据登陆账号查询admin对象
        // 1)创建adminExample对象
        AdminExample adminExample = new AdminExample();
        // 2)创建Criteria对象
        AdminExample.Criteria criteria = adminExample.createCriteria();
        // 3) 在criteria对象中封装查询条件
        criteria.andLoginEqualTo(loginAcct);
        // 4)调用AdminMapper执行查询
        List<Admin> list = adminMapper.selectByExample(adminExample);

        // 2.判断admin对象是否非空
        if(list==null || list.size()==0) {
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }

        if(list.size()>1){
            throw new RuntimeException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
        }
        // 3.如果为空则抛出异常，如果不为空，取出对应密码
        Admin admin = list.get(0);
        if(admin==null){
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }
        String userPswdDB = admin.getUserPswd();

        // 4.将表提交的明文密码加密，对密码比较
        String userPswdForm = CrowdUtil.md5(userPswd);
        if(!Objects.equals(userPswdForm,userPswdDB)){ //避免String.equals()的空指针异常
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }
        // 5.如果不一致抛异常，如果一致返回admin对象
        return admin;
    }


}
