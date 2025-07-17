package com.study.springStarter.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board")
public class BoardController {
    @GetMapping("/list")
    public String list(HttpSession session, HttpServletRequest req, RedirectAttributes reatt) {
        if(session.getAttribute("id") == null || ((String)session.getAttribute("id")).isEmpty()) {
            reatt.addFlashAttribute("msg", "loginErr"); // addFlashAttribute 는 한 번만 허용
            reatt.addAttribute("toURL", req.getRequestURL());
            // reatt.addAttribute("key", value); ?key=value 쿼리스트링으로 전달
            return "redirect:/login1";
        }
        return "boardList";
    }
}
