package com.bibliotheque.repository;

import com.bibliotheque.model.Member;
import com.bibliotheque.model.MemberStatus;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findByUsername(String username);
    Optional<Member> findByEmail(String email);
    Optional<Member> findByUsernameAndPassword(String email, String password);
    
}
