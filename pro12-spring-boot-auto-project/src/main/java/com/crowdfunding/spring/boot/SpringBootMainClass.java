package com.crowdfunding.spring.boot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @ClassName SpringBootMainClass
 * @Description TODO
 * @Author katefu
 * @Date 6/23/22 10:18 PM
 * @Version 1.0
 **/

@MapperScan("com.crowdfunding.spring.boot.mapper")
@SpringBootApplication
public class SpringBootMainClass {

    public static void main(String[] args) {
        SpringApplication.run(SpringBootMainClass.class,args);
    }
}
