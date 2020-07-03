package com.atguigu.scw.service;

import com.atguigu.scw.bean.TRole;

import java.util.List;

public interface RoleService {

    List<TRole> getRoles(String condition);

    void addRole(TRole role);

    void delRole(Integer id);

    void batchDelRole(List<Integer> ids );

    TRole getRole(Integer id);

    void updateRole(TRole role);

    //给角色重新分配权限的方法
    void reAssginPermissionToRole(Integer roleId, List<Integer> permissionIds);
}
