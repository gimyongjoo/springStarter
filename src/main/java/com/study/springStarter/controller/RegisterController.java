package com.study.springStarter.controller;

import com.study.springStarter.dto.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
public class RegisterController {
    @GetMapping("/register/add")
    public String register() {
        return "register";
    }
    @PostMapping("/register/save")
    public String save(User user, Model m) throws UnsupportedEncodingException {
        if(!isValid(user)) {
            String msg = URLEncoder.encode("id를 잘못 입력하셨습니다.", "UTF-8");
            m.addAttribute("msg", msg);
            return "redirect:/register/add?msg=" + msg;
        }
        return "registerInfo";
    }

    private boolean isValid(User user) {
        return true;
    }
}
