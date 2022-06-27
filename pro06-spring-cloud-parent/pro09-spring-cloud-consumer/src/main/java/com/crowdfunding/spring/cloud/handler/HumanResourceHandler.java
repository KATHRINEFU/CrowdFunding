package com.crowdfunding.spring.cloud.handler;

import com.crowdfunding.spring.cloud.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

/**
 * @ClassName HumanResourceHandler
 * @Description TODO
 * @Author katefu
 * @Date 6/26/22 9:54 PM
 * @Version 1.0
 **/

@RestController
public class HumanResourceHandler {
    @Autowired
    private RestTemplate restTemplate;

    @RequestMapping("/consumer/get/employee")
    public Employee getEmployeeRemote() {

        // 1.声明远程微服务主机地址和端口号
        String host = "http://localhost:1000";
        // 2.声明具体要调用的功能的 URL 地址
        String url = "/provider/get/employee/remote";

        // 3. 通过RestTemplate调用远程微服务
        return restTemplate.getForObject(host + url, Employee.class);
    }
}
