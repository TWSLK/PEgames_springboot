package com.sport.games.dao;

import com.sport.games.entity.Enter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EnterMapper {

	//查询没有检查的报名
    List<Enter> getNotCheckEnter();

    //根据活动id查参加的项目
    List<Enter> getByActivityId(String id);

    //更新
    void updateStatus(@Param("id") String id,
                      @Param("status") Integer status);

    //查询检查过得项目
    List<Enter> getCheckedEnter();

    //更新结果
    void updateResult(@Param("id") String id,
                      @Param("result") String result);

    Integer getResultCount(@Param("activityId") String activityId,
                           @Param("itemId") String itemId);

    List<Enter> getByActivityIdAndItemId(@Param("activityId") String activityId,
                                         @Param("itemId") String itemId,
                                         @Param("rank") Integer rank);

    void updateRank(@Param("id") String id, @Param("rank") int rank);

    List<Enter> getEnteredData(@Param("activityId") String activityId, @Param("memberId") String memberId);

    void insert(@Param("id") String id,
                @Param("memberId") String memberId,
                @Param("activityId") String activityId,
                @Param("itemId") String itemId);

    List<Enter> getEnterByMemberId(@Param("memberId") String memberId);

    //根据id删除报名的项目
    void deleteById(@Param("id") String id);
}
