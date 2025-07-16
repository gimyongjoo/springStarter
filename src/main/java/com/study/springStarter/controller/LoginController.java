package com.study.springStarter.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
    @GetMapping("/login1")
    public String login() {
        return "login";
    }

    @PostMapping("/login1")
    public String login(String id, String pwd, String toURL, boolean rememberId, HttpServletResponse resp, HttpServletRequest req) {
        toURL = "".equals(toURL) || toURL == null ? "/" : toURL;
        if(!isValid(id, pwd)) {
            return "redirect:/login";
        }
        if(rememberId) {
            Cookie cookie = new Cookie("id", id);
            resp.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("id", "");
            cookie.setMaxAge(0);
            resp.addCookie(cookie);
        }

        System.out.println(id);
        System.out.println(pwd);
        System.out.println(rememberId);

        HttpSession session = req.getSession();
        session.setAttribute("id", id);
        return "redirect:" + toURL;
    }

    private boolean isValid(String id, String pwd) {
        return "asdf".equals(id) && "1234".equals(pwd);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
