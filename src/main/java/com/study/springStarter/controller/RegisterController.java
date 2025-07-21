package com.study.springStarter.controller;

import com.study.springStarter.dao.MemberDao;
import com.study.springStarter.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class RegisterController {
    @Autowired
    MemberDao dao;

    @GetMapping("/register/add")
    public String register() {
        return "register";
    }

    @PostMapping("/register/save")
    public String save(Member member, Model m, RedirectAttributes reatt) throws UnsupportedEncodingException {
        if(!isValid(member)) {
            String msg = URLEncoder.encode("id를 잘못 입력하셨습니다.", "UTF-8");
            m.addAttribute("msg", msg);
            return "redirect:/register/add?msg=" + msg;
        }
        reatt.addFlashAttribute("register", "suc");
        return "redirect:/login1";
    }

    private boolean isValid(Member member) {
        int res = 0;
        try {
            res = dao.insert(member);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return res  == 1;
    }
}
