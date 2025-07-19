package com.study.springStarter.dao;

import com.study.springStarter.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public interface MemberDao {
    int insert(Member m);

    int update(Member m);

    int delete(String id);

    Member select(String id);

    ArrayList<Member> selectList();
}

