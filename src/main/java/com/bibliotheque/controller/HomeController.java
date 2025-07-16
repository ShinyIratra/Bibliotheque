package com.bibliotheque.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.util.List;
import java.time.format.DateTimeParseException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bibliotheque.service.*;

@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired 
    ListService listService;

    @GetMapping("/home")
    public String home(
            @RequestParam(name = "book_genre", required = false) String bookGenre,
            @RequestParam(name = "author", required = false) String author,
            @RequestParam(name = "edition_date_min", required = false) String editionDateMin,
            @RequestParam(name = "edition_date_max", required = false) String editionDateMax,
            Model model, HttpSession session
    ) {
        logger.info("Accès à la page d'accueil avec filtres - Genre: {}, Auteur: {}, DateMin: {}, DateMax: {}", 
                   bookGenre, author, editionDateMin, editionDateMax);
        try {
            model.addAttribute("bookGenres", listService.getAllBookGenres());
            model.addAttribute("authors", listService.getAllAuthors());
            model.addAttribute("books", listService.getAllBooksWithThemes(bookGenre, author, editionDateMin, editionDateMax));
            logger.debug("Données chargées avec succès pour la page d'accueil");
        } catch (Exception e) {
            logger.error("Erreur lors du chargement des données de la page d'accueil", e);
            model.addAttribute("error", "Une erreur est survenue lors du chargement des données.");
            model.addAttribute("bookGenres", List.of());
            model.addAttribute("authors", List.of());
            model.addAttribute("books", List.of());
        }
        return "home";
    }

    @GetMapping("/availability")
    public String availability(
            @RequestParam("date_start") String dateStart, 
            @RequestParam("book") String book, 
            Model model, HttpSession session
    ) {
        try {
            LocalDate startDate = LocalDate.parse(dateStart);
            Long bookId = Long.valueOf(book);

            model.addAttribute("bookGenres", listService.getAllBookGenres());
            model.addAttribute("authors", listService.getAllAuthors());
            model.addAttribute("books", List.of(listService.getAvailabilityBook(startDate, bookId)));
        } catch (DateTimeParseException e) {
            model.addAttribute("error", "Format de date invalide. Utilisez le format YYYY-MM-DD.");
            model.addAttribute("bookGenres", listService.getAllBookGenres());
            model.addAttribute("authors", listService.getAllAuthors());
            model.addAttribute("books", List.of());
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Identifiant de livre invalide.");
            model.addAttribute("bookGenres", listService.getAllBookGenres());
            model.addAttribute("authors", listService.getAllAuthors());
            model.addAttribute("books", List.of());
        } catch (Exception e) {
            model.addAttribute("error", "Une erreur est survenue lors de la vérification de disponibilité.");
            model.addAttribute("bookGenres", listService.getAllBookGenres());
            model.addAttribute("authors", listService.getAllAuthors());
            model.addAttribute("books", List.of());
        }
        return "home";
    }
    
}