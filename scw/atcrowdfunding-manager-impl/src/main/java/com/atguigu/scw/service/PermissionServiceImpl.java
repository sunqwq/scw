package com.atguigu.scw.service;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TRolePermission;
import com.atguigu.scw.bean.TRolePermissionExample;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TRolePermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    TPermissionMapper permissionMapper;

    @Override
    public List<TPermission> getPermissions() {
        return permissionMapper.selectByExample(null);
    }

    @Autowired
    TRolePermissionMapper rolePermissionMapper;
    @Override
    public List<Integer> getAssignedPermissionIds(Integer roleId) {
        TRolePermissionExample exa=new TRolePermissionExample();
        exa.createCriteria().andIdEqualTo(roleId);
        List<TRolePermission> permissions = rolePermissionMapper.selectByExample(exa);
        List<Integer> list = new ArrayList<>();
        if(CollectionUtils.isEmpty(permissions)) return null;
        for (TRolePermission permission : permissions) {
            list.add( permission.getPermissionid());
        }
        return list;
    }

}
