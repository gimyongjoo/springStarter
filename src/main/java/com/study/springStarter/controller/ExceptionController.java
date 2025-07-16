package com.study.springStarter.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
public class ExceptionController {
    @RequestMapping("/ex")
    public String main() throws Exception { // "/ex" -> catcher()
        throw new Exception("예외가 발생했습니다.");
    }

//    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) // status code : 200 => 500 변경
    @ExceptionHandler(Exception.class)
    public String catcher(Exception ex, Model m) { // ex -> 현재 발생한 예외정보
//        m.addAttribute("ex", ex);
        return "error";
    }

    @RequestMapping("/ex4")
    public String main2() throws Exception { // "/ex" -> catcher()
        throw new Exception("예외가 발생했습니다.");
    }
}
