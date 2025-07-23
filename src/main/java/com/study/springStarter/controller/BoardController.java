package com.study.springStarter.controller;

import com.study.springStarter.dto.Board;
import com.study.springStarter.service.BoardService;
import com.study.springStarter.util.PageHandler;
import com.study.springStarter.util.SearchCondition;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService service;

    @GetMapping("/list")
    public String list(SearchCondition sc, HttpSession session, HttpServletRequest req, Model m) {
        // 로그인을 안했으면 로그인 화면으로 이동
        if(!loginCheck(session)) return "redirect:/login1?toURL=" + req.getRequestURL();
        // 로그인을 한 상태이면, 게시판 화면으로 이동
        try {
            int count = service.getSearchResultCnt(sc); // 게시물 수
            PageHandler ph = new PageHandler(count, sc);
            List<Board> list = service.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", ph);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "boardList";
    }

    @GetMapping("/read")
    public String read(SearchCondition sc, Integer bno, Model m, HttpSession session, HttpServletRequest req) {
        if(!loginCheck(session)) return "redirect:/login1?toURL=" + req.getRequestURL();
        if(bno == null) return "redirect:/board/list";

        try {
            Board dto = service.read(bno);
            m.addAttribute("dto", dto);
            m.addAttribute("sc", sc);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "boardRead";
    }

    @GetMapping("/write")
    public String write(HttpSession session, HttpServletRequest req) {
        if(!loginCheck(session)) return "redirect:/login1?toURL=" + req.getRequestURL();
        return "boardWrite";
    }

    @PostMapping("/write")
    public String write(Board dto, HttpSession session, RedirectAttributes reatt) {
        String id = (String) session.getAttribute("id");
        dto.setWriter(id);

        try {
            int res = service.write(dto);
            if(res == 1) {
                reatt.addFlashAttribute("msg", "writeSuc");
                return "redirect:/board/list";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reatt.addFlashAttribute("msg", "writeFail");
        return "redirect:/board/write";
    }

    @GetMapping("/modify")
    public String modify(Integer bno, Model m, HttpSession session, HttpServletRequest req) {
        if(!loginCheck(session)) return "redirect:/login1?toURL=" + req.getRequestURL();
        try {
            Board dto = service.read(bno);
            m.addAttribute("dto", dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "boardModify";
    }

    @PostMapping("/modify")
    public String modify(Board dto, RedirectAttributes reatt) {
        try {
            int res = service.modify(dto);
            if(res == 1) {
                reatt.addFlashAttribute("msg", "updateSuc");
                return "redirect:/board/read?bno=" + dto.getBno();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        reatt.addFlashAttribute("msg", "updateFail");
        return "redirect:/board/modify?bno=" + dto.getBno();
    }

    @PostMapping("/remove")
    public String remove(Integer bno, HttpSession session, RedirectAttributes reatt) {
        String id = (String) session.getAttribute("id");
        try {
            int res = service.remove(bno, id);
            if(res == 1) {
                reatt.addFlashAttribute("msg", "delSuc");
                return "redirect:/board/list";
            }
        } catch (Exception e) {
            e.printStackTrace();
            reatt.addFlashAttribute("msg", "delFail");
        }
        return "redirect:/board/read?bno=" + bno;
    }

    private boolean loginCheck(HttpSession session) {
        return session.getAttribute("id") != null;
    }
}
