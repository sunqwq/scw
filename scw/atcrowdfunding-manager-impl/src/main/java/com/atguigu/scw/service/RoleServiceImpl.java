package com.atguigu.scw.service;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.bean.TRoleExample;
import com.atguigu.scw.bean.TRolePermissionExample;
import com.atguigu.scw.mapper.TRoleMapper;
import com.atguigu.scw.mapper.TRolePermissionMapper;
import com.atguigu.scw.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService{
    @Autowired
    TRoleMapper roleMapper;

    @Override
    public List<TRole> getRoles(String condition) {
        if(!StringUtil.isEmpty(condition)){
            TRoleExample exa = new TRoleExample();
            exa.createCriteria().andNameLike("%"+condition+"%");
            return roleMapper.selectByExample(exa);
        }


        return roleMapper.selectByExample(null);
    }

    @Override
    public void addRole(TRole role) {
        roleMapper.insertSelective(role);
    }

    @Override
    public void delRole(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDelRole(List<Integer> ids ) {
        TRoleExample exa = new TRoleExample();
        exa.createCriteria().andIdIn(ids);
        roleMapper.deleteByExample(exa);
    }

    @Override
    public TRole getRole(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateRole(TRole role) {
        System.out.println("role = " + role);
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Autowired
    TRolePermissionMapper rolePermissionMapper;
    @Override
    public void reAssginPermissionToRole(Integer roleId, List<Integer> permissionIds) {
        //删除之前已经分配的权限
        TRolePermissionExample exa = new TRolePermissionExample();
        exa.createCriteria().andRoleidEqualTo(roleId);
        rolePermissionMapper.deleteByExample(exa);
        //重新分配权限给角色
        rolePermissionMapper.reAssginPermissionToRole(roleId,permissionIds);

    }


}
