package com.crowdfunding;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

/**
 * @ClassName AuthenticationConsumerMain
 * @Description TODO
 * @Author katefu
 * @Date 7/18/22 12:33 AM
 * @Version 1.0
 **/

@EnableEurekaClient
@SpringBootApplication
public class AuthenticationConsumerMain {
    public static void main(String[] args) {
        SpringApplication.run(AuthenticationConsumerMain.class, args);
    }
}
