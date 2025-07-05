package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PenaliteRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insertPenalite(int idTypePenalite, int idAdherent, String justificatif) {
        String sql = "INSERT INTO Penalite (justificatif, id_type_penalite, id_adherent) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, justificatif, idTypePenalite, idAdherent);
    }

    public int countRetardsRecents(int idAdherent, int nbMois) {
        String sql = "SELECT COUNT(*) FROM Penalite p " +
                     "JOIN Type_Penalite tp ON p.id_type_penalite = tp.id_type_penalite " +
                     "WHERE p.id_adherent = ? AND tp.nom = 'Retard' " +
                     "AND p.date_penalite >= (CURRENT_DATE - INTERVAL '" + nbMois + " month')";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent}, Integer.class);
        return count != null ? count : 0;
    }
}