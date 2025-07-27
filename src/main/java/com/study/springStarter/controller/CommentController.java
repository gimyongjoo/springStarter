package com.study.springStarter.controller;

import com.study.springStarter.dto.Comment;
import com.study.springStarter.service.CommentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class CommentController {
    @Autowired
    CommentService service;

    @GetMapping("/comment")
    public String test() {
        return "comment";
    }

    // 지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/boards/{bno}/comments")
    @ResponseBody
    public ResponseEntity<List<Comment>> list(@PathVariable Integer bno) {
        List<Comment> list = null;
        try {
            list = service.getList(bno);
            // 에러가 발생되어도 상태코드 200번대
            return new ResponseEntity<List<Comment>>(list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("catch 블록");
            return new ResponseEntity<List<Comment>>(list, HttpStatus.BAD_REQUEST);
        }
    }

    // 댓글을 등록하는 메서드
    @ResponseBody
    @PostMapping("/boards/{bno}/comments")
    public ResponseEntity<String> write(@RequestBody Comment dto, @PathVariable Integer bno, HttpSession session) {
        String commenter = (String) session.getAttribute("id");
        dto.setCommenter(commenter);
        dto.setBno(bno);

        try {
            int cnt = service.write(dto);
            if(cnt != 1) {
                throw new Exception("Write Error");
            }
            return new ResponseEntity<String>("WRITE_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRITE_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 댓글을 수정하는 메서드
    @ResponseBody
    @PatchMapping("/comments/{cno}")
    public ResponseEntity<String> write( @PathVariable Integer cno, @RequestBody Comment dto, HttpSession session) {
        String commenter = (String) session.getAttribute("id");
        dto.setCommenter(commenter);
        dto.setCno(cno);

        try {
            int res = service.modify(dto);
            if(res != 1) {
                throw new Exception("Modify Error");
            }
            return new ResponseEntity<String>("MODIFY_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MODIFY_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 댓글을 삭제하는 메서드
    @ResponseBody
    @DeleteMapping("/boards/{bno}/comments/{cno}") // comments/1?bno=500 <- 삭제 할 댓글 번호
    public ResponseEntity<String> remove(@PathVariable Integer cno, @PathVariable Integer bno, HttpSession session) {
        String commenter = (String) session.getAttribute("id");
        try {
            int rowCnt = service.remove(cno, bno, commenter);
            if(rowCnt != 1) {
                throw new Exception("delete failed");
            }
            return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }
}
