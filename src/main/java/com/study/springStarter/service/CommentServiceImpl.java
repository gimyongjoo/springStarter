package com.study.springStarter.service;

import com.study.springStarter.dao.BoardDao;
import com.study.springStarter.dao.CommentDao;
import com.study.springStarter.dto.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    private CommentDao commentDao;
    private BoardDao boardDao;

    @Autowired
    public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao) {
        this.commentDao = commentDao;
        this.boardDao = boardDao;
    }

    @Override
    public int getCount(Integer bno) throws Exception {
        return commentDao.count(bno);
    }
    // 삭제되면 댓글 삭제 + 댓글 개수 -1 감소해야 하므로 (boardDao => updateCommentCnt 호출 필요)
    @Override
    public int remove(Integer cno, Integer bno, String commenter) throws Exception {
        int res = commentDao.delete(cno, commenter);
        if(res == 1) {
            boardDao.updateCommentCnt(bno, -1);
        }
        return res;
    }
    // 등록되면 댓글 등록 + 댓글 개수 +1 증가해야 하므로 (boardDao => updateCommentCnt 호출 필요)
    @Override
    public int write(Comment dto) throws Exception {
        int res = commentDao.insert(dto);
        if(res == 1) {
            boardDao.updateCommentCnt(dto.getBno(), +1);
        }
        return res;
    }

    @Override
    public List<Comment> getList(Integer bno) throws Exception {
        return commentDao.selectAll(bno);
    }

    @Override
    public Comment read(Integer cno) throws Exception {
        return commentDao.select(cno);
    }

    @Override
    public int modify(Comment dto) throws Exception {
        return commentDao.update(dto);
    }
}
