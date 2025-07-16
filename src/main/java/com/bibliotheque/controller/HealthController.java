package com.bibliotheque.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bibliotheque.service.ListService;

import javax.sql.DataSource;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HealthController {

    private static final Logger logger = LoggerFactory.getLogger(HealthController.class);

    @Autowired
    private DataSource dataSource;

    @Autowired
    private ListService listService;

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> status = new HashMap<>();
        boolean healthy = true;

        try {
            // Test de connexion à la base de données
            try (Connection connection = dataSource.getConnection()) {
                status.put("database", "UP");
                logger.debug("Connexion à la base de données réussie");
            } catch (Exception e) {
                status.put("database", "DOWN");
                status.put("database_error", e.getMessage());
                healthy = false;
                logger.error("Erreur de connexion à la base de données", e);
            }

            // Test des services principaux
            try {
                listService.getAllBookGenres();
                status.put("services", "UP");
                logger.debug("Services fonctionnels");
            } catch (Exception e) {
                status.put("services", "DOWN");
                status.put("services_error", e.getMessage());
                healthy = false;
                logger.error("Erreur dans les services", e);
            }

            status.put("status", healthy ? "UP" : "DOWN");
            status.put("timestamp", LocalDateTime.now());
            status.put("application", "Bibliothèque Management System");
            status.put("version", "1.0-SNAPSHOT");

            return healthy ? ResponseEntity.ok(status) : ResponseEntity.status(503).body(status);

        } catch (Exception e) {
            logger.error("Erreur lors du check de santé", e);
            status.put("status", "DOWN");
            status.put("error", "Erreur système: " + e.getMessage());
            status.put("timestamp", LocalDateTime.now());
            return ResponseEntity.status(500).body(status);
        }
    }

    @GetMapping("/info")
    public ResponseEntity<Map<String, Object>> info() {
        Map<String, Object> info = new HashMap<>();
        info.put("application", "Bibliothèque Management System");
        info.put("version", "1.0-SNAPSHOT");
        info.put("timestamp", LocalDateTime.now());
        info.put("java_version", System.getProperty("java.version"));
        info.put("spring_version", "5.3.30");
        return ResponseEntity.ok(info);
    }
}
