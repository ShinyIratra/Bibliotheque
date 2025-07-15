package com.bibliotheque.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.util.List;
import java.time.format.DateTimeParseException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bibliotheque.service.*;

@Controller
public class HomeController {

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
        model.addAttribute("bookGenres", listService.getAllBookGenres());
        model.addAttribute("authors", listService.getAllAuthors());
        model.addAttribute("books", listService.getAllBooksWithThemes(bookGenre, author, editionDateMin, editionDateMax));
        return "home";
    }

    @GetMapping("/avalaibility")
    public String avalaibility(@RequestParam("date_start") String date_start, @RequestParam("book") String book, Model model, HttpSession session) {
        LocalDate startDate = LocalDate.parse(date_start);
    Long bookId = Long.valueOf(book);

    model.addAttribute("bookGenres", listService.getAllBookGenres());
    model.addAttribute("authors", listService.getAllAuthors());
    model.addAttribute("books", List.of(listService.getAvalaibilityBook(startDate, bookId)));
        return "home";
    }
    
}