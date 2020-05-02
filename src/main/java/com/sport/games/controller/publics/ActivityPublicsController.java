package com.sport.games.controller.publics;

import com.alibaba.fastjson.JSONObject;
import com.sport.games.dao.ActivityMapper;
import com.sport.games.dao.AdminMapper;
import com.sport.games.dao.EnterMapper;
import com.sport.games.dao.ItemMapper;
import com.sport.games.entity.Activity;
import com.sport.games.entity.Admin;
import com.sport.games.entity.Enter;
import com.sport.games.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/publics/activity")
public class ActivityPublicsController {

    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private EnterMapper enterMapper;
    @Autowired
    private ItemMapper itemMapper;


    @RequestMapping("/activity-list-page")
    public String loginPage(HttpServletRequest request){
        List<Activity> activityList = activityMapper.getAllActivity();
        if (!CollectionUtils.isEmpty(activityList)) {
            activityList = activityList.stream().map(this::initActivity).collect(Collectors.toList());
        }
        request.setAttribute("activityList", activityList);
        // 获得所有的项目
        List<Item> itemList = itemMapper.getAllItem();
        request.setAttribute("itemList", itemList);
        return "admin/activity-list-page";
    }

    @ResponseBody
    @RequestMapping("/activity-delete")
    public String loginPage(String id){
        // 判断是否有报名，有则不能删除
        List<Enter> enterList = enterMapper.getByActivityId(id);
        if (CollectionUtils.isEmpty(enterList)) {
            activityMapper.delete(id);
            return "SUCCESS";
        } else {
            return "已存在报名，不可删除";
        }
    }

    @RequestMapping("/activity-data")
    public String activityData(HttpServletRequest request, String id) {
        Activity activity = activityMapper.getById(id);
        request.setAttribute("activityName", activity.getName());
        request.setAttribute("activityId", activity.getId());
        request.setAttribute("activityData", activity.getData());
        return "admin/activity-data";
    }

    @ResponseBody
    @RequestMapping("/activity-data-save")
    public String activityDataSave(String id, String data) {
        activityMapper.updateData(id, data);
        return "SUCCESS";
    }

    @ResponseBody
    @RequestMapping("/activity-add")
    public String activityAdd(String name, String startTime, String endTime, String items) throws ParseException {
        // 根据items获得所有的项目，生成json
        List<Item> itemList = itemMapper.getItemByIds(Arrays.asList(items.split(";")));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Activity activity = new Activity();
        activity.setId(UUID.randomUUID().toString());
        activity.setName(name);
        activity.setStartTime(sdf.parse(startTime));
        activity.setEndTime(sdf.parse(endTime));
        activity.setItemJson(JSONObject.toJSONString(itemList));

        activityMapper.save(activity);
        return "SUCCESS";
    }

    private Activity initActivity(Activity activity) {
        String status = "进行中";
        if (activity.getStartTime().after(new Date())) {
            status = "未开始";
        }
        if (activity.getEndTime().before(new Date())) {
            status = "已结束";
        }
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

}
