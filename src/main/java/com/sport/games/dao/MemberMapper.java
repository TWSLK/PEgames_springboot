package com.sport.games.dao;

import com.sport.games.entity.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberMapper {
	//根据用户信息查询账户
    Member getByAccount(String account);

    //插入用户
    void insert(Member member);

    //获取所有用户列表
    List<Member> getAllMember();

    //更新状态
    void updateStatus(@Param("id") String id, @Param("status") Integer status);

    //根据id查用户
    Member getById(@Param("id") String id);

    //更新用户信息
    void updateMember(@Param("account") String account,
                      @Param("name") String name,
                      @Param("password") String password,
                      @Param("phone") String phone);
}
