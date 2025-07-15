package com.bibliotheque.repository;

import com.bibliotheque.model.SubscriptionType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SubscriptionTypeRepository extends JpaRepository<SubscriptionType, Long> {
}
