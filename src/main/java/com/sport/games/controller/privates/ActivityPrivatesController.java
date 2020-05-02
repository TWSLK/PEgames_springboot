package com.sport.games.controller.privates;

import com.alibaba.fastjson.JSONObject;
import com.sport.games.dao.ActivityMapper;
import com.sport.games.dao.EnterMapper;
import com.sport.games.dao.ItemMapper;
import com.sport.games.entity.Activity;
import com.sport.games.entity.Enter;
import com.sport.games.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/privates/activity")
public class ActivityPrivatesController {

	//定义activityMapper，用于使用ActivityMapper中的增删改查方法
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private EnterMapper enterMapper;
    @Autowired
    private ItemMapper itemMapper;

    //匹配地址是/activity-list-page，执行下面的方法
    @RequestMapping("/activity-list-page")
    public String loginPage(HttpServletRequest request){
        // 获得所有没结束的活动，用于报名
        List<Activity> activityList = activityMapper.getOngoingActivity();
        //查询出来的活动列表不为空，就把查询出来的列表放进activityList
        if (!CollectionUtils.isEmpty(activityList)) {
            activityList = activityList.stream().map(this::initActivity).collect(Collectors.toList());
        }
        //将activityList的值放在activityList属性中
        request.setAttribute("activityList", activityList);
        //返回activity-list-page页面
        return "member/activity-list-page";
    }

    @RequestMapping("/activity-data")
    public String activityData(HttpServletRequest request, String id) {
        Activity activity = activityMapper.getById(id);
        request.setAttribute("activity", activity);
        // 获得可报名项目
        if (StringUtils.isEmpty(activity.getItemJson())) {
            request.setAttribute("itemList", Collections.EMPTY_LIST);
        } else {
            List<Item> itemList = JSONObject.parseArray(activity.getItemJson(), Item.class);
            request.setAttribute("itemList", itemList);
        }
        // 判断是否可报名
        boolean endBln = activity.getEndTime().before(new Date());
        request.setAttribute("endBln", endBln);
        return "member/activity-data";
    }

    //活动的状态信息
    private Activity initActivity(Activity activity) {
        String status = "进行中";
        //判断活动的开始时间是否在当下时间的之后，在他之后，活动的状态是未开始
        if (activity.getStartTime().after(new Date())) {
            status = "未开始";
        }
      //判断活动的开始时间是否在当下时间的之前，在他之前，活动的状态是已结束
        if (activity.getEndTime().before(new Date())) {
            status = "已结束";
        }
        //设置活动的状态信息
        activity.setStatus(status);

        // 设置项目字符串
        StringBuilder itemStr = new StringBuilder();
        if (!StringUtils.isEmpty(activity.getItemJson())) {
            List<Item> itemList = JSONObject.parseArray(activity.getItemJson(), Item.class);
            if (!CollectionUtils.isEmpty(itemList)) {
                itemList.stream().forEach(item -> {
                    itemStr.append(item.getName()).append(";");
                });
            }
        }
        activity.setItems(itemStr.toString());
        return activity;
    }

    @RequestMapping("/activity-history-list-page")
    public String activityHistoryListPage(HttpServletRequest request) {
        // 获得所有没结束的活动，用于报名
        List<Activity> activityList = activityMapper.getHistoryActivity();
        if (!CollectionUtils.isEmpty(activityList)) {
            activityList = activityList.stream().map(this::initActivity).collect(Collectors.toList());
        }
        request.setAttribute("activityList", activityList);
        return "member/activity-list-page";
    }

}
