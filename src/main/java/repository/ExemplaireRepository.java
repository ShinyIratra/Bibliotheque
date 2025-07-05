package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.dao.EmptyResultDataAccessException;
import java.util.List;
import java.util.Map;
import java.time.LocalDate;

@Repository
public class ExemplaireRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> findAll() {
        String sql = "SELECT * FROM Exemplaire";
        return jdbcTemplate.queryForList(sql);
    }

    // Récupérer le dernier statut d'un exemplaire
    public int getLastStatutForExemplaire(int idExemplaire) {
        String sql = "SELECT id_statut FROM Statut_Exemplaire WHERE id_exemplaire = ? ORDER BY date_ajout DESC LIMIT 1";
        return jdbcTemplate.queryForObject(sql, new Object[]{idExemplaire}, Integer.class);
    }

    // Insérer un nouveau statut pour un exemplaire
    public void insertStatutExemplaire(int idExemplaire, int idStatut) {
        String sql = "INSERT INTO Statut_Exemplaire (date_ajout, id_exemplaire, id_statut) VALUES (NOW(), ?, ?)";
        jdbcTemplate.update(sql, idExemplaire, idStatut);
    }

    // Récupérer le nom du dernier statut d'un exemplaire
    public String getLastStatutNameForExemplaire(int idExemplaire) {
        String sql = "SELECT s.nom FROM Statut_Exemplaire se JOIN Statut s ON se.id_statut = s.id_statut WHERE se.id_exemplaire = ? ORDER BY se.date_ajout DESC LIMIT 1";
        return jdbcTemplate.queryForObject(sql, new Object[]{idExemplaire}, String.class);
    }

    // Obtenir l'id_statut à partir du nom
    public int getStatutIdByName(String nom) {
        String sql = "SELECT id_statut FROM Statut WHERE nom = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{nom}, Integer.class);
        } catch (EmptyResultDataAccessException e) {
            // Retourne -1 ou lance une exception personnalisée
            return -1;
        }
    }

    /**
     * Récupère l'id d'un statut par son nom (LIKE, insensible à la casse)
     * @param nomStatut le nom du statut à chercher
     * @return l'id_statut ou -1 si non trouvé
     */
    public int getStatutIdByNom(String nomStatut) {
        String sql = "SELECT id_statut FROM Statut WHERE LOWER(nom) = LOWER(?)";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{nomStatut}, Integer.class);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return -1;
        }
    }

    // Récupérer tous les exemplaires disponibles
    public List<Map<String, Object>> findAllDisponibles() {
        String sql =
            "SELECT e.* " +
            "FROM Exemplaire e " +
            "JOIN ( " +
            "    SELECT id_exemplaire, MAX(date_ajout) AS max_date " +
            "    FROM Statut_Exemplaire " +
            "    GROUP BY id_exemplaire " +
            ") se_max ON e.id_exemplaire = se_max.id_exemplaire " +
            "JOIN Statut_Exemplaire se ON se.id_exemplaire = se_max.id_exemplaire AND se.date_ajout = se_max.max_date " +
            "JOIN Statut s ON se.id_statut = s.id_statut " +
            "WHERE s.nom = 'Disponible'";
        return jdbcTemplate.queryForList(sql);
    }

    public List<Map<String, Object>> findAllNonDisponibles() {
        String sql =
            "SELECT e.* " +
            "FROM Exemplaire e " +
            "JOIN ( " +
            "    SELECT id_exemplaire, MAX(date_ajout) AS max_date " +
            "    FROM Statut_Exemplaire " +
            "    GROUP BY id_exemplaire " +
            ") se_max ON e.id_exemplaire = se_max.id_exemplaire " +
            "JOIN Statut_Exemplaire se ON se.id_exemplaire = se_max.id_exemplaire AND se.date_ajout = se_max.max_date " +
            "JOIN Statut s ON se.id_statut = s.id_statut " +
            "WHERE s.nom <> 'Disponible'";
        return jdbcTemplate.queryForList(sql);
    }

    /**
     * Retourne true si la catégorie de prêt de l'exemplaire est 'Non Emportable'
     */
    public boolean isLectureSurPlaceAutorisee(int idExemplaire) {
        String sql = "SELECT cp.nom FROM Exemplaire e " +
                     "JOIN Livre l ON e.id_livre = l.id_livre " +
                     "JOIN Categorie_Pret cp ON l.id_categorie_pret = cp.id_categorie_pret " +
                     "WHERE e.id_exemplaire = ?";
        String categoriePret = jdbcTemplate.queryForObject(sql, new Object[]{idExemplaire}, String.class);
        return "Non Emportable".equalsIgnoreCase(categoriePret);
    }

    public List<Map<String, Object>> getExemplairesNonDisponiblesPourDate(LocalDate date) {
        String sql = "SELECT * FROM Exemplaire WHERE id_exemplaire IN (" +
                     "SELECT id_exemplaire FROM Pret WHERE ? BETWEEN date_pret AND date_retour" +
                     ")";
        return jdbcTemplate.queryForList(sql, java.sql.Date.valueOf(date));
    }

    public List<Map<String, Object>> getExemplairesReservablesPourDate(LocalDate date) {
        String sql =
            "SELECT e.*, " +
            "  CASE " +
            "    WHEN s.nom = 'Disponible' THEN 'pret_possible' " +
            "    WHEN s.nom = 'Emprunte' AND (" +
            "      (SELECT MAX(COALESCE(pr.date_retour, p.date_retour)) " +
            "       FROM Pret p " +
            "       LEFT JOIN Prolongement pr ON pr.id_pret = p.id_pret " +
            "       WHERE p.id_exemplaire = e.id_exemplaire AND p.date_retour >= NOW()" +
            "      ) IS NOT NULL " +
            "      AND ? >= (SELECT MAX(COALESCE(pr.date_retour, p.date_retour)) " +
            "                FROM Pret p " +
            "                LEFT JOIN Prolongement pr ON pr.id_pret = p.id_pret " +
            "                WHERE p.id_exemplaire = e.id_exemplaire AND p.date_retour >= NOW())" +
            "    ) THEN 'reservation_possible' " +
            "    ELSE NULL " +
            "  END AS suggestion " +
            "FROM Exemplaire e " +
            "JOIN ( " +
            "    SELECT se1.id_exemplaire, s1.nom, se1.date_ajout " +
            "    FROM Statut_Exemplaire se1 " +
            "    JOIN Statut s1 ON se1.id_statut = s1.id_statut " +
            "    WHERE se1.date_ajout = (SELECT MAX(se2.date_ajout) FROM Statut_Exemplaire se2 WHERE se2.id_exemplaire = se1.id_exemplaire) " +
            ") se ON e.id_exemplaire = se.id_exemplaire " +
            "JOIN Statut s ON se.nom = s.nom " +
            "WHERE " +
            "  (s.nom = 'Disponible' " +
            "   OR (s.nom = 'Emprunte' AND (" +
            "      (SELECT MAX(COALESCE(pr.date_retour, p.date_retour)) " +
            "       FROM Pret p " +
            "       LEFT JOIN Prolongement pr ON pr.id_pret = p.id_pret " +
            "       WHERE p.id_exemplaire = e.id_exemplaire AND p.date_retour >= NOW()" +
            "      ) IS NOT NULL " +
            "      AND ? >= (SELECT MAX(COALESCE(pr.date_retour, p.date_retour)) " +
            "                FROM Pret p " +
            "                LEFT JOIN Prolongement pr ON pr.id_pret = p.id_pret " +
            "                WHERE p.id_exemplaire = e.id_exemplaire AND p.date_retour >= NOW())" +
            "   )))";
        java.sql.Date d = java.sql.Date.valueOf(date);
        return jdbcTemplate.queryForList(sql, d, d);
    }

    public List<Map<String, Object>> getExemplairesDisponiblesPourPeriode(LocalDate debut, LocalDate fin) {
        String sql =
            "SELECT e.* FROM Exemplaire e " +
            "WHERE e.id_exemplaire NOT IN (" +
            "   SELECT id_exemplaire FROM Pret " +
            "   WHERE (date_pret, date_retour) OVERLAPS (?, ?)" +
            ")";
        return jdbcTemplate.queryForList(sql, java.sql.Date.valueOf(debut), java.sql.Date.valueOf(fin));
    }
}