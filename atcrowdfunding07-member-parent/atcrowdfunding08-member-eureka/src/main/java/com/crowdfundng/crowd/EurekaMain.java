package com.crowdfundng.crowd;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * @ClassName EurekaMain
 * @Description TODO
 * @Author katefu
 * @Date 7/4/22 8:33 PM
 * @Version 1.0
 **/

@EnableEurekaServer
@SpringBootApplication
public class EurekaMain {
    public static void main(String[] args) {
        SpringApplication.run(EurekaMain.class, args);
    }
}
