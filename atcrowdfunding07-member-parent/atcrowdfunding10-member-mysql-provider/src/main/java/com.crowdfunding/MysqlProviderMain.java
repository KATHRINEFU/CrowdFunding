package com.crowdfunding;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * @ClassName MysqlProviderMain
 * @Description TODO
 * @Author katefu
 * @Date 7/11/22 9:17 PM
 * @Version 1.0
 **/

@MapperScan("com.crowdfunding.mapper")
@SpringBootApplication
public class MysqlProviderMain {

    public static void main(String[] args) {
        SpringApplication.run(MysqlProviderMain.class, args);
    }
}
