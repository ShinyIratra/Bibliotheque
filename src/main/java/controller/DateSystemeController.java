package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.DateSystemeService;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

@Controller
public class DateSystemeController {
    @Autowired
    private DateSystemeService dateSystemeService;

    @PostMapping("/modifier-date-systeme")
    public String modifierDate(@RequestParam String nouvelleDate, HttpSession session) {
        String nomProfil = (String) session.getAttribute("nomProfil");
        if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
            return "redirect:/front-office";
        }
        dateSystemeService.setDateNow(LocalDateTime.parse(nouvelleDate));
        return "redirect:/front-office";
    }

    @GetMapping("/reset-date-systeme")
    public String resetDate(HttpSession session) {
        String nomProfil = (String) session.getAttribute("nomProfil");
        if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
            return "redirect:/front-office";
        }
        dateSystemeService.resetDateNow();
        return "redirect:/front-office";
    }

    @ModelAttribute
    public void addDateNow(Model model) {
        model.addAttribute("dateNow", dateSystemeService.getDateNow());
    }
}