package com.study.springStarter.controller;

import com.study.springStarter.dao.MemberDao;
import com.study.springStarter.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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

    @GetMapping("/update")
    public String update(Member member, Model m) {
        member = dao.select(member.getId());
        m.addAttribute("member", member);

        return "update";
    }

    @PostMapping("/update")
    public String update(Member m) {
        if(m.getId() == null || m.getId().isEmpty()) {
            return "redirect:/list";
        }
        int res = dao.update(m);
        return "redirect:/list";
    }

    @GetMapping("/delete")
    public String delete(String id) {
        dao.delete(id);
        return "redirect:/list";
    }

}
