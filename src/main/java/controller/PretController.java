package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.PretService;
import service.ExemplaireService;
import service.TypePretService;
import service.BlacklistingService;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
public class PretController {

    @Autowired
    private PretService pretService;
    @Autowired
    private ExemplaireService exemplaireService;
    @Autowired
    private TypePretService typePretService;
    @Autowired
    private BlacklistingService blacklistingService;

    @GetMapping("/pret")
    public String formPret(Model model, HttpSession session) {
        model.addAttribute("exemplaires", exemplaireService.getAllExemplairesDisponibles());
        model.addAttribute("typesPret", typePretService.getAllTypesPret());
        return "pret_livre";
    }

    @PostMapping("/pret")
    public String effectuerPret(
            @RequestParam int id_exemplaire,
            @RequestParam int id_type_pret,
            @RequestParam String date_pret,
            @RequestParam String date_retour,
            HttpSession session,
            Model model
    ) {
        Integer id_adherent = (Integer) session.getAttribute("userId");
        if (id_adherent == null) return "redirect:/login";
        if (blacklistingService.isBlacklisted(id_adherent)) {
            model.addAttribute("erreurExemplaire", "Vous êtes temporairement bloqué pour cause d'abus.");
            return "front-office";
        }

        // Vérification du quota AVANT la création du prêt
        if (pretService.isQuotaDepasse(id_adherent)) {
            model.addAttribute("quotaDepasse", true);
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesDisponibles());
            model.addAttribute("typesPret", typePretService.getAllTypesPret());
            return "pret_livre";
        }

        // Vérification de la disponibilité de l'exemplaire sur la période demandée
        LocalDate debut = LocalDate.parse(date_pret);
        LocalDate fin = LocalDate.parse(date_retour);
        boolean dejaPris = pretService.existePretPourExemplaireSurPeriode(id_exemplaire, debut, fin);
        if (dejaPris) {
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesDisponibles());
            model.addAttribute("typesPret", typePretService.getAllTypesPret());
            model.addAttribute("erreurExemplaire", "Cet exemplaire est déjà prêté sur la période choisie.");
            return "pret_livre";
        }

        pretService.creerPret(
            Timestamp.valueOf(debut.atStartOfDay()),
            Timestamp.valueOf(fin.atStartOfDay()),
            id_type_pret,
            id_exemplaire,
            id_adherent
        );

        // Met à jour le statut de l'exemplaire à "Emprunte"
        int idStatutEmprunte = exemplaireService.getStatutIdByNom("Emprunte");
        exemplaireService.setStatutExemplaire(id_exemplaire, idStatutEmprunte);

        return "redirect:/front-office";
    }

    @PostMapping("/retour")
    public String retourPret(@RequestParam int id_pret, HttpSession session, Model model) {
        Integer id_adherent = (Integer) session.getAttribute("userId");
        if (id_adherent == null) return "redirect:/login";

        int idExemplaire = pretService.getIdExemplaireByPret(id_pret);
        pretService.retourPret(id_pret);

        // Met à jour le statut de l'exemplaire à "Disponible"
        int idStatutDisponible = exemplaireService.getStatutIdByNom("Disponible");
        exemplaireService.setStatutExemplaire(idExemplaire, idStatutDisponible);

        model.addAttribute("message", "Retour effectué.");
        model.addAttribute("pretsEnCours", pretService.getPretsEnCoursByAdherent(id_adherent));
        return "retour_pret";
    }

    @GetMapping("/retour")
    public String formRetour(HttpSession session, Model model) {
        Integer id_adherent = (Integer) session.getAttribute("userId");
        if (id_adherent == null) return "redirect:/login";
        model.addAttribute("pretsEnCours", pretService.getPretsEnCoursByAdherent(id_adherent));
        return "retour_pret";
    }

    @GetMapping("/exemplaires-disponibles")
    @ResponseBody
    public List<Map<String, Object>> getExemplairesDisponibles(@RequestParam String date_pret, @RequestParam String date_retour) {
        LocalDate debut = LocalDate.parse(date_pret);
        LocalDate fin = LocalDate.parse(date_retour);
        return exemplaireService.getAllExemplairesDisponiblesPourPeriode(debut, fin);
    }
}