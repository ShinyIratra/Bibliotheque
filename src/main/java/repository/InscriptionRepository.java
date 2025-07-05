package repository;

import model.Inscription;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.time.LocalDate;

@Repository
public class InscriptionRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Vérifie si une inscription existe pour la période (chevauchement)
    public boolean hasInscriptionForPeriod(int idAdherent, Timestamp debut, Timestamp fin) {
        String sql = "SELECT COUNT(*) FROM Inscription WHERE id_adherent = ? AND (date_debut, date_fin) OVERLAPS (?, ?)";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, debut, fin}, Integer.class);
        return count != null && count > 0;
    }

    // Insère une nouvelle inscription
    public void insert(Timestamp debut, Timestamp fin, int idAdherent) {
        String sql = "INSERT INTO Inscription (date_debut, date_fin, id_adherent) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, debut, fin, idAdherent);
    }

    // Vérifie si l'adhérent est actif à la date du jour
    public boolean isActif(int idAdherent, LocalDate now) {
        String sql = "SELECT COUNT(*) FROM Inscription WHERE id_adherent = ? AND ? BETWEEN date_debut::date AND date_fin::date";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, java.sql.Date.valueOf(now)}, Integer.class);
        return count != null && count > 0;
    }

    // Liste tous les adhérents (id + nom)
    public List<Integer> getAllAdherentIds() {
        String sql = "SELECT id_adherent FROM Adherent";
        return jdbcTemplate.queryForList(sql, Integer.class);
    }
}