package com.crowdfunding.spring.cloud.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
 * @ClassName SpringCloudConfig
 * @Description TODO
 * @Author katefu
 * @Date 6/26/22 9:52 PM
 * @Version 1.0
 **/

@Configuration
public class SpringCloudConfig {
    @Bean
    public RestTemplate getRestTemplate(){
        return new RestTemplate();
    }
}
