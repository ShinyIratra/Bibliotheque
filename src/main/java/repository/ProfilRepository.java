package repository;

import model.Profil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ProfilRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Profil> findAll() {
        String sql = "SELECT id_profil, nom FROM Profil";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Profil profil = new Profil();
            profil.setId_profil(rs.getInt("id_profil"));
            profil.setNom(rs.getString("nom"));
            return profil;
        });
    }

    public int getQuotaByProfil(int idProfil) {
        String sql = "SELECT cp.quota FROM Profil p JOIN Configuration_Profil cp ON p.id_configuration_profil = cp.id_configuration_profil WHERE p.id_profil = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idProfil}, Integer.class);
    }

    public String getNomProfilById(int idProfil) {
        String sql = "SELECT nom FROM Profil WHERE id_profil = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idProfil}, String.class);
    }

    // Récupère l'id du profil à partir de l'id de l'adhérent
    public int getProfilIdByAdherent(int idAdherent) {
        String sql = "SELECT id_profil FROM Adherent WHERE id_adherent = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idAdherent}, Integer.class);
    }

    // Récupère le quota de réservation à partir de l'id du profil
    public int getQuotaReservationByProfil(int idProfil) {
        String sql = "SELECT cp.quota_reservation FROM Profil p JOIN Configuration_Profil cp ON p.id_configuration_profil = cp.id_configuration_profil WHERE p.id_profil = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idProfil}, Integer.class);
    }
}