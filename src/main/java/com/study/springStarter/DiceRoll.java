package com.study.springStarter;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DiceRoll {
    @RequestMapping("/rollDiceMVC")
    public String main(Model m) {
        int res1 = (int)(Math.random()*6)+1;
        int res2 = (int)(Math.random()*6)+1;

        m.addAttribute("res1", res1);
        m.addAttribute("res2", res2);

        return "rollDiceMVC";
    }
}
