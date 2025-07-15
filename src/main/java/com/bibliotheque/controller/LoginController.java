package com.bibliotheque.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bibliotheque.service.*;

@Controller
public class LoginController {

    @Autowired 
    private LoginService loginService;

    @GetMapping("/librarian-login")
    public String librarianLogin(Model model) {
        return "librarian-login";
    }

    @GetMapping("/member-login")
    public String memberLogin(Model model) {
        return "member-login";
    }

    @PostMapping("/librarian-connect")
    public String librarianConnect(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
        try {
            if (session.getAttribute("sessionMember") != null || session.getAttribute("sessionLibrarian") != null) {
                model.addAttribute("error", "Already connected");
                return "librarian-login";
            }
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                model.addAttribute("error", "All fields are required");
                return "librarian-login";
            }
            Long librarianId = loginService.librarianConnect(username, password);
            session.setAttribute("sessionLibrarian", librarianId);
            return "redirect:home";
        } catch (RuntimeException e) {
            model.addAttribute("error", "Wrong username or password");
            return "librarian-login";
        }
    }

    @PostMapping("/member-connect")
    public String memberConnect(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
        try {
            if (session.getAttribute("sessionMember") != null || session.getAttribute("sessionLibrarian") != null) {
                model.addAttribute("error", "Already connected");
                return "member-login";
            }
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                model.addAttribute("error", "All fields are required");
                return "member-login";
            }
            Long memberId = loginService.memberConnect(username, password);
            session.setAttribute("sessionMember", memberId);
            return "redirect:/home";
        } catch (RuntimeException e) {
            model.addAttribute("error", "Wrong username or password");
            return "member-login";
        }
    }

    @GetMapping("/disconnect")
    public String disconnect(HttpSession session) {
        session.invalidate();
        return "redirect:/home";
    }

}
