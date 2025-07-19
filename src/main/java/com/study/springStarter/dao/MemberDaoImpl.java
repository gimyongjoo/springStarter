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

@Repository
public class MemberDaoImpl implements MemberDao {
    @Autowired
    DataSource ds;

    @Override
    public int insert(Member m) {
        Connection con = null;
        PreparedStatement psmt = null;

        String sql = "insert into member(id, pwd, name, email, birth, sns)" +
                " values(?, ?, ?, ?, ?, ?)";

        int res = 0;
        try {
            con = ds.getConnection();
            psmt = con.prepareStatement(sql);
            psmt.setString(1, m.getId());
            psmt.setString(2, m.getPwd());
            psmt.setString(3, m.getName());
            psmt.setString(4, m.getEmail());
            psmt.setDate(5, m.getBirth());
            psmt.setString(6, m.getSns());
            res = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(psmt, con);
        }
        return res;
    }

    @Override
    public int update(Member m) {
        Connection con = null;
        PreparedStatement psmt = null;

        String sql = "update member set pwd = ?, name = ?, email = ?, " +
                "sns = ?, regDate = now() where id = ?";

        int res = 0;
        try {
            con = ds.getConnection();
            psmt = con.prepareStatement(sql);
            psmt.setString(1, m.getPwd());
            psmt.setString(2, m.getName());
            psmt.setString(3, m.getEmail());
            psmt.setString(4, m.getSns());
            psmt.setString(5, m.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(psmt, con);
        }
        return res;
    }

    @Override
    public int delete(String id) {
        Connection con = null;
        PreparedStatement psmt = null;
        String sql = "delete from member where id = ?";

        int res = 0;
        try {
            con = ds.getConnection();
            psmt = con.prepareStatement(sql);
            psmt.setString(1, id);
            res = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(psmt, con);
        }
        return res;
    }

    @Override
    public Member select(String id) {
        Connection con = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        Member m = null;

        String sql = "select * from member where id = ?";
        try {
            con = ds.getConnection();
            psmt = con.prepareStatement(sql);
            psmt.setString(1, id);
            rs = psmt.executeQuery();
            if(rs.next()) {
                m = new Member();
                m.setId(rs.getString(1));
                m.setPwd(rs.getString(2));
                m.setName(rs.getString(3));
                m.setEmail(rs.getString(4));
                m.setBirth(rs.getDate(5));
                m.setSns(rs.getString(6));
                m.setRegDate(rs.getTimestamp(7));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, psmt, con);
        }
        return m;
    }

    @Override
    public ArrayList<Member> selectList() {
        Connection con = null;
        PreparedStatement psmt = null;
        ResultSet rs = null;
        ArrayList<Member> mlist = new ArrayList<>();

        String sql = "select * from member";
        try {
            con = ds.getConnection();
            psmt = con.prepareStatement(sql);
            rs = psmt.executeQuery();
            while(rs.next()) {
                Member m = new Member();
                m.setId(rs.getString(1));
                m.setPwd(rs.getString(2));
                m.setName(rs.getString(3));
                m.setEmail(rs.getString(4));
                m.setBirth(rs.getDate(5));
                m.setSns(rs.getString(6));
                m.setRegDate(rs.getTimestamp(7));
                mlist.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, psmt, con);
        }
        return mlist;
    }

    private void close(AutoCloseable... acs) {
        for(AutoCloseable ac : acs) {
            try {
                if(ac != null) {
                    ac.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
