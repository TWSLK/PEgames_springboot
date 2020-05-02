package com.sport.games.dao;

import com.sport.games.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminMapper {

	//根据账户信息查询用户
    Admin getByAccount(@Param("account") String account);

    //根据id查询用户
    Admin getById(@Param("id") String adminId);
}
