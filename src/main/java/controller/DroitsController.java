package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import service.AdherentService;
import service.ProfilService;
import service.DroitsService;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class DroitsController {

    @Autowired
    private AdherentService adherentService;
    @Autowired
    private ProfilService profilService;
    @Autowired
    private DroitsService droitsService;

    @GetMapping("/mes-droits")
    public String consulterDroits(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";

        int idProfil = adherentService.getProfilIdByAdherent(userId);
        String nomProfil = profilService.getNomProfilById(idProfil);
        Map<String, Object> droits = droitsService.getDroitsByProfil(idProfil);
        model.addAttribute("nomProfil", nomProfil);
        model.addAttribute("droits", droits != null ? droits : Map.of());
        return "mes_droits";
    }
}