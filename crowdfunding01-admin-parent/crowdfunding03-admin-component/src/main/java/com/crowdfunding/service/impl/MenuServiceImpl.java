package com.crowdfunding.service.impl;

import com.crowdfunding.entity.Menu;
import com.crowdfunding.entity.MenuExample;
import com.crowdfunding.mapper.MenuMapper;
import com.crowdfunding.service.api.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName MenuServiceImpl
 * @Description Menu Service
 * @Author katefu
 * @Date 5/20/22 12:35 AM
 * @Version 1.0
 **/

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;


    @Override
    public List<Menu> getAll() {
        List<Menu> menuList = menuMapper.selectByExample(new MenuExample());
        return menuList;
    }

    @Override
    public void saveMenu(Menu menu) {
        menuMapper.insert(menu);
    }

    @Override
    public void updateMenu(Menu menu) {
        //由于pid没有传入要使用有选择的更新，保证pid不会被置空
        menuMapper.updateByPrimaryKeySelective(menu);
    }

    @Override
    public void removeMenu(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }
}
