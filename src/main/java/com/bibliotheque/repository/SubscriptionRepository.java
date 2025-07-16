package com.bibliotheque.repository;

import com.bibliotheque.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    Optional<Subscription> findFirstByMemberIdOrderBySubscriptionDateDesc(Long memberId);
    Subscription findTopByMemberOrderBySubscriptionEndDesc(Member member);
    
    @Query("SELECT s FROM Subscription s WHERE s.member.id = :memberId AND :checkDate BETWEEN s.subscriptionStart AND s.subscriptionEnd")
    List<Subscription> findActiveSubscriptionsForMemberAtDate(@Param("memberId") Long memberId, @Param("checkDate") LocalDate checkDate);
    
    @Query("SELECT s FROM Subscription s WHERE s.member.id = :memberId")
    List<Subscription> findAllByMemberId(@Param("memberId") Long memberId);
}
