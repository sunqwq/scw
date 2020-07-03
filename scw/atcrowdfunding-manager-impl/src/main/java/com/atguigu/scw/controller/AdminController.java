package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.AdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequestMapping("/admin")
@Controller
public class AdminController {


    @Autowired
    AdminService adminService;

    //批量删除管理员
    @GetMapping("/bathDelAdmins")
    public String bathDelAdmins(@RequestParam("ids") List<Integer> ids){
//        System.out.println("ids = " + ids);
        adminService.bathDelAdmins(ids);
        return "redirect:/admin/index";
    }

    //更新管理员数据的方法
    @PostMapping("/updateAdmin")
    public String updateAdmin(TAdmin admin,HttpSession session){
        adminService.updateAdmin(admin);
        String ref = (String) session.getAttribute("ref");
        return "redirect:"+ref;
    }


    //跳转更新页面
    @GetMapping("/toEditPage")
    public String toEditPage(HttpSession session, @RequestHeader("referer")String referer, Model model, Integer id){
        //存储更新之前的页面地址
        session.setAttribute("ref", referer);
        //获取要修改的管理员数据
        TAdmin admin = adminService.getAdmin(id);
        //存放在reques域中共享
        model.addAttribute("admin",admin);
        return "admin/edit";
    }

    //新增管理员
    @PostMapping("/addAdmin")
    public String addAdmin(Model model, TAdmin tAdmin, HttpSession session){
        try {
            adminService.addAdmin(tAdmin);
            Integer pages = (Integer) session.getAttribute("pages");
            return "redirect://admin/index?pageNum="+(pages+1);
        } catch (Exception e) {
            e.printStackTrace();
            //将异常信息设置到域中
            //转发到新增页面进行错误提示
            model.addAttribute("errorMsg" , e.getMessage());
            return "admin/add";
        }
    }

    //跳转到新增页面
    @GetMapping("/add.html")
    public String toAdd(){
        return "admin/add";
    }

    //删除指定管理员
    @GetMapping("/deleteAdmin")
    public String deleteAdmin(Integer id){
        adminService.deleteAdmin(id);

        return "redirect:/admin/index";
    }

    //3.查询管理员列表方法
    @GetMapping("/index")
    public String getAdmins(HttpSession session,String condition,Model model,@RequestParam(defaultValue = "1",required = false) Integer pageNum){

        PageHelper.startPage(pageNum,2);

        //查询管理员列表
        List<TAdmin> admins = adminService.getAdmins(condition);
        PageInfo info = new PageInfo<>(admins, 2);
        System.out.println("info = " + info);
        //新增管理员完成后需要使用总页码
        int pages = info.getPages();//总页码
        session.setAttribute("pages" , pages);

        model.addAttribute("info",info);

        return "admin/user";
    }


/*    @PostMapping("/login")
    public String doLogin(Model model,HttpSession session, String loginacct, String userpswd){
        TAdmin admin = adminService.doLogin(loginacct,userpswd);
        String digest = MD5Util.digest("123456");
        System.out.println("digest = " + digest);
        System.out.println(admin);
        if(admin==null){
            model.addAttribute("errorMsg","账号或密码错误");
            return "login";
        }

        session.setAttribute("admin",admin);

        return "redirect:/admin/main.html";
    }*/

    //注销
    /*@GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/index";
    }*/

    @GetMapping("/main.html")
    public String toMainPage(HttpSession session){
        //查询菜单集合
        //直接查询所有的菜单
        //在代码中将菜单分为父菜单集合，并将该父菜单的子菜单集合作为父菜单对象的属性绑定
        List<TMenu> pmenus = adminService.getPMenus();
//        System.out.println("pmenus = " + pmenus);
        //存放在request域中
        session.setAttribute("pmenus",pmenus);
        return "admin/main";
    }
}
