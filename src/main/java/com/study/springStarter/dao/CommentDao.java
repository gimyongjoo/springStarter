package com.study.springStarter.dao;

import com.study.springStarter.dto.Comment;

import java.util.List;

public interface CommentDao {

    int insert(Comment dto) throws Exception;

    int update(Comment dto) throws Exception;

    List<Comment> selectAll(Integer bno) throws Exception;

    Comment select(Integer cno) throws Exception;

    int delete(Integer cno, String commenter) throws Exception;

    int deleteAll(Integer bno) throws Exception;

    int count(Integer bno) throws Exception;

}
