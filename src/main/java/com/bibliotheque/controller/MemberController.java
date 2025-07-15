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

import com.bibliotheque.service.*;
@Controller
public class MemberController {

    @Autowired 
    private MemberService memberService;

    @GetMapping("/member")
    public String member(Model model, HttpSession session) {
        Long id = (Long) session.getAttribute("sessionMember");
        model.addAttribute("member", memberService.getCardMember(id));
        model.addAttribute("subscription", memberService.getCurrentSubscription(id));
        model.addAttribute("loans", memberService.getLoansMember(id));

        Long reservedBookId = (Long) session.getAttribute("reservedBookId");
        if (reservedBookId != null) {
            model.addAttribute("book", memberService.getBookById(reservedBookId));
            session.removeAttribute("reservedBookId");
        }

        // Récupérer erreurs depuis la session
        String error = (String) session.getAttribute("error");
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("error"); // Nettoyage après affichage
        }

        return "member";
    }

    @PostMapping("/form-reservation")
    public String formReservation(@RequestParam("book") String book, HttpSession session) {
        try {
            Long id = Long.parseLong(book);
            session.setAttribute("reservedBookId", id);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid book ID.");
        }
        return "redirect:/member";
    }

    @PostMapping("/reservation")
    public String reservation(@RequestParam("book") String book, 
                              @RequestParam("start_date") String startDate, 
                              @RequestParam("duration") String duration, 
                              HttpSession session) {
        try {
            Long idBook = Long.parseLong(book);
            LocalDate start = LocalDate.parse(startDate);
            Integer days = Integer.parseInt(duration);
            Long memberId = (Long) session.getAttribute("sessionMember");
            memberService.reservation(memberId, idBook, start, days);
        } catch (NumberFormatException | DateTimeException e) {
            session.setAttribute("error", "Invalid input format. Please check your entries.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/member";
    }

    @PostMapping("/extension")
    public String extension(@RequestParam("loan") String loan, 
                            @RequestParam("duration") String duration, 
                            HttpSession session) {
        try {
            Long idLoan = Long.parseLong(loan);
            Integer days = Integer.parseInt(duration);
            Long memberId = (Long) session.getAttribute("sessionMember");
            memberService.extension(memberId, idLoan, days);
        } catch (NumberFormatException | DateTimeException e) {
            session.setAttribute("error", "Invalid input format. Please check your entries.");
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        return "redirect:/member";
    }
}
