package com.bibliotheque.repository;
import com.bibliotheque.model.Before;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface BeforeRepository extends JpaRepository<Before, Long>{
    @Query("SELECT b FROM Before b WHERE b.id = 1") // ou LIMIT 1
    Optional<Before> getUniqueFlag();
}
