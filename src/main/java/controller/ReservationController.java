package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.ReservationService;
import service.ExemplaireService;
import service.AdherentService;
import service.PretService;
import service.BlacklistingService;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;
    @Autowired
    private ExemplaireService exemplaireService;
    @Autowired
    private AdherentService adherentService;
    @Autowired
    private PretService pretService;
    @Autowired
    private BlacklistingService blacklistingService;

    @GetMapping("/reservation")
    public String formReservation(Model model, HttpSession session) {
        Integer id_adherent = (Integer) session.getAttribute("userId");
        if (id_adherent == null) return "redirect:/login";
        if (blacklistingService.isBlacklisted(id_adherent)) {
            model.addAttribute("erreurReservation", "Vous êtes temporairement bloqué pour cause d'abus.");
            return "front-office";
        }
        List<Map<String, Object>> exemplairesNonDispo = exemplaireService.getAllExemplairesNonDisponibles();
        model.addAttribute("exemplaires", exemplairesNonDispo != null ? exemplairesNonDispo : List.of());
        return "reservation";
    }

    @PostMapping("/reservation")
    public String reserverExemplaire(
            @RequestParam int id_exemplaire,
            @RequestParam String date_reserver,
            HttpSession session,
            Model model
    ) {
        Integer idAdherent = (Integer) session.getAttribute("userId");
        if (idAdherent == null) return "redirect:/login";

        // Vérification du blacklistage AVANT toute autre vérification
        if (blacklistingService.isBlacklisted(idAdherent)) {
            model.addAttribute("erreurReservation", "Vous êtes temporairement bloqué pour cause d'abus.");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Vérifier si l'exemplaire est déjà disponible
        String statut = exemplaireService.getLastStatutNameForExemplaire(id_exemplaire);
        if ("Disponible".equalsIgnoreCase(statut)) {
            model.addAttribute("message", "Ce livre est disponible, vous pouvez l'emprunter directement.");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Vérifier si l'adhérent est actif
        if (!reservationService.isAdherentActif(idAdherent)) {
            model.addAttribute("erreur", "Votre abonnement n'est pas actif.");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Vérifier le quota de réservation
        if (reservationService.isQuotaReservationDepasse(idAdherent)) {
            model.addAttribute("erreur", "Vous avez atteint votre quota de réservations.");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Vérifier la catégorie de l'exemplaire (Non Emportable)
        if (!reservationService.isExemplaireReservable(id_exemplaire)) {
            model.addAttribute("erreur", "Cet exemplaire ne peut pas être réservé (catégorie non réservable).");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Vérifier qu'il n'y a pas de prêt pour cet exemplaire à la date demandée
        LocalDate dateReserver = LocalDate.parse(date_reserver);
        boolean dejaPris = pretService.existePretPourExemplaireSurPeriode(id_exemplaire, dateReserver, dateReserver);
        if (dejaPris) {
            model.addAttribute("erreur", "Cet exemplaire est déjà prêté à la date choisie.");
            model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
            return "reservation";
        }

        // Réserver
        reservationService.reserver(idAdherent, id_exemplaire);
        model.addAttribute("message", "Réservation effectuée !");
        model.addAttribute("exemplaires", exemplaireService.getAllExemplairesNonDisponibles());
        return "reservation";
    }

    @GetMapping("/exemplaires-non-disponibles")
    @ResponseBody
    public List<Map<String, Object>> getExemplairesNonDisponibles(@RequestParam String date) {
        LocalDate d = LocalDate.parse(date);
        return exemplaireService.getExemplairesReservablesPourDate(d);
    }
}