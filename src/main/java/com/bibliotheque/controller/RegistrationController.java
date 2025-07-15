package com.bibliotheque.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.bibliotheque.service.*;

@Controller
public class RegistrationController {

    @Autowired 
    private RegistrationService registrationService;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("memberTypes", registrationService.getAllMemberTypes());
        model.addAttribute("subscriptionTypes", registrationService.getAllSubscriptionTypes());
        return "registration";
    }

    @PostMapping("/add-member") 
    public String addMember(
        @RequestParam("email") String email,
        @RequestParam("username") String username,
        @RequestParam("birth") String birth,
        @RequestParam("member_type") String memberTypeStr,
        @RequestParam("subscription_type") String subscriptionTypeStr,
        @RequestParam("password") String password,
        @RequestParam("confirm_password") String confirmPassword,
        Model model, HttpSession session) {

        model.addAttribute("memberTypes", registrationService.getAllMemberTypes());
        model.addAttribute("subscriptionTypes", registrationService.getAllSubscriptionTypes());

        try {
            if (email == null || email.isEmpty() || username == null || username.isEmpty()
                || birth == null || birth.isEmpty()
                || memberTypeStr == null || memberTypeStr.isEmpty()
                || subscriptionTypeStr == null || subscriptionTypeStr.isEmpty()
                || password == null || password.isEmpty()
                || confirmPassword == null || confirmPassword.isEmpty()) {

                model.addAttribute("error", "All fields are required.");
                return "registration";
            }
            Long memberTypeId = Long.parseLong(memberTypeStr);
            Long subscriptionTypeId = Long.parseLong(subscriptionTypeStr);
            LocalDate birthDate = LocalDate.parse(birth);
            Long memberId = registrationService.addMember(
                email, username, birthDate, memberTypeId, subscriptionTypeId, password, confirmPassword
            );
            session.setAttribute("sessionMember", memberId);
            return "redirect:/home"; 
        } catch (DateTimeParseException e) {
            model.addAttribute("error", "Invalid birth date format.");
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Invalid member type or subscription type.");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }

        return "registration";
}

}
