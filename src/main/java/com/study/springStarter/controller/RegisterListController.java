package com.study.springStarter.controller;

import com.study.springStarter.dao.MemberDao;
import com.study.springStarter.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class RegisterListController {
    @Autowired
    MemberDao dao;

    @GetMapping("/list")
    public String list(Model m) {
        List<Member> mlist = null;
        try {
            mlist = dao.selectList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        System.out.println(mlist);
        m.addAttribute("mlist", mlist);
        return "registerList";
    }

    @GetMapping("/update")
    public String update(Member member, Model m) {
        try {
            member = dao.select(member.getId());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        m.addAttribute("member", member);

        return "update";
    }

    @PostMapping("/update")
    public String update(Member m) {
        if(m.getId() == null || m.getId().isEmpty()) {
            return "redirect:/list";
        }
        try {
            int res = dao.update(m);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/list";
    }

    @GetMapping("/delete")
    public String delete(String id) {
        try {
            dao.delete(id);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/list";
    }

}
