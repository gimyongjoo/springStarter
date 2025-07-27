package com.study.springStarter.service;

import com.study.springStarter.dto.Comment;

import java.util.List;

public interface CommentService {

    int getCount(Integer bno) throws Exception;

    // 삭제되면 댓글 삭제 + 댓글 개수 -1 감소해야 하므로 (boardDao => updateCommentCnt 호출 필요)
    int remove(Integer cno, Integer bno, String commenter) throws Exception;

    // 등록되면 댓글 등록 + 댓글 개수 +1 증가해야 하므로 (boardDao => updateCommentCnt 호출 필요)
    int write(Comment dto) throws Exception;

    List<Comment> getList(Integer bno) throws Exception;

    Comment read(Integer cno) throws Exception;

    int modify(Comment dto) throws Exception;

}
