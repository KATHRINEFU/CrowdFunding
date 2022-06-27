package com.crowdfunding.spring.cloud.handler;

import com.crowdfunding.spring.cloud.entity.Employee;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName EmployeeHandler
 * @Description TODO
 * @Author katefu
 * @Date 6/26/22 9:39 PM
 * @Version 1.0
 **/

@RestController
public class EmployeeHandler {
    @RequestMapping("/provider/get/employee/remote")
    public Employee getEmployeeRemote() {
        return new Employee(555, "tom555", 555.55);
    }
}
