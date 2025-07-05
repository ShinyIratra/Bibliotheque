package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDate;

@Repository
public class PenaliteRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insertPenalite(int idTypePenalite, int idAdherent, String justificatif) {
        String sql = "INSERT INTO Penalite (justificatif, id_type_penalite, id_adherent) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, justificatif, idTypePenalite, idAdherent);
    }

    public int countRetardsRecents(int idAdherent, int nbMois, LocalDate now) {
        String sql = "SELECT COUNT(*) FROM Penalite p " +
                     "JOIN Type_Penalite tp ON p.id_type_penalite = tp.id_type_penalite " +
                     "WHERE p.id_adherent = ? AND tp.nom = 'Retard' " +
                     "AND p.date_retour >= ?";
        Timestamp timestamp = Timestamp.valueOf(now.atStartOfDay());
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, timestamp}, Integer.class);
        return count != null ? count : 0;
    }
}