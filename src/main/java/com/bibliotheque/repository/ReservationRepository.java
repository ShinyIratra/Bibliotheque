package com.bibliotheque.repository;

import com.bibliotheque.model.Reservation;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
     @Query("SELECT r FROM Reservation r WHERE r.treatmentDate IS NULL")
    List<Reservation> findUntreatedReservations();
}
