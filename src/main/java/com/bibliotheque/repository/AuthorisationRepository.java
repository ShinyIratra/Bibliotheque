package com.bibliotheque.repository;

import com.bibliotheque.model.Authorisation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorisationRepository extends JpaRepository<Authorisation, Long> {
// AuthorisationRepository
boolean existsByMemberTypeIdAndBookId(Long memberTypeId, Long bookId);
}
