package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.AdherentService;
import service.InscriptionService;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
public class InscriptionController {

    @Autowired
    private InscriptionService inscriptionService;
    @Autowired
    private AdherentService adherentService;

    @GetMapping("/inscription")
    public String formInscription(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        String nomProfil = (String) session.getAttribute("nomProfil");
        if (userId == null) return "redirect:/login";
        // if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
        //     return "redirect:/front-office";
        // }
        if (nomProfil == null) return "redirect:/login";
        List<Map<String, Object>> adherents = adherentService.getAllAdherentIdentifiantsEtNoms();
        model.addAttribute("adherents", adherents != null ? adherents : List.of());
        return "inscription";
    }

    @PostMapping("/inscription")
    public String enregistrerInscription(
            @RequestParam String nom_adherent,
            @RequestParam String date_debut,
            @RequestParam String date_fin,
            Model model,
            HttpSession session
    ) {
        String nomProfil = (String) session.getAttribute("nomProfil");
        // POST /inscription
        if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
            return "redirect:/front-office";
        }
        Integer id_adherent = adherentService.getByIdentifiant(nom_adherent);
        if (id_adherent == null) {
            model.addAttribute("erreur", "Adhérent introuvable.");
            model.addAttribute("adherents", adherentService.getAllAdherentIdentifiantsEtNoms());
            return "inscription";
        }
        Timestamp debut = Timestamp.valueOf(LocalDate.parse(date_debut).atStartOfDay());
        Timestamp fin = Timestamp.valueOf(LocalDate.parse(date_fin).atTime(23,59,59));
        if (inscriptionService.hasInscriptionForPeriod(id_adherent, debut, fin)) {
            model.addAttribute("erreur", "L'adhérent est déjà inscrit pour cette période.");
            model.addAttribute("adherents", adherentService.getAllAdherentIdentifiantsEtNoms());
            return "inscription";
        }
        // Paiement validé (supposé)
        inscriptionService.creerInscription(debut, fin, id_adherent);
        model.addAttribute("message", "Inscription enregistrée !");
        model.addAttribute("adherents", adherentService.getAllAdherentIdentifiantsEtNoms());
        return "inscription";
    }
}