package com.atguigu.scw.service;


import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    TAdminMapper tAdminMapper;
    @Autowired
    TRoleMapper tRoleMapper;
    @Autowired
    TPermissionMapper tPermissionMapper;
    //根据登录账号加载主体对象的业务方法
    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        //1.根据账号查询用户的信息
        TAdminExample exa= new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(s);
        List<TAdmin> admins = tAdminMapper.selectByExample(exa);
        if(CollectionUtils.isEmpty(admins) || admins.size()>1){
            return null;//账号不存在
        }
        TAdmin admin = admins.get(0);
        //2.根据用户id查询他角色和权限集合
        //根据admin去查询角色集合
        List<TRole> roles =tRoleMapper.selectRolesByAdminId(admin.getId());
        //根据roleid查询权限集合
        List<TPermission> permissions = tPermissionMapper.selectPermissionByAdminId(admin.getId());

        //3.将用户信息和角色权限xin'xi封装为主体对象返回
        List<GrantedAuthority> authorities = new ArrayList();
        if (!(CollectionUtils.isEmpty(roles))){
            //遍历角色集合
            for (TRole role : roles) {
                authorities.add(new SimpleGrantedAuthority("ROLE_"+role.getName()));
            }
        }
        //遍历权限集合
        if (!(CollectionUtils.isEmpty(permissions))){
            //遍历角色集合
            for (TPermission permission : permissions) {
                authorities.add(new SimpleGrantedAuthority(permission.getName()));
            }
        }
        //将用户信息和权限角色集合封装为主体对象返回
        User user = new User(admin.getLoginacct(), admin.getUserpswd(), authorities);
        System.out.println("user = " + user);//主体对象信息
        return user;
    }
}
