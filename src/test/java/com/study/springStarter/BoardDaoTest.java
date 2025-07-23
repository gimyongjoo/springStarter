//package com.study.springStarter;
//
//
//import com.study.springStarter.dao.BoardDao;
//import com.study.springStarter.dto.Board;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.transaction.annotation.Transactional;
//
//import static org.junit.jupiter.api.Assertions.assertTrue;
//
//@SpringBootTest
////@Transactional
//@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
//public class BoardDaoTest {
//
//    @Autowired
//    BoardDao dao;
//
//    @Test
//    public void insertTest() throws Exception {
//        for(int i=0; i<=500; i++) {
//            Board dto = new Board("no title" + i, "no content" + i, "asdf");
//            assertTrue(dao.insert(dto) == 1);
//        }
//    }
//}
