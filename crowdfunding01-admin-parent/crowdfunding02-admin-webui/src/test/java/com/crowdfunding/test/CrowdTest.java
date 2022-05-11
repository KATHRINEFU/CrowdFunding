package com.crowdfunding.test;

import com.crowdfunding.entity.Admin;
import com.crowdfunding.mapper.AdminMapper;
import com.crowdfunding.service.api.AdminService;
import org.junit.Test;
import org.junit.platform.commons.logging.Logger;
import org.junit.platform.commons.logging.LoggerFactory;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"/spring-persist-mybatis.xml","classpath:spring-persist-tx.xml"})

// 这里用junit5进行测试
//@SpringJUnitConfig(locations = {"classpath:spring-persist-mybatis.xml"})
public class CrowdTest {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private AdminService adminService;

    @Test
    public void test(){
        for(int i=0; i<238; i++){
            adminMapper.insert(new Admin(null, "loginAcct"+i, "userPswd"+i, "userName"+i, "email"+i, null));
        }
    }
    @Test
    public void testTx(){
        Admin admin = new Admin(null, "jerry","123456","jer","jerry@qq.com",null);
        adminService.saveAdmin(admin);
    }

    @Test
    public void testLog(){
        //获取logger对象
        Logger logger = LoggerFactory.getLogger(CrowdTest.class);
        //根据不同日志级别打印日志
//        logger.debug("Hello, I am debug level");
//        logger.info("Hello, I am info level");
//        logger.warn("warn level");
//        logger.error("error level");


    }

    @Test
    public void testInsertAdmin(){
        Admin admin;
        admin = new Admin(null,"Rachel","123123","rui","rui@qq.com",null);
        int count = adminMapper.insert(admin);
        System.out.println(count);
    }

    @Test
    public void testConnection() throws SQLException {
        Connection connection = dataSource.getConnection();
        System.out.println(connection);
    }
}
