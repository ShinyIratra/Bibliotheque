package controller;

import model.Livre;
import model.Note;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.LivreService;
import service.NoteService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LivreController {
    @Autowired
    private LivreService livreService;
    @Autowired
    private NoteService noteService;

    @GetMapping("/livre/{idLivre}")
    public String ficheLivre(@PathVariable int idLivre, Model model, HttpSession session) {
        Livre livre = livreService.getLivreById(idLivre);
        if (livre == null) {
            model.addAttribute("erreur", "Livre introuvable.");
            return "fiche_livre";
        }
        List<Note> notes = noteService.getNotesByLivre(idLivre);
        model.addAttribute("livre", livre);
        model.addAttribute("notes", notes);
        model.addAttribute("idLivre", idLivre);

        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("canNoter", userId != null && noteService.hasEmprunteEtRendu(userId, idLivre) && !noteService.hasAlreadyNoted(userId, idLivre));
        return "fiche_livre";
    }

    @GetMapping("/livre")
    public String ficheLivreByParam(@RequestParam int idLivre, Model model, HttpSession session) {
        return ficheLivre(idLivre, model, session);
    }
}