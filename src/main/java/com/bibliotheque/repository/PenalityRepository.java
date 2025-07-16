package com.bibliotheque.repository;

import com.bibliotheque.model.Penality;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PenalityRepository extends JpaRepository<Penality, Long> {
    
    @Query("SELECT p FROM Penality p WHERE p.member.id = :memberId AND p.startDate <= :checkDate AND (p.endDate IS NULL OR p.endDate >= :checkDate)")
    List<Penality> findActivePenalitiesForMemberAtDate(@Param("memberId") Long memberId, @Param("checkDate") LocalDate checkDate);
    
    @Query("SELECT p FROM Penality p WHERE p.member.id = :memberId")
    List<Penality> findAllByMemberId(@Param("memberId") Long memberId);
}
