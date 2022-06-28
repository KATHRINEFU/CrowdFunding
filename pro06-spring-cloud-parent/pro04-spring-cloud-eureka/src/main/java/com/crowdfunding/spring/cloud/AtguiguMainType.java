package com.crowdfunding.spring.cloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * @ClassName AtguiguMainType
 * @Description TODO
 * @Author katefu
 * @Date 6/27/22 11:07 PM
 * @Version 1.0
 **/
@EnableEurekaServer //启用Eureka服务端
@SpringBootApplication
public class AtguiguMainType {
    public static void main(String[] args) {
        SpringApplication.run(AtguiguMainType.class, args);
    }
}
