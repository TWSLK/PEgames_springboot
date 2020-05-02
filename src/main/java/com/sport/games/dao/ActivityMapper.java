package com.sport.games.dao;

import com.sport.games.entity.Activity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ActivityMapper {

	//获取所有项目
    List<Activity> getAllActivity();

    //增加项目
    void save(Activity activity);

    //删除项目
    void delete(String id);

    //根据id查询项目
    Activity getById(String id);

    //跟新数据
    void updateData(@Param("id") String id, @Param("data") String data);

    //查询正在进行的活动
    List<Activity> getOngoingActivity();

    //查询历史活动
    List<Activity> getHistoryActivity();

}
