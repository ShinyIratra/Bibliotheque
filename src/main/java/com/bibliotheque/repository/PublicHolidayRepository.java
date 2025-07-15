package com.bibliotheque.repository;

import com.bibliotheque.model.PublicHoliday;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PublicHolidayRepository extends JpaRepository<PublicHoliday, Long> {
     @Query("SELECT p.dateHoliday FROM PublicHoliday p")
    List<LocalDate> findAllDates();
}
