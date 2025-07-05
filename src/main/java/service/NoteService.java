package service;

import model.Note;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import repository.NoteRepository;
import repository.PretRepository;

import java.util.List;

@Service
public class NoteService {
    @Autowired
    private NoteRepository noteRepository;
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private JdbcTemplate jdbcTemplate; // <-- AJOUTER CETTE LIGNE

    // Vérifie si l'adhérent a déjà noté ce livre
    public boolean hasAlreadyNoted(int idAdherent, int idLivre) {
        return noteRepository.hasAlreadyNoted(idAdherent, idLivre);
    }

    // Vérifie si l'adhérent a emprunté ET rendu ce livre
    public boolean hasEmprunteEtRendu(int idAdherent, int idLivre) {
        String sql = "SELECT COUNT(*) FROM Pret p " +
                     "JOIN Retour_Pret r ON r.id_pret = p.id_pret " +
                     "JOIN Exemplaire e ON p.id_exemplaire = e.id_exemplaire " +
                     "WHERE p.id_adherent = ? AND e.id_livre = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, idLivre}, Integer.class);
        return count != null && count > 0;
    }

    public void noterLivre(Note note) {
        noteRepository.insert(note);
    }

    public List<Note> getNotesByLivre(int idLivre) {
        return noteRepository.findByLivre(idLivre);
    }

    public void deleteNote(int idNote) {
        noteRepository.delete(idNote);
    }
}