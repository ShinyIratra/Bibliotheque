package repository;

import java.util.List;
import model.Livre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LivreRepository {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public Livre findById(int idLivre) {
        String sql = "SELECT * FROM Livre WHERE id_livre = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{idLivre}, (rs, rowNum) -> {
            Livre l = new Livre();
            l.setId_livre(rs.getInt("id_livre"));
            l.setTitre(rs.getString("titre"));
            // Ajoute d'autres champs si besoin
            return l;
        });
    }

    public List<Livre> findAll() {
        String sql = "SELECT * FROM Livre ORDER BY titre";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Livre l = new Livre();
            l.setId_livre(rs.getInt("id_livre"));
            l.setTitre(rs.getString("titre"));
            // Ajoute d'autres champs si besoin
            return l;
        });
    }
}