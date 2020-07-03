package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.RoleService;
import com.atguigu.scw.utils.StringUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleService roleService;
    // 给角色分配权限或取消权限的方法
    @ResponseBody
    @GetMapping("/reAssginPermissionToRole")
    public String reAssginPermissionToRole(Integer roleId ,@RequestParam("permissionIds") List<Integer> permissionIds){
        roleService.reAssginPermissionToRole(roleId,permissionIds);
        return "ok";
    }


    //6.处理异步更新指定管理员的方法
    @ResponseBody
    @PostMapping("/updateRole")
    public String updateRole(TRole role){
       roleService.updateRole(role);
        return "ok";
    }

    //5.处理查询指定角色请求的方法
    @ResponseBody
    @GetMapping("/getRole")
    public TRole getRole(Integer id){
      TRole tRole = roleService.getRole(id);
        return tRole;
    }

    //5.处理异步批量删除角色
    @ResponseBody
    @GetMapping("/batchDelRole")
    public String batchDelRole(@RequestParam("ids")List<Integer> ids ){
        roleService.batchDelRole(ids);
        return "ok";
    }


    //4.处理异步删除角色
    @ResponseBody
    @GetMapping("/delRole")
    public String delRole(Integer id){
        roleService.delRole(id);
        return "ok";
    }


    //3.处理异步添加角色
    @ResponseBody
    @PostMapping("/addRole")
    public String addRole(TRole role){
        roleService.addRole(role);
        return "ok";
    }

    //2.处理异步查询角色分页数据的方法
    @ResponseBody
    @GetMapping("/getRoles")
    public PageInfo<TRole> getRoles(String condition,@RequestParam(defaultValue = "1",required = false) Integer pageNum){
        //启用分页查询
        PageHelper.startPage(pageNum,3);
        List<TRole> roles = roleService.getRoles(condition);
        PageInfo<TRole> pageInfo = new PageInfo<>(roles,3);
        //返回分页对象
        return pageInfo;

    }


    //1.转发到role页面的方法
    @GetMapping("/index")
    public String toRolePage(){
        return "role/role";
    }
}
