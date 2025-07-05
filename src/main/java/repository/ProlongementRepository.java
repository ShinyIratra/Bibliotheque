package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProlongementRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int countProlongementsByPret(int idPret) {
        String sql = "SELECT COUNT(*) FROM Prolongement WHERE id_pret = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idPret}, Integer.class);
    }

    public void insertProlongement(int idPret, java.sql.Timestamp nouvelleDateRetour) {
        String sql = "INSERT INTO Prolongement (date_retour, id_pret) VALUES (?, ?)";
        jdbcTemplate.update(sql, nouvelleDateRetour, idPret);
    }
}