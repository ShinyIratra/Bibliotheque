package repository;

import model.Note;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NoteRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insert(Note note) {
        String sql = "INSERT INTO Note (note, commentaire, id_adherent, id_livre) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, note.getNote(), note.getCommentaire(), note.getId_adherent(), note.getId_livre());
    }

    public boolean hasAlreadyNoted(int idAdherent, int idLivre) {
        String sql = "SELECT COUNT(*) FROM Note WHERE id_adherent = ? AND id_livre = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, idLivre}, Integer.class);
        return count != null && count > 0;
    }

    public List<Note> findByLivre(int idLivre) {
        String sql = "SELECT * FROM Note WHERE id_livre = ?";
        return jdbcTemplate.query(sql, new Object[]{idLivre}, (rs, rowNum) -> {
            Note n = new Note();
            n.setId_note(rs.getInt("id_note"));
            n.setNote(rs.getInt("note"));
            n.setCommentaire(rs.getString("commentaire"));
            n.setId_adherent(rs.getInt("id_adherent"));
            n.setId_livre(rs.getInt("id_livre"));
            return n;
        });
    }

    public void delete(int idNote) {
        String sql = "DELETE FROM Note WHERE id_note = ?";
        jdbcTemplate.update(sql, idNote);
    }
}