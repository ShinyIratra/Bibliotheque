package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class DroitsRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Map<String, Object> getDroitsByProfil(int idProfil) {
        String sql = "SELECT cp.quota, cp.nbr_prolongement, cp.quota_reservation " +
                     "FROM Profil p JOIN Configuration_Profil cp ON p.id_configuration_profil = cp.id_configuration_profil " +
                     "WHERE p.id_profil = ?";
        return jdbcTemplate.queryForMap(sql, idProfil);
    }
}