package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/permission")
@Controller
public class PermissionController {
    @Autowired
    PermissionService permissionService;
    //2.处理查询指定角色拥有的权限id集合
    @ResponseBody
    @GetMapping("/getAssignedPermissionIds")
    public List<Integer> getAssignedPermissionIds(Integer roleId){
        return permissionService.getAssignedPermissionIds(roleId);
    }

    //1.处理查询权限列表的方法
    @ResponseBody
    @GetMapping("/getPermissions")
    public List<TPermission> getPermissions(){
        return permissionService.getPermissions();
    }
}
