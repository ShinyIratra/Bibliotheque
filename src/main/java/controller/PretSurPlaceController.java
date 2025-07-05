package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.ExemplaireService;
import service.AdherentService;
import service.PretService;
import service.TypePretService;
import service.DateSystemeService;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Controller
public class PretSurPlaceController {

    @Autowired
    private ExemplaireService exemplaireService;
    @Autowired
    private AdherentService adherentService;
    @Autowired
    private PretService pretService;
    @Autowired
    private TypePretService typePretService;
    @Autowired
    private DateSystemeService dateSystemeService;

    @GetMapping("/pret-sur-place")
    public String formSurPlace(HttpSession session, Model model) {
        return "pret_sur_place";
    }

    @PostMapping("/pret-sur-place")
    public String enregistrerSurPlace(
            @RequestParam String reference_exemplaire,
            @RequestParam String identifiant_adherent,
            HttpSession session,
            Model model
    ) {
        String nomProfil = (String) session.getAttribute("nomProfil");
        if (nomProfil == null || !nomProfil.equals("Bibliothecaire")) {
            return "redirect:/front-office";
        }

        // Récupérer l'id_exemplaire à partir de la référence
        List<Map<String, Object>> exemplaires = exemplaireService.getAllExemplaires();
        Integer idExemplaire = null;
        for (Map<String, Object> ex : exemplaires) {
            if (reference_exemplaire.equals(ex.get("reference")) || reference_exemplaire.equals(ex.get("Reference"))) {
                idExemplaire = (Integer) ex.get("id_exemplaire");
                break;
            }
        }
        if (idExemplaire == null) {
            model.addAttribute("erreur", "Exemplaire introuvable.");
            return "pret_sur_place";
        }

        // Vérifier que l'exemplaire est autorisé pour lecture sur place
        boolean autoriseSurPlace = false;
        try {
            autoriseSurPlace = exemplaireService.isLectureSurPlaceAutorisee(idExemplaire);
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur lors de la vérification de la catégorie de prêt.");
            return "pret_sur_place";
        }
        if (!autoriseSurPlace) {
            model.addAttribute("erreur", "Cet exemplaire n'est pas autorisé pour la lecture sur place.");
            return "pret_sur_place";
        }

        // Récupérer l'id_adherent à partir de l'identifiant
        Integer idAdherent = adherentService.getByIdentifiant(identifiant_adherent);
        if (idAdherent == null) {
            model.addAttribute("erreur", "Adhérent introuvable.");
            return "pret_sur_place";
        }

        // Récupérer l'id_type_pret correspondant à 'Sur Place'
        int idTypePretSurPlace = -1;
        List<Map<String, Object>> typesPret = typePretService.getAllTypesPret();
        for (Map<String, Object> tp : typesPret) {
            if ("Sur Place".equalsIgnoreCase((String) tp.get("nom"))) {
                idTypePretSurPlace = (Integer) tp.get("id_type_pret");
                break;
            }
        }
        if (idTypePretSurPlace == -1) {
            model.addAttribute("erreur", "Type de prêt 'Sur Place' introuvable.");
            return "pret_sur_place";
        }

        // Créer le prêt pour la journée (date_retour = aujourd'hui 23:59:59)
        LocalDateTime now = dateSystemeService.getDateNow();
        LocalDateTime finJournee = now.toLocalDate().atTime(23, 59, 59);
        pretService.creerPret(Timestamp.valueOf(now), Timestamp.valueOf(finJournee), idTypePretSurPlace, idExemplaire, idAdherent);

        // Mettre à jour le statut de l'exemplaire à "Emprunte"
        int idStatutEmprunte = exemplaireService.getStatutIdByNom("Emprunte");
        exemplaireService.setStatutExemplaire(idExemplaire, idStatutEmprunte);

        model.addAttribute("message", "Prêt Sur Place enregistré !");
        return "pret_sur_place";
    }
}