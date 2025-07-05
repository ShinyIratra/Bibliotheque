package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.PretService;
import service.ProlongementService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class MesPretsController {

    @Autowired
    private PretService pretService;
    @Autowired
    private ProlongementService prolongementService;

    @GetMapping("/mes-prets")
    public String mesPrets(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        List<Map<String, Object>> prets = pretService.getPretsEnCoursByAdherent(userId);
        model.addAttribute("prets", prets);
        return "mes_prets";
    }

    @PostMapping("/prolonger")
    public String prolongerPret(@RequestParam int id_pret, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        String erreur = prolongementService.prolongerPret(id_pret, userId);
        if (erreur != null) {
            model.addAttribute("erreur", erreur);
        } else {
            model.addAttribute("message", "Prolongation effectuée !");
        }
        List<Map<String, Object>> prets = pretService.getPretsEnCoursByAdherent(userId);
        model.addAttribute("prets", prets);
        return "mes_prets";
    }
}