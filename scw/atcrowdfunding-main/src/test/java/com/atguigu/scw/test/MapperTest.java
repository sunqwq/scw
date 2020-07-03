package com.atguigu.scw.test;


import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.utils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


/*@ContextConfiguration(locations={"classpath:spring/spring-beans.xml",
        "classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})
@RunWith(value=SpringJUnit4ClassRunner.class)*/
public class MapperTest {

    /*@Autowired
    TAdminMapper tAdminMapper;

    @Test
    public void test(){
       *//* long l = tAdminMapper.countByExample(null);
        System.out.println("l = " + l);*//*
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(null);
        System.out.println("tAdmins = " + tAdmins);

    }

    @Test
    public void test1(){
        String digest = MD5Util.digest("123456");
        System.out.println("digest = " + digest);
    }*/
    @Test
    public void test2() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encode = encoder.encode("123456");
        System.out.println("encode = " + encode);
//        encode = $2a$10$UUaTKSaCNw1KoU8qmbuRpOVqXELtT.KVWhwwrpYMQdo332Cyl3VCa
//        encode = $2a$10$bf4T8N8FXaY0MyIQwW6hWOwutCxxist6z7SItEAoHwqv1yuYmCwBS

    }
}
