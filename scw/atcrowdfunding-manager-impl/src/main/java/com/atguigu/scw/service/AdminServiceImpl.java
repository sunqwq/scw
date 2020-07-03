package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TAdminExample;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.utils.DateUtil;
import com.atguigu.scw.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    TAdminMapper tAdminMapper;
    @Autowired
    PasswordEncoder encoder;

    @Override
    public void deleteAdmin(Integer id) {
       tAdminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TAdmin doLogin(String loginacct, String userpswd) {
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(MD5Util.digest(userpswd));
        List<TAdmin> admins = tAdminMapper.selectByExample(exa);
        if(CollectionUtils.isEmpty(admins)||admins.size()>1){
            return null;
        }
        System.out.println(admins.get(0));
        return admins.get(0);
    }

    @Autowired
    TMenuMapper tMenuMapper;
    @Override
    public List<TMenu> getPMenus() {
        //1.查询所有的菜单
        List<TMenu> menus = tMenuMapper.selectByExample(null);
        //2.挑选父菜单集合：pid=0
        Map<Integer,TMenu> pmenus = new HashMap<>();
        for (TMenu menu : menus) {
            if(menu.getPid()==0){
                //存储父菜单时，需要使用他的id作为键，子菜单的pid是和父菜单的id比较的
                //先初始化父菜单存储子菜单对象的集合
                menu.setChildren(new ArrayList<TMenu>());
                pmenus.put(menu.getId(), menu);
                continue;
            }
        }
        //3.将子菜单设置给他的父菜单对象
        for (TMenu menu : menus) {
            //根据正在遍历的子菜单的pid去查找他的pmenu对象
            TMenu pMenu = pmenus.get(menu.getPid());
            if(menu.getPid()!=0 && pMenu != null){
                //将子菜单对象设置给他的父菜单对象
                pMenu.getChildren().add(menu);
                continue;
            }
        }
        //返回封装完毕的父菜单集合
        return new ArrayList<>(pmenus.values());
    }

    @Override
    public List<TAdmin> getAdmins(String condition) {
        if(!(StringUtils.isEmpty(condition)) ){
            //查询条件不为空，分页数据
            TAdminExample exa = new TAdminExample();
            TAdminExample.Criteria criteria = exa.createCriteria();
            criteria.andLoginacctLike("%"+condition+"%");
            TAdminExample.Criteria criteria2 = exa.createCriteria();
            criteria2.andEmailLike("%"+condition+"%");
            TAdminExample.Criteria criteria3 = exa.createCriteria();
            criteria3.andUsernameLike("%"+condition+"%");
            exa.or(criteria2);
            exa.or(criteria3);

            return tAdminMapper.selectByExample(exa);
        }

        List<TAdmin> admins = tAdminMapper.selectByExample(null);
        return admins;
    }

    //添加
    @Override
    public void addAdmin(TAdmin tAdmin) {
        //唯一性校验：登录账号和邮箱必须唯一
        //根据新增管理员的账号查询是否被占用
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(tAdmin.getLoginacct());
        long countByLoginacct = tAdminMapper.countByExample(exa);
        if(countByLoginacct >0){
            //账号被占用，手动抛出异常
           throw  new RuntimeException("账号异常：账号被占用");
        }
        exa.clear();
        exa.createCriteria().andEmailEqualTo(tAdmin.getEmail());
        long countByEmail = tAdminMapper.countByExample(exa);
        if(countByEmail >0){
            //账号被占用，手动抛出异常
            throw  new RuntimeException("邮箱异常：邮箱已存在");
        }
        //密码加密
        tAdmin.setUserpswd(encoder.encode(tAdmin.getUserpswd()));
        //设置账号创建的时间
        tAdmin.setCreatetime(DateUtil.getFormatTime());
        tAdminMapper.insertSelective(tAdmin);
    }

    @Override
    public TAdmin getAdmin(Integer id) {
        return tAdminMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateAdmin(TAdmin admin) {
        tAdminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public void bathDelAdmins(List<Integer> ids) {
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andIdIn(ids);
        tAdminMapper.deleteByExample(exa);
    }
}
