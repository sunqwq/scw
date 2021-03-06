package com.atguigu.scw.service;

import com.atguigu.scw.bean.TMenu;

import java.util.List;

public interface MenuService {
    List<TMenu> getMenus();

    void addMenu(TMenu menu);


    void delMenu(Integer id);


    TMenu getMenu(Integer id);

    void updateMenu(TMenu menu);
}
