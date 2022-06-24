package com.crowdfunding.spring.boot;

import com.crowdfunding.spring.boot.entity.Student;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @ClassName MySpringBootTest
 * @Description TODO
 * @Author katefu
 * @Date 6/22/22 8:40 PM
 * @Version 1.0
 **/

@SpringBootTest
public class MySpringBootTest {
    Logger logger = LoggerFactory.getLogger(MySpringBootTest.class);

    @Autowired
    private Student student;

    @Value("${my.best.wishes}")
    private String wishes;

    @Test
    public void testReadSimpleValue(){
        logger.info(wishes);
    }

    @Test
    public void testReadYml(){
        logger.info(student.toString());
    }


}
