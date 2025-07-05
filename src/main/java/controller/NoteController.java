package controller;

import model.Note;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import service.NoteService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class NoteController {
    @Autowired
    private NoteService noteService;

    // Soumission de la note
    @PostMapping("/livre/{idLivre}/noter")
    public String noterLivre(@PathVariable int idLivre,
                             @RequestParam int note,
                             @RequestParam String commentaire,
                             HttpSession session,
                             Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) return "redirect:/login";
        // Vérifications
        if (!noteService.hasEmprunteEtRendu(userId, idLivre)) {
            model.addAttribute("erreur", "Vous ne pouvez noter ce livre que si vous l'avez emprunté et rendu.");
            return "redirect:/livre/" + idLivre;
        }
        if (noteService.hasAlreadyNoted(userId, idLivre)) {
            model.addAttribute("erreur", "Vous avez déjà noté ce livre.");
            return "redirect:/livre/" + idLivre;
        }
        Note n = new Note();
        n.setId_adherent(userId);
        n.setId_livre(idLivre);
        n.setNote(note);
        n.setCommentaire(commentaire);
        noteService.noterLivre(n);
        model.addAttribute("message", "Votre avis a été enregistré !");
        return "redirect:/livre/" + idLivre;
    }

    // Suppression/modération d'un commentaire (pour bibliothécaire)
    @PostMapping("/note/{idNote}/delete")
    public String deleteNote(@PathVariable int idNote, HttpSession session, @RequestParam int idLivre) {
        String profil = (String) session.getAttribute("nomProfil");
        if (!"Bibliothecaire".equals(profil)) return "redirect:/front-office";
        noteService.deleteNote(idNote);
        return "redirect:/livre/" + idLivre;
    }
}