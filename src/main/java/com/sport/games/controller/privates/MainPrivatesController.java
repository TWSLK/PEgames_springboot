package com.sport.games.controller.privates;

import com.sport.games.dao.AdminMapper;
import com.sport.games.dao.MemberMapper;
import com.sport.games.entity.Admin;
import com.sport.games.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/privates/main")
public class MainPrivatesController {

    @Autowired
    private MemberMapper memberMapper;

    //获取登录的用户信息
    @RequestMapping("/main-page")
    public String loginPage(HttpServletRequest request){
        String memberId = (String) request.getSession().getAttribute("member_id");
        Member member = memberMapper.getById(memberId);
        request.setAttribute("member", member);
        return "member/main-page";
    }

    //注销
    @ResponseBody
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession(true);
        session.removeAttribute("member_id");
        return "SUCCESS";
    }

}
