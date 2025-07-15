package com.bibliotheque.repository;

import com.bibliotheque.model.Copy;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CopyRepository extends JpaRepository<Copy, Long> {
    List<Copy> findByBookId(Long bookId);

}
