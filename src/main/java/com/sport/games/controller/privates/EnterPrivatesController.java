package com.sport.games.controller.privates;

import com.sport.games.dao.ActivityMapper;
import com.sport.games.dao.EnterMapper;
import com.sport.games.dao.ItemMapper;
import com.sport.games.dao.MemberMapper;
import com.sport.games.entity.Activity;
import com.sport.games.entity.Enter;
import com.sport.games.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/privates/enter")
public class EnterPrivatesController {

    @Autowired
    private EnterMapper enterMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ItemMapper itemMapper;

    @ResponseBody
    @RequestMapping("/enter-add")
    public String updateMember(HttpServletRequest request, String activityId, String items) {
        String memberId = request.getSession().getAttribute("member_id").toString();
        // 获得已经报名的数据：status > 0, activityId, memberId
        List<Enter> enterList = enterMapper.getEnteredData(activityId, memberId);

        // 将报名的项目以分号为分隔符依次放进itemIdList中
        List<String> itemIdList = Arrays.asList(items.split(";"));

        //限制报名的项目只能是3个
        List<String> addItemList = new ArrayList<>();
        if (CollectionUtils.isEmpty(enterList)) {
            addItemList = new ArrayList<>(itemIdList);
            if (addItemList.size() > 3) {
                return "每届运动会最多报名三个项目";
            }
        } else {
            if (enterList.size() >= 3) {
                return "每届运动会最多报名三个项目";
            }
            //把已报名的项目放在hasEnterItemIdList中
            List<String> hasEnterItemIdList = enterList.stream().map(enter->{return enter.getItemId();}).collect(Collectors.toList());
            for (int i = 0; i < itemIdList.size(); i++) {
                String itemId = itemIdList.get(i);
                if (!hasEnterItemIdList.contains(itemId)) {
                    addItemList.add(itemId);
                }
            }
            if (enterList.size() + addItemList.size() > 3) {
                return "每届运动会最多报名三个项目，已报名" + enterList.size() + "个";
            }
        }
        // 把报名的项目依次存进数据库
        for (int i = 0; i < addItemList.size(); i++) {
            enterMapper.insert(UUID.randomUUID().toString(), memberId, activityId, addItemList.get(i));
        }
        return "SUCCESS";
    }

    @RequestMapping("/enter-list-page")
    public String enterListPage(HttpServletRequest request) {
        // 获得个人所有的报名记录
        String memberId = request.getSession().getAttribute("member_id").toString();
        List<Enter> enterList = enterMapper.getEnterByMemberId(memberId);
        request.setAttribute("enterList", enterList);
        return "member/enter-list-page";
    }

    @ResponseBody
    @RequestMapping("/enter-delete")
    public String enterDelete(String id) {
    	//根据id删除报名的项目
        enterMapper.deleteById(id);
        return "SUCCESS";
    }

    @RequestMapping("/publish-data")
    public String publishData(String activityId, String itemId, HttpServletRequest request) {
        // 获得活动信息
        Activity activity = activityMapper.getById(activityId);
        // 获得项目信息
        List<Item> itemList = itemMapper.getItemByIds(Arrays.asList(itemId));
        // 获得所有的成绩列表，按照排序
        List<Enter> enterList = enterMapper.getByActivityIdAndItemId(activityId, itemId, itemList.get(0).getRank());

        request.setAttribute("activity", activity);
        request.setAttribute("item", itemList.get(0));
        request.setAttribute("enterList", enterList);
        return "member/publish-data";
    }

}
