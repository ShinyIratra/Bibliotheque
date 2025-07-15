package com.bibliotheque.repository;

import com.bibliotheque.model.Librarian;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface LibrarianRepository extends JpaRepository<Librarian, Long> {
    Optional<Librarian> findByUsernameAndPassword(String email, String password);
// LibrarianRepository
Optional<Librarian> findById(Long id);
}
