package com.crowdfunding.service.impl;

import checkers.units.quals.A;
import com.crowdfunding.constant.CrowdConstant;
import com.crowdfunding.entity.Admin;
import com.crowdfunding.entity.AdminExample;
import com.crowdfunding.exception.LoginAcctAlreadyInUseException;
import com.crowdfunding.exception.LoginAcctAlreadyInUseForUpdateException;
import com.crowdfunding.exception.LoginFailedException;
import com.crowdfunding.mapper.AdminMapper;
import com.crowdfunding.service.api.AdminService;
import com.crowdfunding.util.CrowdUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.swing.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;


    @Override
    public void saveAdmin(Admin admin) {
        // 1密码加密
        String userPswd = admin.getUserPswd();
        userPswd = CrowdUtil.md5(userPswd);
        admin.setUserPswd(userPswd);

        // 2.生成创建时间
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = format.format(date);
        admin.setCreateTime(createTime);

        // 3.执行保存
        try{
            adminMapper.insert(admin);
        }catch (Exception e){
            if(e instanceof DuplicateKeyException){
                throw new LoginAcctAlreadyInUseException(CrowdConstant.MESSAGE_LOGIN_ACCT_ALREADY_IN_USE);
            }
        }

    }

    @Override
    public List<Admin> getAll() {
        //查询全部，给一个空的example
        return adminMapper.selectByExample(new AdminExample());
    }

    @Override
    public Admin getAdminByLoginAcct(String loginAcct, String userPswd) {
        // 1. 根据登录账号查询Admin对象
        // 创建AdminExample对象
        System.out.println("到1了");
        AdminExample adminExample = new AdminExample();
        // 创建Criteria对象
        AdminExample.Criteria criteria = adminExample.createCriteria();
        // 在Criteria对象中封装查询条件
        criteria.andLoginEqualTo(loginAcct); // 这里跟视频中不太一样，因为方法名不同
        // 调用AdminMapper的方法执行查询
        List<Admin> list = adminMapper.selectByExample(adminExample);

        // 2.判断Admin对象是否为null
        if (list == null || list.size() == 0) {
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }

        if (list.size()>1) {
            throw new RuntimeException(CrowdConstant.MESSAGE_SYSTEM_ERROR_LOGIN_NOT_UNIQUE);
        }

        Admin admin = list.get(0);
        // 3.为null则抛出异常
        if (admin == null) {
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }
        System.out.println("查到用户了");
        // 4.Admin对象不为null，取出密码
        String userPswdDB = admin.getUserPswd();
        // 5.将表单提交的明文密码进行加密
        String userPswmForm = CrowdUtil.md5(userPswd);
        // 6.比较密码
        System.out.println("登录密码"+userPswmForm);
        System.out.println("用户密码"+userPswdDB);
        if (!Objects.equals(userPswdDB, userPswmForm)) {
            // 7.结果不一致，抛异常
            throw new LoginFailedException(CrowdConstant.MESSAGE_LOGIN_FAILED);
        }
        // 8.如果一致则返回Admin对象
        return admin;
    }

    @Override
    public Admin getAdminByLoginAcct(String username) {
        AdminExample example = new AdminExample();
        AdminExample.Criteria criteria = example.createCriteria();
        criteria.andLoginEqualTo(username);
        List<Admin> list =  adminMapper.selectByExample(example);
        Admin admin = list.get(0);
        return admin;
    }

    @Override
    public PageInfo<Admin> getPageInfo(String keyword, Integer pageNum, Integer pageSize) {
        // 1.调用pageHelper的静态方法，开启分页功能
        // 充分体现了pageHelper的非侵入式设计，原本要做的查询不需要修改
        PageHelper.startPage(pageNum, pageSize);
        // 2.执行查询
        List<Admin> list = adminMapper.selectAdminByKeyword(keyword);
        // 3.封装到pageInfo对象
        return new PageInfo<>(list);
    }

    @Override
    public void remove(Integer adminId) {
        adminMapper.deleteByPrimaryKey(adminId);
    }

    @Override
    public Admin getAdminById(Integer adminId) {
         return adminMapper.selectByPrimaryKey(adminId);
    }

    @Override
    public void update(Admin admin) {
        //表示有选择的更新，对于null值的字段不更新
        try{
            adminMapper.updateByPrimaryKeySelective(admin);
        }catch (Exception e){
            if(e instanceof DuplicateKeyException){
                throw new LoginAcctAlreadyInUseForUpdateException(CrowdConstant.MESSAGE_LOGIN_ACCT_ALREADY_IN_USE);
            }
        }

    }

    @Override
    public void saveAdminRoleRelationship(Integer adminId, List<Integer> roleIdList) {
        //先根据adminId删除旧数据，再保存全部新数据
        adminMapper.deleteOldRelationship(adminId);
        if(roleIdList!=null && roleIdList.size()>0){
            adminMapper.insertNewRelationship(adminId, roleIdList);
        }
    }


}
