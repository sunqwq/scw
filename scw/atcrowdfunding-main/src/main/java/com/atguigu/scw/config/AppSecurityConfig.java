package com.atguigu.scw.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration//配置类组件
@EnableWebSecurity//启用springSecurity
public class AppSecurityConfig extends WebSecurityConfigurerAdapter {

    //授权方法
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //super.configure(http);  默认规则
        //1.放行首页和静态资源+登录页面
        http.authorizeRequests()
//        permitAll()所有人都可以访问
        .antMatchers("/index","/","/index.html","/static/**","/login.html").permitAll()

//        authenticated()其他请求都需要验证
        .anyRequest().authenticated();

        //2.配置浏览器提交主体创建的登录请求
        http.formLogin()
                .loginPage("/login.html")//指定登录页面
                .loginProcessingUrl("/doLogin")//浏览器提交由springSecurity处理登录
                .usernameParameter("loginacct")//账号参数
                .passwordParameter("userpswd")//密码参数
                .defaultSuccessUrl("/admin/main.html");//登录成功重定向
        //禁用csrf功能
        http.csrf().disable();

        //3.配置浏览器提交注销请求
        http.logout()
                .logoutUrl("/admin/logout")//修改浏览器地址栏
                .logoutSuccessUrl("/index");//注销之后的重定向
    }
    @Autowired
    UserDetailsService userDetailsService;
    @Autowired
    PasswordEncoder encoder;
    //主体创建
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //super.configure(auth);

        auth.userDetailsService(userDetailsService).passwordEncoder(encoder);
    }
}
