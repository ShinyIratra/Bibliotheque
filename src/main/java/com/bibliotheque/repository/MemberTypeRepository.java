package com.bibliotheque.repository;

import com.bibliotheque.model.MemberType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberTypeRepository extends JpaRepository<MemberType, Long> {
}
