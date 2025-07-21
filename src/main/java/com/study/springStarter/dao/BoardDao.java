package com.study.springStarter.dao;

import com.study.springStarter.dto.Board;

import java.util.List;

public interface BoardDao {

    int count() throws Exception;

    BoardDao select(int bno) throws Exception;

    List<BoardDao> selectAll() throws Exception;

    int insert(Board dto) throws Exception;

    int update(Board dto) throws Exception;

    int delete(Board dto) throws Exception;

    int updateViewCnt(int bno) throws Exception;

    int deleteAll() throws Exception;
}
