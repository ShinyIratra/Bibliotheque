package com.bibliotheque.repository;

import com.bibliotheque.model.BookTheme;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookThemeRepository extends JpaRepository<BookTheme, Long> {
}
