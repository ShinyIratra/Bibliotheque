package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.HistoriquePretService;
import service.AdherentService;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class HistoriqueController {

    @Autowired
    private HistoriquePretService historiquePretService;
    @Autowired
    private AdherentService adherentService;

    // Pour un adhérent qui consulte son propre historique
    @GetMapping("/historique")
    public String historique(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        List<Map<String, Object>> historique = historiquePretService.getHistoriqueByAdherent(userId);
        model.addAttribute("historique", historique);
        return "historique_pret";
    }

    // Pour un bibliothécaire qui consulte l'historique d'un autre adhérent
    @GetMapping("/historique/{idAdherent}")
    public String historiqueAdherent(
            @PathVariable int idAdherent,
            HttpSession session,
            Model model
    ) {
        String nomProfil = (String) session.getAttribute("nomProfil");
        if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
            model.addAttribute("erreur", "Vous n'avez pas les droits pour consulter l'historique d'un autre adhérent.");
            return "historique_pret";
        }
        List<Map<String, Object>> historique = historiquePretService.getHistoriqueByAdherent(idAdherent);
        model.addAttribute("historique", historique);
        return "historique_pret";
    }
}