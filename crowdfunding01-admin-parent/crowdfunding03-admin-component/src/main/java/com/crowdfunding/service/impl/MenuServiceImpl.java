package com.crowdfunding.service.impl;

import com.crowdfunding.mapper.MenuMapper;
import com.crowdfunding.service.api.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


}
