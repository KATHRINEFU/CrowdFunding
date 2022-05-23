package com.crowdfunding.service.api;

import com.crowdfunding.entity.Menu;
import org.springframework.stereotype.Service;

import java.util.List;

public interface MenuService {
    List<Menu> getAll();

    void saveMenu(Menu menu);

    void updateMenu(Menu menu);

    void removeMenu(Integer id);
}
