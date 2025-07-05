package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.dao.EmptyResultDataAccessException;

import java.sql.Date;
import java.util.List;
import java.util.Map;

@Repository
public class AdherentRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<String> findAllNames() {
        String sql = "SELECT nom FROM Adherent";
        return jdbcTemplate.queryForList(sql, String.class);
    }

    public void insert(String nom, String identifiant, String password, String dateNaissance, int profilId) {
        String sql = "INSERT INTO Adherent (nom, identifiant, password, date_naissance, id_profil) VALUES (?, ?, ?, ?, ?)";
        Date sqlDate = Date.valueOf(dateNaissance); // dateNaissance doit être au format "yyyy-MM-dd"
        jdbcTemplate.update(sql, nom, identifiant, password, sqlDate, profilId);
    }

    public Integer getByIdentifiantAndPassword(String identifiant, String password) {
        String sql = "SELECT id_adherent FROM Adherent WHERE identifiant = ? AND password = ?";
        try {
            return jdbcTemplate.queryForObject(
                sql,
                new Object[] { identifiant, password },
                Integer.class
            );
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    public Integer getByIdentifiant(String identifiant) {
        String sql = "SELECT id_adherent FROM Adherent WHERE identifiant = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{identifiant}, Integer.class);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return null;
        }
    }

    public int getProfilIdByAdherent(int idAdherent) {
        String sql = "SELECT id_profil FROM Adherent WHERE id_adherent = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idAdherent}, Integer.class);
    }

    public List<Map<String, Object>> findAllIdentifiantsEtNoms() {
        String sql = "SELECT identifiant, nom FROM Adherent";
        return jdbcTemplate.queryForList(sql);
    }

}