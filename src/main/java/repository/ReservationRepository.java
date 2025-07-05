package repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Repository
public class ReservationRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int countReservationsEnCoursByAdherent(int idAdherent) {
        String sql = "SELECT COUNT(*) FROM Reservation WHERE id_adherent = ? AND date_reserver > NOW()";
        return jdbcTemplate.queryForObject(sql, new Object[]{idAdherent}, Integer.class);
    }

    public void insertReservation(int idAdherent, int idExemplaire, LocalDateTime now) {
        String sql = "INSERT INTO Reservation (date_reservation, date_reserver, id_adherent, id_exemplaire) VALUES (?, ?, ?, ?)";
        // Par exemple, date_reserver = now + 7 jours
        Timestamp dateReservation = Timestamp.valueOf(now);
        Timestamp dateReserver = Timestamp.valueOf(now.plusDays(7));
        jdbcTemplate.update(sql, dateReservation, dateReserver, idAdherent, idExemplaire);
    }

    public boolean isExemplaireReservable(int idExemplaire) {
        // Vérifie la catégorie de prêt de l'exemplaire (doit être 'Emportable')
        String sql = "SELECT cp.nom FROM Exemplaire e " +
                     "JOIN Livre l ON e.id_livre = l.id_livre " +
                     "JOIN Categorie_Pret cp ON l.id_categorie_pret = cp.id_categorie_pret " +
                     "WHERE e.id_exemplaire = ?";
        String categoriePret = jdbcTemplate.queryForObject(sql, new Object[]{idExemplaire}, String.class);
        return "Emportable".equalsIgnoreCase(categoriePret);
    }
}