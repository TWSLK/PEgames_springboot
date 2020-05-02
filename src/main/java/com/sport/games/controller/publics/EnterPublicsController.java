package com.sport.games.controller.publics;

import com.alibaba.fastjson.JSONObject;
import com.sport.games.dao.ActivityMapper;
import com.sport.games.dao.EnterMapper;
import com.sport.games.dao.ItemMapper;
import com.sport.games.dto.ActivityItemDTO;
import com.sport.games.entity.Activity;
import com.sport.games.entity.Enter;
import com.sport.games.entity.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/publics/enter")
public class EnterPublicsController {

    @Autowired
    private EnterMapper enterMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ItemMapper itemMapper;

    @RequestMapping("/enter-list-page")
    public String enterListPage(HttpServletRequest request) {
        List<Enter> enterList = enterMapper.getNotCheckEnter();
        request.setAttribute("enterList", enterList);
        return "admin/enter-list-page";
    }

    @ResponseBody
    @RequestMapping("/enter-update-status")
    public String enterUpdateStatus(String id, Integer status) {
        enterMapper.updateStatus(id, status);
        return "SUCCESS";
    }

    @RequestMapping("/result-list-page")
    public String resultListPage(HttpServletRequest request) {
        List<Enter> enterList = enterMapper.getCheckedEnter();
        request.setAttribute("enterList", enterList);
        return "admin/result-list-page";
    }

    @ResponseBody
    @RequestMapping("/enter-update-result")
    public String enterUpdateResult(String id, String result) {
        enterMapper.updateResult(id, result);
        return "SUCCESS";
    }

    @RequestMapping("/publish-list-page")
    public String publishListPage(HttpServletRequest request) {
        // 获得所有的活动，按照创建时间倒序
        List<Activity> activityList = activityMapper.getAllActivity();
        // 按照项目，拆分成多条
        List<ActivityItemDTO> activityItemList = new ArrayList<>();
        if (!CollectionUtils.isEmpty(activityList)) {
            for (Activity activity : activityList) {
                List<Item> itemList = JSONObject.parseArray(activity.getItemJson(), Item.class);
                for (Item item : itemList) {
                    ActivityItemDTO activityItemDTO = new ActivityItemDTO();
                    activityItemDTO.setActivityId(activity.getId());
                    activityItemDTO.setActivityName(activity.getName());
                    activityItemDTO.setItemId(item.getId());
                    activityItemDTO.setItemName(item.getName());
                    // 获得已有成绩的人数
                    Integer count = enterMapper.getResultCount(activity.getId(), item.getId());
                    activityItemDTO.setCount(count == null ? 0 : count);

                    activityItemList.add(activityItemDTO);
                }
            }
        }
        request.setAttribute("activityItemList", activityItemList);
        return "admin/publish-list-page";
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
        return "admin/publish-data";
    }

    @ResponseBody
    @RequestMapping("/rank")
    public String rank(String activityId, String itemId, Integer rank) {
        List<Enter> enterList = enterMapper.getByActivityIdAndItemId(activityId, itemId, rank);
        if (!CollectionUtils.isEmpty(enterList)) {
            for (int i = 0; i < enterList.size(); i++) {
                Enter enter = enterList.get(i);
                enterMapper.updateRank(enter.getId(), i+1);
            }
        }
        return "SUCCESS";
    }

}
