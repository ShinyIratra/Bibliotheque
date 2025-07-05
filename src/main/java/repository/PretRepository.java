package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Repository
public class PretRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insert(Timestamp datePret, Timestamp dateRetour, int idTypePret, int idExemplaire, int idAdherent) {
        String sql = "INSERT INTO Pret (date_pret, date_retour, id_type_pret, id_exemplaire, id_adherent) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, datePret, dateRetour, idTypePret, idExemplaire, idAdherent);
    }

    // Compte les prêts en cours (non rendus) pour un adhérent, hors "Sur Place"
    public int countPretsEmportableEnCoursByAdherent(int idAdherent) {
        String sql = "SELECT COUNT(*) FROM Pret p " +
                "JOIN Type_Pret tp ON p.id_type_pret = tp.id_type_pret " +
                "WHERE p.id_adherent = ? " +
                "AND tp.nom <> 'Sur Place' " +
                "AND NOT EXISTS (SELECT 1 FROM Retour_Pret r WHERE r.id_pret = p.id_pret)";
        return jdbcTemplate.queryForObject(sql, Integer.class, idAdherent);
    }

    // Récupère l'id_exemplaire d'un prêt
    public int getIdExemplaireByPret(int idPret) {
        String sql = "SELECT id_exemplaire FROM Pret WHERE id_pret = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, idPret);
    }

    // Insère un retour de prêt
    public void insertRetourPret(int idPret, LocalDateTime now) {
        String sql = "INSERT INTO Retour_Pret (id_pret, date_retourne) VALUES (?, ?)";
        jdbcTemplate.update(sql, idPret, Timestamp.valueOf(now));
    }

    // Vérifie si un exemplaire est déjà prêté sur une période
    public boolean isExemplaireDisponibleSurPeriode(int idExemplaire, java.time.LocalDate debut, java.time.LocalDate fin) {
        String sql = "SELECT COUNT(*) FROM Pret p " +
                "WHERE p.id_exemplaire = ? " +
                "AND NOT EXISTS (SELECT 1 FROM Retour_Pret r WHERE r.id_pret = p.id_pret) " +
                "AND (p.date_pret, p.date_retour) OVERLAPS (?, ?)";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, idExemplaire, java.sql.Timestamp.valueOf(debut.atStartOfDay()), java.sql.Timestamp.valueOf(fin.atTime(23,59,59)));
        return count == 0;
    }

    // Liste les prêts en cours pour un adhérent
    public List<Map<String, Object>> getPretsEnCoursByAdherent(int idAdherent) {
        String sql = "SELECT p.*, l.titre, e.reference " +
                "FROM Pret p " +
                "JOIN Exemplaire e ON p.id_exemplaire = e.id_exemplaire " +
                "JOIN Livre l ON e.id_livre = l.id_livre " +
                "WHERE p.id_adherent = ? " +
                "AND NOT EXISTS (SELECT 1 FROM Retour_Pret r WHERE r.id_pret = p.id_pret)";
        return jdbcTemplate.queryForList(sql, idAdherent);
    }

    // Liste l'historique des prêts pour un adhérent
    public List<Map<String, Object>> getHistoriquePretsByAdherent(int idAdherent) {
        String sql = "SELECT p.*, l.titre, e.reference " +
                "FROM Pret p " +
                "JOIN Exemplaire e ON p.id_exemplaire = e.id_exemplaire " +
                "JOIN Livre l ON e.id_livre = l.id_livre " +
                "WHERE p.id_adherent = ?";
        return jdbcTemplate.queryForList(sql, idAdherent);
    }

    // Récupère le dernier prêt créé pour un adhérent/exemplaire/date
    public Integer getLastPretIdForAdherent(int idAdherent, int idExemplaire, Timestamp datePret) {
        String sql = "SELECT id_pret FROM Pret WHERE id_adherent = ? AND id_exemplaire = ? AND date_pret = ? ORDER BY id_pret DESC LIMIT 1";
        List<Integer> ids = jdbcTemplate.queryForList(sql, Integer.class, idAdherent, idExemplaire, datePret);
        return ids.isEmpty() ? null : ids.get(0);
    }

    // Récupère la date de retour d'un prêt
    public Timestamp getDateRetourByPret(int idPret) {
        String sql = "SELECT date_retour FROM Pret WHERE id_pret = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idPret}, Timestamp.class);
    }

    // Vérifie si le livre est réservé par un autre adhérent
    public boolean isLivreReserveParUnAutre(int idPret, int idAdherent) {
        String sql = "SELECT COUNT(*) FROM Reservation r " +
                 "JOIN Pret p ON r.id_exemplaire = p.id_exemplaire " +
                 "WHERE p.id_pret = ? AND r.id_adherent <> ? AND r.statut = 'active'";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idPret, idAdherent}, Integer.class);
        return count != null && count > 0;
    }

    // Met à jour la date de retour d'un prêt
    public void updateDateRetour(int idPret, Timestamp nouvelleDateRetour) {
        String sql = "UPDATE Pret SET date_retour = ? WHERE id_pret = ?";
        jdbcTemplate.update(sql, nouvelleDateRetour, idPret);
    }

    // Vérifie si un adhérent est blacklisté à la date actuelle
    public boolean isAdherentBlackliste(int idAdherent, LocalDateTime now) {
        String sql = "SELECT COUNT(*) FROM Blacklisting WHERE id_adherent = ? AND ? BETWEEN date_debut AND date_fin";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent, Timestamp.valueOf(now)}, Integer.class);
        return count != null && count > 0;
    }
}