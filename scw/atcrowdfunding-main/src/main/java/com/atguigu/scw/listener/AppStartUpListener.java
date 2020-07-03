package com.atguigu.scw.listener;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AppStartUpListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("项目启动了");
        servletContextEvent.getServletContext().setAttribute("PATH",
                servletContextEvent.getServletContext().getContextPath());
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
