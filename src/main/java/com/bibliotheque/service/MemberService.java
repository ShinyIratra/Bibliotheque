package com.bibliotheque.service;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;

@Service
public class MemberService {

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private CopyRepository copyRepository;

    @Autowired
    private MemberQuotaLoanRepository memberQuotaLoanRepository;

    @Autowired
    private MemberQuotaReservationRepository memberQuotaReservationRepository;

    @Autowired
    private MemberQuotaExtensionRepository memberQuotaExtensionRepository;

    @Autowired
    private LoanRepository loanRepository;

    @Autowired
    private MemberStatusRepository memberStatusRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private ExtensionRepository extensionRepository;

    @Transactional(readOnly = true)
    public Member getCardMember(Long id) {
        Member member = memberRepository.findById(id).orElseThrow(() -> new RuntimeException("Member not found"));

        // Calcul des quotas dynamiques
        int loanQuota = member.getMemberType().getQuotaLoan();
        int resQuota = member.getMemberType().getQuotaReservation();
        int extQuota = member.getMemberType().getQuotaExtension();

        loanQuota += memberQuotaLoanRepository.getTotalQuotaVariationByMemberId(id);
        resQuota += memberQuotaReservationRepository.getTotalQuotaVariationByMemberId(id);
        extQuota += memberQuotaExtensionRepository.getTotalQuotaVariationByMemberId(id);

        // Mise à jour des valeurs dans l'objet MemberType (virtuel pour l'affichage)
        member.getMemberType().setQuotaLoan(loanQuota);
        member.getMemberType().setQuotaReservation(resQuota);
        member.getMemberType().setQuotaExtension(extQuota);

        return member;
    }

    public Subscription getCurrentSubscription(Long id) {
        return subscriptionRepository.findFirstByMemberIdOrderBySubscriptionDateDesc(id).orElse(null);
    }

    public List<Loan> getLoansMember(Long id) {
        return loanRepository.findByMemberIdOrderByLoanDateDesc(id);
    }

    public Book getBookById(Long id) {
        return bookRepository.findById(id).get();
    }

    @Transactional(readOnly = true)
    public Book getAvalaibilityBook(LocalDate date, Long bookId) {
        Book book = bookRepository.findById(bookId)
            .orElseThrow(() -> new RuntimeException("Book not found: id=" + bookId));

        // Forcer chargement des thèmes si lazy
        book.getThemes().size();

        // Nombre total de copies
        List<Copy> copies = copyRepository.findByBookId(bookId);

        boolean available = false;
        for (Copy copy : copies) {
            // Vérifier si cette copie est occupée à la date donnée
            boolean isTaken = loanRepository.existsByCopyIdAndDateConflict(copy.getId(), date);
            if (!isTaken) {
                available = true;
                break;
            }
        }

        book.setCheckDate(date);
        book.setAvailable(available);

        return book;
    }

   @Transactional
    public void reservation(Long idMember, Long idBook, LocalDate startDate, int duration) {
        LocalDate today = LocalDate.now();

        // Récupération du membre
        Member member = memberRepository.findById(idMember)
            .orElseThrow(() -> new RuntimeException("Member not found"));

        // Vérification statut actif
        MemberStatus lastStatus = memberStatusRepository.findTopByMemberIdOrderByStatusDateDesc(idMember)
            .orElseThrow(() -> new RuntimeException("No status found for member"));
        if (lastStatus.getStatus().getId() != 1) {
            throw new RuntimeException("Member is not active");
        }

        // Récupération du livre
        Book book = bookRepository.findById(idBook)
            .orElseThrow(() -> new RuntimeException("Book not found"));

        // Vérification de l'âge
        int age = Period.between(member.getBirth(), today).getYears();
        if (age < book.getAge()) {
            throw new RuntimeException("Member is too young for this book");
        }

        // Vérification durée autorisée
        int maxLoanDuration = member.getMemberType().getLoanDuration();
        if (duration > maxLoanDuration) {
            throw new RuntimeException("Requested duration exceeds allowed loan duration");
        }

        // Vérification quota de réservation
        int quotaLeft = memberQuotaReservationRepository.sumQuotaByMemberId(idMember);
        if (quotaLeft <= 0) {
            throw new RuntimeException("No reservation quota left");
        }

        // Vérification de la disponibilité du livre à la date de début
        List<Copy> copies = copyRepository.findByBookId(idBook);
        boolean isAvailable = copies.stream()
            .anyMatch(copy -> !loanRepository.existsByCopyIdAndDateConflict(copy.getId(), startDate));
        if (!isAvailable) {
            throw new RuntimeException("No available copies at the selected reservation date");
        }

        // Création et insertion de la réservation
        Reservation reservation = new Reservation(
            member,
            book,
            today,
            startDate,
            startDate.plusDays(duration),
            null,
            null,
            null
        );
        reservationRepository.save(reservation);

        // Insertion du quota -1
        MemberQuotaReservation quota = new MemberQuotaReservation();
        quota.setMember(member);
        quota.setQuota(-1);
        quota.setQuotaDate(today);
        quota.setReservation(reservation);
        memberQuotaReservationRepository.save(quota);
    }


    @Transactional
    public void extension(Long idMember, Long idLoan, int duration) {
        LocalDate today = LocalDate.now();

        // Récupération du membre
        Member member = memberRepository.findById(idMember)
            .orElseThrow(() -> new RuntimeException("Member not found: id=" + idMember));

        // Vérification du statut actif
        Status lastStatus = memberStatusRepository.findTopByMemberIdOrderByStatusDateDesc(idMember)
            .map(MemberStatus::getStatus)
            .orElseThrow(() -> new RuntimeException("No status found for member: " + idMember));
        if (lastStatus.getId() != 1)
            throw new RuntimeException("Member is not active");

        // Récupération du prêt
        Loan loan = loanRepository.findById(idLoan)
            .orElseThrow(() -> new RuntimeException("Loan not found: id=" + idLoan));

        // Vérification durée d’extension autorisée
        int maxExtensionDuration = member.getMemberType().getExtensionDuration();
        if (duration > maxExtensionDuration)
            throw new RuntimeException("Extension duration exceeds allowed limit");

        // Vérification du quota restant
        int totalQuota = memberQuotaExtensionRepository.getQuotaRemaining(idMember);
        if (totalQuota <= 0)
            throw new RuntimeException("No extension quota left");

        // Vérification disponibilité du livre pour l’extension
        LocalDate newDueDate = loan.getDueDate().plusDays(duration);
        boolean conflict = loanRepository.existsByCopyIdAndDateConflict(loan.getCopy().getId(), newDueDate);
        if (conflict) {
            throw new RuntimeException("The book is not available for the extended duration");
        }

        // Insertion de l'extension
        Extension extension = new Extension();
        extension.setLoan(loan);
        extension.setExtensionDate(today);
        extension.setActualDueDate(loan.getDueDate());
        extension.setAskDueDate(newDueDate);
        extension.setLibrarian(null);
        extension.setTreatmentDate(null);
        extension.setIsAllowed(null);
        extensionRepository.save(extension);

        // Insertion dans le quota
        MemberQuotaExtension quota = new MemberQuotaExtension();
        quota.setMember(member);
        quota.setQuota(-1);
        quota.setQuotaDate(today);
        quota.setExtension(extension);
        memberQuotaExtensionRepository.save(quota);
    }

}
