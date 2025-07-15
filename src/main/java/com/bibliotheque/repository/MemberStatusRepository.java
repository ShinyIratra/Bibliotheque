package com.bibliotheque.repository;

import com.bibliotheque.model.*;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberStatusRepository extends JpaRepository<MemberStatus, Long> {
    Optional<MemberStatus> findTopByMemberIdOrderByStatusDateDesc(Long memberId);
}
