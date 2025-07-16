package com.bibliotheque.controller;

import com.bibliotheque.dto.MemberWithDetailsDTO;
import com.bibliotheque.service.MemberInventoryService;
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
public class MemberInventoryController {

    private static final Logger logger = LoggerFactory.getLogger(MemberInventoryController.class);

    @Autowired
    private MemberInventoryService memberInventoryService;

    @GetMapping("/endpoint/members")
    public ResponseEntity<?> getMembersWithDetails(
            @RequestParam(name = "date", required = false) String dateParam) {
        
        logger.info("Requête pour obtenir les adhérents avec détails - Date: {}", dateParam);
        
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
            List<MemberWithDetailsDTO> members = memberInventoryService.getAllMembersWithDetails(date);
            logger.info("Récupération réussie de {} adhérents avec leurs détails pour la date {}", 
                       members.size(), date);
            return ResponseEntity.ok(members);
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération des adhérents avec détails", e);
            return ResponseEntity.internalServerError()
                    .body("{\"error\": \"Erreur interne du serveur\"}");
        }
    }
}
