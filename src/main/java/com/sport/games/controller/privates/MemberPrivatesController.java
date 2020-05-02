package com.sport.games.controller.privates;

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
@RequestMapping("/privates/member")
public class MemberPrivatesController {

    @Autowired
    private MemberMapper memberMapper;

    //更新用户的信息
    @ResponseBody
    @RequestMapping("/update-member")
    public String updateMember(String account, String name, String password, String phone) {
        memberMapper.updateMember(account, name, password, phone);
        return "SUCCESS";
    }

}
