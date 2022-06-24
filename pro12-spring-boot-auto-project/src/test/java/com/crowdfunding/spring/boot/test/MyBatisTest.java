package com.crowdfunding.spring.boot.test;

import com.crowdfunding.spring.boot.entity.Emp;
import com.crowdfunding.spring.boot.mapper.EmpMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

/**
 * @ClassName MyBatisTest
 * @Description TODO
 * @Author katefu
 * @Date 6/23/22 10:20 PM
 * @Version 1.0
 **/

@RunWith(SpringRunner.class)
@SpringBootTest
public class MyBatisTest {

    Logger logger = LoggerFactory.getLogger(MyBatisTest.class);

    @Autowired
    private EmpMapper empMapper;

    @Test
    public void testSave() {

        List<Emp> list = empMapper.selectAll();
        for (Emp emp:list) {
            logger.debug(emp.toString());
        }
    }
}
