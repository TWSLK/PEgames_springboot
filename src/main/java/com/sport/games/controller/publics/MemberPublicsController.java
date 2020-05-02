package com.sport.games.controller.publics;

import com.sport.games.dao.ActivityMapper;
import com.sport.games.dao.EnterMapper;
import com.sport.games.dao.ItemMapper;
import com.sport.games.dao.MemberMapper;
import com.sport.games.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/publics/member")
public class MemberPublicsController {

    @Autowired
    private MemberMapper memberMapper;

    @RequestMapping("/member-list-page")
    public String loginPage(HttpServletRequest request){
        List<Member> memberList = memberMapper.getAllMember();
        request.setAttribute("memberList", memberList);
        return "admin/member-list-page";
    }

    @ResponseBody
    @RequestMapping("/member-update-status")
    public String memberUpdateStatus(String id, Integer status) {
        memberMapper.updateStatus(id, status);
        return "SUCCESS";
    }

    @ResponseBody
    @RequestMapping("/member-add")
    public String memberAdd(String name, String account, String password, String phone) {
        // 判断account是否已经存在
        Member m = memberMapper.getByAccount(account);
        if (m != null) {
            return "账号已存在，请重新确认";
        }

        Member member = new Member();
        member.setId(UUID.randomUUID().toString());
        member.setName(name);
        member.setAccount(account);
        member.setPassword(password);
        member.setPhone(phone);

        memberMapper.insert(member);
        return "SUCCESS";
    }

}
