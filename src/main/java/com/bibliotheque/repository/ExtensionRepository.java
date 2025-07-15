package com.bibliotheque.repository;

import com.bibliotheque.model.Extension;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ExtensionRepository extends JpaRepository<Extension, Long> {
 @Query("SELECT e FROM Extension e WHERE e.treatmentDate IS NULL")
    List<Extension> findUntreatedExtensions();
}
