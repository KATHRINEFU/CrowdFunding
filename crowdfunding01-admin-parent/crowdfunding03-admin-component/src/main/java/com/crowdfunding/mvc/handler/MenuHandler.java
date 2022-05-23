package com.crowdfunding.mvc.handler;

import com.crowdfunding.entity.Menu;
import com.crowdfunding.service.api.MenuService;
import com.crowdfunding.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName MenuHandler
 * @Description Menu Handler
 * @Author katefu
 * @Date 5/20/22 12:37 AM
 * @Version 1.0
 **/

@Controller
public class MenuHandler {

    @Autowired
    private MenuService menuService;

    @ResponseBody
    @RequestMapping("/menu/remove.json")
    public ResultEntity<String> removeMenu(@RequestParam("id") Integer id){
        menuService.removeMenu(id);
        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("/menu/update.json")
    public ResultEntity<String> updateMenu(Menu menu){
        menuService.updateMenu(menu);
        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("/menu/save.json")
    public ResultEntity<String> saveMenu(Menu menu) throws InterruptedException {
        Thread.sleep(2000); //避免异步
        menuService.saveMenu(menu);
        return ResultEntity.successWithoutData();
    }

    @ResponseBody
    @RequestMapping("/menu/get/whole/tree.json")
    public ResultEntity<Menu> getWholeTreeNew() {

        // 1.查询全部的Menu对象
        List<Menu> menuList = menuService.getAll();

        // 2.声明一个变量来存储找到的根节点
        Menu root = null;

        // 3.创建 Map 对象用来存储 id 和 Menu 对象的对应关系便于查找父节点
        Map<Integer,Menu> menuMap = new HashMap<>();

        // 4.遍历 menuList 填充 menuMap
        for (Menu menu: menuList) {

            Integer id = menu.getId();

            menuMap.put(id, menu);
        }

        // 5.再次遍历 menuList 查找根节点、组装父子节点
        for (Menu menu: menuList) {

            // 5.1 获取当前对象pid
            Integer pid = menu.getPid();

            // 5.2 检查pid是否为null
            if (pid == null) {
                // 将当前对象赋给root
                root = menu;
                continue;
            }
            // 5.3 如果pid不为null，说明当前节点有父节点，找到父节点就可以进行组装
            menuMap.get(pid).getChildren().add(menu);
        }
        return ResultEntity.successWithData(root);
    }
}
