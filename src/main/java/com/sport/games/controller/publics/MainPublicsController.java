package com.sport.games.controller.publics;

import com.sport.games.dao.AdminMapper;
import com.sport.games.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/publics/main")
public class MainPublicsController {

    @Autowired
    private AdminMapper adminMapper;

    @RequestMapping("/main-page")
    public String loginPage(HttpServletRequest request){
        String adminId = (String) request.getSession().getAttribute("admin_id");
        Admin admin = adminMapper.getById(adminId);
        request.setAttribute("admin", admin);
        return "admin/main-page";
    }

    @ResponseBody
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.removeAttribute("admin_id");
        return "SUCCESS";
    }

}
