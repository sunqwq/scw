package com.atguigu.scw.service;

import com.atguigu.scw.bean.TPermission;

import java.util.List;

public interface PermissionService {

    List<TPermission> getPermissions();

    List<Integer> getAssignedPermissionIds(Integer roleId);
}
