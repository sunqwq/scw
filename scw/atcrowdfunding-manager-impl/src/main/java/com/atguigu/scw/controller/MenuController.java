package com.atguigu.scw.controller;


import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    MenuService menuService;

    //6.处理异步更新菜单的方法
    @ResponseBody
    @PostMapping("/updateMenu")
    public String updateMenu(TMenu menu){
        menuService.updateMenu(menu);
        return "ok";
    }

    //5.处理异步查询指定菜单的请求
    @ResponseBody
    @GetMapping("/getMenu")
    public TMenu getMenu(Integer id){

        return  menuService.getMenu(id);
    }

    //4.处理异步删除菜单的方法
    @ResponseBody
    @GetMapping("/deleteMenu")
    public String deleteMenu(Integer id){
        menuService.delMenu(id);
        return "ok";
    }


    //3.处理异步新增菜单方法
    @ResponseBody
    @PostMapping("/addMenu")
    public String addMenu(TMenu menu){
        menuService.addMenu(menu);
        return "ok";
    }


    //2.处理异步获取菜单的方法
    @ResponseBody
    @GetMapping("/getMenus")
    public List<TMenu> getMenus(){
       List<TMenu> menus = menuService.getMenus();
        System.out.println("menus = " + menus);
       return menus;
    }

    //1.跳转到menu页面
    @GetMapping("/index")
    public String toMenuPage(){
        return "menus/menu";
    }
}
