package com.sport.games.dao;

import com.sport.games.entity.Item;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ItemMapper {

	//获取所有项目
    List<Item> getAllItem();

    //根据多个id查询项目
    List<Item> getItemByIds(@Param("idList") List<String> idList);
}
