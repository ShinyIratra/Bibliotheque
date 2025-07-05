package controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import service.AdherentService;
import service.ProfilService; // Import ajouté
import service.LivreService; // Import du service Livre
import service.DateSystemeService; // Import du service DateSysteme
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private AdherentService adherentService;
    
    @Autowired
    private ProfilService profilService; // Service ajouté

    @Autowired
    private LivreService livreService; // Nouveau service ajouté

    @Autowired
    private DateSystemeService dateSystemeService; // Nouveau service ajouté

    @GetMapping("/login")
    public String login(Model model){
        return "login";
    }
    
    @PostMapping("/login")
    public String loginPost(
        @RequestParam String id,
        @RequestParam String password,
        HttpSession session
    ) {
        if (adherentService.authenticate(id, password)) {
            Integer userId = adherentService.getByIdentifiant(id);
            session.setAttribute("userId", userId);

            // Récupérer le nom du profil de l'utilisateur connecté
            int idProfil = adherentService.getProfilIdByAdherent(userId);
            String nomProfil = profilService.getNomProfilById(idProfil);
            session.setAttribute("nomProfil", nomProfil);

            return "redirect:/front-office";
        } else {
            return "redirect:/login?error=true";
        }
    }

    @GetMapping("/register")
    public String register(Model model){
        // Ajouter la liste des profils au modèle
        model.addAttribute("profils", profilService.getAllProfils());
        return "register";
    }

    @PostMapping("/register")
    public String registerPost(
        @RequestParam String nom,
        @RequestParam String identifiant,
        @RequestParam String password,
        @RequestParam String date_naissance,
        @RequestParam int profilId // Nouveau paramètre pour le profil
    ) {
        adherentService.insert(nom, identifiant, password, date_naissance, profilId);
        return "redirect:/login";
    }

    @GetMapping("/front-office")
    public String frontOffice(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        model.addAttribute("livres", livreService.getAllLivres());
        model.addAttribute("dateNow", dateSystemeService.getDateNow());
        return "front-office";
    }

    @GetMapping("/")
    public String rootRedirect(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        } else {
            return "redirect:/front-office";
        }
    }
}