package com.crowdfunding.mvc.handler;

import com.crowdfunding.entity.Admin;
import com.crowdfunding.service.api.AdminService;
import com.crowdfunding.util.CrowdUtil;
import com.crowdfunding.util.ResultEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class TestHandler {
    private Logger logger = LoggerFactory.getLogger(TestHandler.class);

    @Autowired
    private AdminService adminService;

//    @ResponseBody
//    @RequestMapping("/send/compose/object.json")
//    public ResultEntity<Student> testReceiveComplicatedObject(@RequestBody Student student, HttpServletRequest request){
//        boolean judgeResult = CrowdUtil.judgeRequestType(request);
//        logger.info("judgeResult = "+ judgeResult);
//        logger.info(student.toString());
//        return ResultEntity.successWithData(student);
//    }

    @ResponseBody
    @RequestMapping("/send/array/two.html")
    public String testReceiveArrayTwo(@RequestParam List<Integer> array){

        for (Integer number: array) {
            logger.info("number="+number);
        }
        return "target";
    }

    @ResponseBody
    @RequestMapping("/send/array/one.html")
    public String testReceiveArrayOne(@RequestParam("array[]") List<Integer> array){
        for (Integer number: array) {
            System.out.println("number="+number);
        }
        return "target";
    }

    @RequestMapping("/test/ssm.html")
    public String testSsm(ModelMap modelMap, HttpServletRequest request){
        boolean judgeResult = CrowdUtil.judgeRequestType(request);

        logger.info("judgeResult = "+ judgeResult);
        List<Admin> adminList = adminService.getAll();
        modelMap.addAttribute("adminList", adminList);

        System.out.println(10/0);

//        String a = null;
//        System.out.println(a.length());

        //自动会加前缀/WEB—INF/后缀.jsp
        return "target";
    }

}
