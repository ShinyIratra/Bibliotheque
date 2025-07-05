package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class HistoriquePretRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> getHistoriqueByAdherent(int idAdherent) {
        String sql =
            "SELECT l.titre, e.reference, p.date_pret AS datePret, p.date_retour AS dateRetourPrevue, " +
            "   (SELECT rp.date_retourne FROM Retour_Pret rp WHERE rp.id_pret = p.id_pret LIMIT 1) AS dateRetourEffective, " +
            "   CASE " +
            "       WHEN (SELECT rp.date_retourne FROM Retour_Pret rp WHERE rp.id_pret = p.id_pret LIMIT 1) > p.date_retour THEN TRUE " +
            "       ELSE FALSE " +
            "   END AS retard, " +
            "   a.nom AS adherent, " +
            "   s.nom AS statut " +
            "FROM Pret p " +
            "JOIN Exemplaire e ON p.id_exemplaire = e.id_exemplaire " +
            "JOIN Livre l ON e.id_livre = l.id_livre " +
            "JOIN Adherent a ON p.id_adherent = a.id_adherent " +
            "LEFT JOIN (" +
            "   SELECT se1.id_exemplaire, s1.nom, se1.date_ajout " +
            "   FROM Statut_Exemplaire se1 " +
            "   JOIN Statut s1 ON se1.id_statut = s1.id_statut " +
            "   WHERE se1.date_ajout = (" +
            "       SELECT MAX(se2.date_ajout) FROM Statut_Exemplaire se2 WHERE se2.id_exemplaire = se1.id_exemplaire" +
            "   )" +
            ") s ON s.id_exemplaire = e.id_exemplaire " +
            "WHERE p.id_adherent = ? " +
            "ORDER BY p.date_pret DESC";
        return jdbcTemplate.queryForList(sql, idAdherent);
    }
}