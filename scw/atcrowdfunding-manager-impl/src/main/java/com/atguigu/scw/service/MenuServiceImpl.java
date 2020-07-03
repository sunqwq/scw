package com.atguigu.scw.service;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TMenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MenuServiceImpl implements MenuService{

    @Autowired
    TMenuMapper menuMapper;
    @Override
    public List<TMenu> getMenus() {
        return menuMapper.selectByExample(null);
    }

    @Override
    public void addMenu(TMenu menu) {
        menuMapper.insertSelective(menu);
    }

    @Override
    public void delMenu(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TMenu getMenu(Integer id) {
        return menuMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateMenu(TMenu menu) {
        menuMapper.updateByPrimaryKeySelective(menu);
    }


}
