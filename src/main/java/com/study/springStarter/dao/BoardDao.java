package com.study.springStarter.dao;

import com.study.springStarter.dto.Board;
import com.study.springStarter.util.SearchCondition;

import java.util.List;

public interface BoardDao {

    int count() throws Exception;

    Board select(int bno) throws Exception;

    List<Board> selectAll() throws Exception;

    int insert(Board dto) throws Exception;

    int update(Board dto) throws Exception;

    int delete(Integer bno, String writer) throws Exception;

    int updateViewCnt(int bno) throws Exception;

    int deleteAll() throws Exception;

    List<Board> selectPage(Integer offset, Integer pageSize) throws Exception;

    List<Board> searchSelectPage(SearchCondition sc) throws Exception;

    int searchResultCnt(SearchCondition sc) throws Exception;
}
