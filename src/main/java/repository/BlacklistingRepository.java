package repository;

import model.Blacklisting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public class BlacklistingRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void insert(Timestamp dateDebut, Timestamp dateFin, int idAdherent) {
        String sql = "INSERT INTO Blacklisting (date_debut, date_fin, id_adherent) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, dateDebut, dateFin, idAdherent);
    }

    public boolean isBlacklisted(int idAdherent) {
        String sql = "SELECT COUNT(*) FROM Blacklisting WHERE id_adherent = ? AND NOW() BETWEEN date_debut AND date_fin";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{idAdherent}, Integer.class);
        return count != null && count > 0;
    }

    public List<Blacklisting> getActiveBlacklistings() {
        String sql = "SELECT * FROM Blacklisting WHERE NOW() BETWEEN date_debut AND date_fin";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Blacklisting b = new Blacklisting();
            b.setId(rs.getInt("id_blacklisting"));
            b.setDateDebut(rs.getTimestamp("date_debut"));
            b.setDateFin(rs.getTimestamp("date_fin"));
            b.setIdAdherent(rs.getInt("id_adherent"));
            return b;
        });
    }
}