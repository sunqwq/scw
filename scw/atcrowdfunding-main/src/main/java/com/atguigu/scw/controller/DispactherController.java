package com.atguigu.scw.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispactherController {
    //BCryptPasswordEncoder加密
    @Bean
    public PasswordEncoder getPasswordEncoder(){
        return new BCryptPasswordEncoder();
    }



    //转发到index
    @RequestMapping(value = {"/index","/","/index.html"})
    public String toIndexPage(){
        return "index";
    }

    @GetMapping("/login.html")
    public String toLoginPage(){

        return "login";
    }
}
