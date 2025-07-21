//package com.study.springStarter;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//import javax.sql.DataSource;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//@Component
//public class DBConnectionTest implements CommandLineRunner {
//
//    @Autowired
//    DataSource dataSource;
//
//    @Override
//    public void run(String... args) throws Exception {
//        try (Connection conn = dataSource.getConnection()) {
//            String sql = "SELECT NOW()";
//            PreparedStatement psmt = conn.prepareStatement(sql);
//            ResultSet rs = psmt.executeQuery();
//
//            if (rs.next()) {
//                System.out.println("현재 시간: " + rs.getString(1));
//            }
//
//            System.out.println("연결 성공: " + conn);
//        }
//    }
//}