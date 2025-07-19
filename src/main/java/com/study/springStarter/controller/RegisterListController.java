package com.study.springStarter.controller;

import com.study.springStarter.dao.MemberDao;
import com.study.springStarter.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;

@Controller
public class RegisterListController {
    @Autowired
    MemberDao dao;

    @GetMapping("/list")
    public String list(Model m) {
        ArrayList<Member> mlist = dao.selectList();
        m.addAttribute("mlist", mlist);
        return "registerList";
    }
}
