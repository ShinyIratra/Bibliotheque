package com.bibliotheque.repository;

import com.bibliotheque.model.Status;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StatusRepository extends JpaRepository<Status, Long> {
    // If you need to find status by member ID, use MemberStatusRepository instead
    // This repository should only handle Status entity operations
}
