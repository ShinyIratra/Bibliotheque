package com.bibliotheque.controller;

import com.bibliotheque.dto.BookWithCopiesDTO;
import com.bibliotheque.service.BookInventoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@RestController
public class BookInventoryController {

    private static final Logger logger = LoggerFactory.getLogger(BookInventoryController.class);

    @Autowired
    private BookInventoryService bookInventoryService;

    @GetMapping("/endpoint/book-inventory")
    public ResponseEntity<?> getBooksWithCopiesAndStatus(
            @RequestParam(name = "date", required = false) String dateParam) {
        
        logger.info("Requête pour obtenir les livres avec exemplaires et statuts - Date: {}", dateParam);
        
        LocalDate date;
        if (dateParam != null && !dateParam.trim().isEmpty()) {
            try {
                date = LocalDate.parse(dateParam, DateTimeFormatter.ISO_LOCAL_DATE);
            } catch (DateTimeParseException e) {
                logger.error("Format de date invalide: {}", dateParam, e);
                return ResponseEntity.badRequest()
                        .body("{\"error\": \"Format de date invalide. Utilisez le format YYYY-MM-DD\"}");
            }
        } else {
            date = LocalDate.now();
        }
        
        try {
            List<BookWithCopiesDTO> books = bookInventoryService.getAllBooksWithCopiesAndStatus(date);
            logger.info("Récupération réussie de {} livres avec leurs exemplaires pour la date {}", 
                       books.size(), date);
            return ResponseEntity.ok(books);
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération des livres avec exemplaires", e);
            return ResponseEntity.internalServerError()
                    .body("{\"error\": \"Erreur interne du serveur\"}");
        }
    }
}
