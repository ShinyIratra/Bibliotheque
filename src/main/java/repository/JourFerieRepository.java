package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import model.JourFerie;
import java.sql.Date;
import java.util.List;

@Repository
public class JourFerieRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<JourFerie> findAll() {
        String sql = "SELECT * FROM Jour_Ferie";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            JourFerie jf = new JourFerie();
            jf.setId_ferie(rs.getInt("id_ferie"));
            jf.setDate_ferie(rs.getDate("date_ferie"));
            return jf;
        });
    }

    public void insert(Date date_ferie) {
        String sql = "INSERT INTO Jour_Ferie (date_ferie) VALUES (?)";
        jdbcTemplate.update(sql, date_ferie);
    }

    public boolean isJourFerie(Date date_ferie) {
        String sql = "SELECT COUNT(*) FROM Jour_Ferie WHERE date_ferie = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{date_ferie}, Integer.class);
        return count != null && count > 0;
    }
}