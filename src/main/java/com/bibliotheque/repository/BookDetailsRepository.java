package com.bibliotheque.repository;

import com.bibliotheque.model.BookDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookDetailsRepository extends JpaRepository<BookDetails, Long> {
    // ...custom queries if needed...
}
