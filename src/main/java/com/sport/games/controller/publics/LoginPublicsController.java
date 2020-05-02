package com.sport.games.controller.publics;

import com.sport.games.dao.AdminMapper;
import com.sport.games.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping("/publics/login")
public class LoginPublicsController {

    @Autowired
    private AdminMapper adminMapper;

    @RequestMapping("/login-page")
    public String loginPage(HttpServletRequest request){
        String loginInfo = request.getParameter("loginInfo");
        if (!StringUtils.isEmpty(loginInfo)) {
            request.setAttribute("loginInfo", loginInfo);
        }
        return "admin/login-page";
    }

    @RequestMapping("/login-check")
    public String loginCheck(HttpServletRequest request, @RequestParam("account") String account, @RequestParam("password") String password) throws UnsupportedEncodingException {
        String retInfo = "";
        // 根据用户名获得用户信息
        Admin admin = adminMapper.getByAccount(account);
        if (admin != null && password.equals(admin.getPassword())) {
            // 登录成功跳转到首页面
            request.getSession().setAttribute("admin_id", admin.getId());
            return "redirect:/publics/main/main-page";
        } else {
            retInfo = "用户名或密码不正确，请重新输入";
            return "redirect:/publics/login/login-page?loginInfo=" + URLEncoder.encode(retInfo,"UTF-8");
        }
    }

}
