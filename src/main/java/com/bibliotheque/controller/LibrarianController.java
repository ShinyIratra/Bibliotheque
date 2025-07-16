package com.bibliotheque.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;

import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.List;
import java.time.format.DateTimeParseException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bibliotheque.model.Librarian;
import com.bibliotheque.service.*;

@Controller
public class LibrarianController {

    @Autowired 
    LibrarianService librarianService;

    @GetMapping("/librarian")
    public String librarian(Model model, HttpSession session) {
        Long reservedBookId = (Long) session.getAttribute("reservedBookId");
        if (reservedBookId != null) {
            model.addAttribute("book", librarianService.getBookById(reservedBookId));
            session.removeAttribute("reservedBookId"); // nettoyage
        }
        Long readBookId = (Long) session.getAttribute("book_read");
        if (readBookId != null) {
            model.addAttribute("book_read", librarianService.getBookById(readBookId));
            session.removeAttribute("book_read"); // nettoyage
        }

        model.addAttribute("subscribptionTypes", librarianService.getAllSubscribptionTypes());
        model.addAttribute("members", librarianService.getAllMembers());
        model.addAttribute("loans", librarianService.getAllLoansDue());
        model.addAttribute("reservations", librarianService.getAllReservationsUntreat());
        model.addAttribute("extensions", librarianService.getAllExtensionsUntreat());
        
        // Ajouter la date d'aujourd'hui pour les formulaires de retour
        model.addAttribute("today", LocalDate.now().toString());

        // Gestion des erreurs stockées en session
        String error = (String) session.getAttribute("error");
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("error"); // nettoyage après affichage
        }

        return "librarian";
    }

    @PostMapping("/extension-librarian")
    public String handleExtension(
            @RequestParam("extension") String extension,
            @RequestParam(value = "decision") String decision, 
            HttpSession session) {
        try {
            Long idExtension = Long.parseLong(extension); 
            Long idlibrarian = (Long) session.getAttribute("sessionLibrarian");
            if ("approve".equals(decision)) {
                librarianService.approveExtension(idExtension, idlibrarian);
            } else if ("decline".equals(decision)) {
                librarianService.declineExtension(idExtension, idlibrarian);
            }
        }catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid extension ID.");
        } 
        catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/librarian";
    }

    @PostMapping("/reservation-librarian")
    public String handleReservation(
            @RequestParam("reservation") String reservation,
            @RequestParam(value = "decision") String decision, 
            HttpSession session) {
        try {
            Long idReservation = Long.parseLong(reservation); 
            Long idlibrarian = (Long) session.getAttribute("sessionLibrarian");
            if ("approve".equals(decision)) {
                librarianService.approveReservation(idReservation, idlibrarian);
            } else if ("decline".equals(decision)) {
                librarianService.declineReservation(idReservation, idlibrarian);
            }
        }catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid reservation ID.");
        }
         catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/librarian";
    }


    @PostMapping("/form-loan")
    public String formLoan(@RequestParam("book") String book, HttpSession session) {
        try {
            Long id = Long.parseLong(book);
            session.setAttribute("reservedBookId", id);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid book ID.");
        }
        return "redirect:/librarian";
    }

    @PostMapping("/form-read")
    public String formRead(@RequestParam("book_read") String book, HttpSession session) {
        try {
            Long id = Long.parseLong(book);
            session.setAttribute("book_read", id);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid book ID.");
        }
        return "redirect:/librarian";
    }

    @PostMapping("/loan")
    public String loan(@RequestParam("username") String username, 
                       @RequestParam("book") String book, 
                       @RequestParam("duration") String duration,
                       @RequestParam("loan_date") String loanDate,
                       HttpSession session) {
        try {
            Long idBook = Long.parseLong(book);
            int loanDuration = Integer.parseInt(duration);
            LocalDate loanDateParsed = LocalDate.parse(loanDate);
            librarianService.loan(username, idBook, loanDuration, loanDateParsed, (Long)session.getAttribute("sessionLibrarian"));
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for book ID or duration.");
        } catch (DateTimeParseException e) {
            session.setAttribute("error", "Invalid date format for loan date.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/librarian";
    }

    @PostMapping("/read")
    public String read(@RequestParam("username") String username, 
                       @RequestParam("book") String book,
                       HttpSession session) {
        try {
            Long idBook = Long.parseLong(book);
            librarianService.read(username, idBook, (Long)session.getAttribute("sessionLibrarian"));
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for book ID.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/librarian";
    }

    @PostMapping("/return-loan")
    public String returnLoan(@RequestParam("loan") String loan, 
                           @RequestParam("return_date") String returnDate,
                           HttpSession session) {
        try {
            Long idLoan = Long.parseLong(loan);
            LocalDate returnDateParsed = LocalDate.parse(returnDate);
            librarianService.returnLoan(idLoan, (Long)session.getAttribute("sessionLibrarian"), returnDateParsed);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid format for loan.");
        } catch (DateTimeParseException e) {
            session.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/librarian";
    }

    @PostMapping("/subscribe")
    public String subscribe(@RequestParam("username") String username, 
                            @RequestParam("subscription_type") String subscription_type,
                            @RequestParam("start_date") String startDate,
                            HttpSession session) {
        Long subscriptionTypeId = null;
        LocalDate startDateParsed = null;

        try {
            subscriptionTypeId = Long.parseLong(subscription_type);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid subscription type ID");
            return "redirect:/librarian";
        }

        try {
            startDateParsed = LocalDate.parse(startDate);
        } catch (Exception e) {
            session.setAttribute("error", "Invalid start date format");
            return "redirect:/librarian";
        }
        try {
            librarianService.subscribe(username, subscriptionTypeId, (Long) session.getAttribute("sessionLibrarian"), startDateParsed);
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
            return "redirect:/librarian";
        }
        return "redirect:/librarian";
    }

}
