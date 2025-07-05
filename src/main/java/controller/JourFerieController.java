package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.JourFerieService;
import java.sql.Date;

@Controller
public class JourFerieController {
    @Autowired
    private JourFerieService jourFerieService;

    @GetMapping("/admin/jours-feries")
    public String configJoursFeries(Model model) {
        model.addAttribute("joursFeries", jourFerieService.getAllJoursFeries());
        return "config_jours_feries";
    }

    @PostMapping("/admin/jours-feries")
    public String ajouterJourFerie(@RequestParam String date, Model model) {
        jourFerieService.ajouterJourFerie(Date.valueOf(date));
        return "redirect:/admin/jours-feries";
    }
}