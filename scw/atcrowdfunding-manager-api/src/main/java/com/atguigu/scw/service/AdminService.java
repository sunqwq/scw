package com.atguigu.scw.service;


import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;

import java.util.List;

public interface AdminService {
    //删除指定id管理员
    public void deleteAdmin(Integer id);

    public TAdmin doLogin(String loginacct,String userpswd);

    List<TMenu> getPMenus();

    List<TAdmin> getAdmins(String condition);


    void addAdmin(TAdmin tAdmin);


    TAdmin getAdmin(Integer id);

    void updateAdmin(TAdmin admin);

    void bathDelAdmins(List<Integer> ids);
}
