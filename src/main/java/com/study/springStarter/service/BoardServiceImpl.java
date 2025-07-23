package com.study.springStarter.service;

import com.study.springStarter.dao.BoardDao;
import com.study.springStarter.dto.Board;
import com.study.springStarter.util.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    BoardDao dao;

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return dao.searchResultCnt(sc);
    }

    @Override
    public List<Board> getSearchResultPage(SearchCondition sc) throws Exception {
        return dao.searchSelectPage(sc);
    }

    @Override
    public int getCount() throws Exception {
        return dao.count();
    }

    @Override
    public int remove(Integer bno, String writer) throws Exception {
        return dao.delete(bno, writer);
    }

    @Override
    public int write(Board board) throws Exception {
        return dao.insert(board);
    }

    @Override
    public List<Board> getList() throws Exception {
        return dao.selectAll();
    }

    // 게시판 읽기 => 조회수 1 증가 + 게시판 조회
    @Override
    public Board read(Integer bno) throws Exception {
        int res = dao.updateViewCnt(bno);
        if(res == 1) {
            return dao.select(bno);
        }
        return null;
    }

    @Override
    public List<Board> getPage(Integer offset, Integer pageSize) throws Exception {
        return dao.selectPage(offset, pageSize);
    }

    // 게시물 수정
    @Override
    public int modify(Board board) throws Exception {
        return dao.update(board);
    }
}
