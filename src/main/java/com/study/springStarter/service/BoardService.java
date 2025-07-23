package com.study.springStarter.service;

import com.study.springStarter.dto.Board;
import com.study.springStarter.util.SearchCondition;

import java.util.List;

public interface BoardService {

    int getCount() throws Exception;

    int remove(Integer bno, String writer) throws Exception;

    public int write(Board board) throws Exception;

    List<Board> getList() throws Exception;

    // 게시판 읽기 => 조회수 1 증가 + 게시판 조회
    Board read(Integer bno) throws Exception;

    List<Board> getPage(Integer offset, Integer pageSize) throws Exception;

    // 게시물 수정
    int modify(Board board) throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<Board> getSearchResultPage(SearchCondition sc) throws Exception;
}
