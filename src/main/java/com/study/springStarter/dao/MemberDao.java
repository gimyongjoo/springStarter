package com.study.springStarter.dao;

import com.study.springStarter.dto.Member;

import java.util.List;

public interface MemberDao {
    int insert(Member m) throws Exception;

    int update(Member m) throws Exception;

    int delete(String id) throws Exception;

    Member select(String id) throws Exception;

    List<Member> selectList() throws Exception;

    public int deleteAll() throws Exception;
}

