package com.bibliotheque.repository;

import com.bibliotheque.model.Book;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookRepository extends JpaRepository<Book, Long> {
    @EntityGraph(attributePaths = {"themes", "author", "bookGenre"})
    @Query("""
        SELECT b FROM Book b
        WHERE 
            (:bookGenreId IS NULL OR b.bookGenre.id = :bookGenreId)
            AND (:authorId IS NULL OR b.author.id = :authorId)
            AND (:editionDateMin IS NULL OR b.editionDate >= :editionDateMin)
            AND (:editionDateMax IS NULL OR b.editionDate <= :editionDateMax)
    """)
    List<Book> findAllWithThemesFiltered(
        @Param("bookGenreId") Long bookGenreId,
        @Param("authorId") Long authorId,
        @Param("editionDateMin") LocalDate editionDateMin,
        @Param("editionDateMax") LocalDate editionDateMax
    );

    Optional<Book> findById(Long id);
}


