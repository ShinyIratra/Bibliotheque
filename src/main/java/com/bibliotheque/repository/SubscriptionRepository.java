package com.bibliotheque.repository;

import com.bibliotheque.model.*;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    Optional<Subscription> findFirstByMemberIdOrderBySubscriptionDateDesc(Long memberId);
    Subscription findTopByMemberOrderBySubscriptionEndDesc(Member member);
}
