package com.bibliotheque.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;

@Service
public class LibrarianService {

    @Autowired
    private SubscriptionTypeRepository subscriptionTypeRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private LibrarianRepository librarianRepository;

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private MemberStatusRepository memberStatusRepository;

    @Autowired
    private LoanRepository loanRepository;

    @Autowired
    private CopyRepository copyRepository;

    @Autowired
    private MemberQuotaLoanRepository memberQuotaLoanRepository;

    @Autowired
    private PenalityRepository penalityRepository;

    @Autowired 
    private PublicHolidayRepository publicHolidayRepository;

    @Autowired 
    private BeforeRepository beforeRepository;

    @Autowired 
    private StatusRepository statusRepository;

    @Autowired
    private ExtensionRepository extensionRepository;

    @Autowired 
    private ReservationRepository reservationRepository;

    public List<SubscriptionType> getAllSubscribptionTypes() {
        return subscriptionTypeRepository.findAll();
    }

    public Book getBookById(Long id) {
        return bookRepository.findById(id).get();
    }

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }

    public List<Loan> getAllLoansDue() {
        return loanRepository.findLoansNotReturned();
    }

    public List<Reservation> getAllReservationsUntreat() {
        return reservationRepository.findUntreatedReservations();
    }

    public List<Extension> getAllExtensionsUntreat() {
        return extensionRepository.findUntreatedExtensions();
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
    public void approveExtension(Long idExtension, Long idLibrarian) {
        Extension extension = extensionRepository.findById(idExtension)
            .orElseThrow(() -> new RuntimeException("Extension not found: id = " + idExtension));

        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found: id = " + idLibrarian));

        LocalDate treatmentDate = LocalDate.now();
        Long bookId = extension.getLoan().getCopy().getBook().getId();

        // Vérifie disponibilité du livre au jour du traitement
        if (!getAvalaibilityBook(treatmentDate, bookId).isAvailable()) {
            declineExtension(idExtension, idLibrarian); // appel du refus automatique
            return;
        }

        extension.setIsAllowed(true);
        extension.setTreatmentDate(treatmentDate);
        extension.setLibrarian(librarian);
        extensionRepository.save(extension);

        // Mise à jour du prêt
        Loan loan = extension.getLoan();
        loan.setDueDate(extension.getAskDueDate());
        loanRepository.save(loan);
    }


    @Transactional
    public void approveReservation(Long idReservation, Long idLibrarian) {
        Reservation reservation = reservationRepository.findById(idReservation)
            .orElseThrow(() -> new RuntimeException("Reservation not found: id = " + idReservation));

        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found: id = " + idLibrarian));

        Long bookId = reservation.getBook().getId();
        LocalDate startDate = reservation.getAskStartDate();

        // Vérifie la disponibilité du livre à la date demandée
        List<Copy> copies = copyRepository.findByBookId(bookId);
        Copy availableCopy = copies.stream()
            .filter(copy -> !loanRepository.existsByCopyIdAndDateConflict(copy.getId(), startDate))
            .findFirst()
            .orElse(null);

        if (availableCopy == null) {
            // Aucun exemplaire disponible -> refus automatique
            declineReservation(idReservation, idLibrarian);
            return;
        }

        // Définir la date de traitement maintenant
        LocalDate treatmentDate = LocalDate.now();
        reservation.setTreatmentDate(treatmentDate);
        reservation.setLibrarian(librarian);

        // Création du prêt
        Loan loan = new Loan(
            reservation.getMember(),
            availableCopy,
            librarian,
            treatmentDate,
            reservation.getAskStartDate(),
            reservation.getAskDueDate(),
            null,
            null
        );

        loanRepository.save(loan);

        // Lier le prêt à la réservation
        reservation.setLoan(loan);

        // Enregistrer la réservation mise à jour
        reservationRepository.save(reservation);
    }

    @Transactional
    public void declineExtension(Long idExtension, Long idLibrarian) {
        Extension extension = extensionRepository.findById(idExtension)
            .orElseThrow(() -> new RuntimeException("Extension not found: id = " + idExtension));

        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found: id = " + idLibrarian));

        extension.setIsAllowed(false);
        extension.setTreatmentDate(LocalDate.now());
        extension.setLibrarian(librarian);
        extensionRepository.save(extension);
    }


    @Transactional
    public void declineReservation(Long idReservation, Long idLibrarian) {
        Reservation reservation = reservationRepository.findById(idReservation)
            .orElseThrow(() -> new RuntimeException("Reservation not found: id = " + idReservation));

        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found: id = " + idLibrarian));

        reservation.setTreatmentDate(LocalDate.now());
        reservation.setLibrarian(librarian);
        reservationRepository.save(reservation);
    }


    public void subscribe(String username, Long idSubscriptionType, Long idLibrarian, LocalDate startDateInput) {
        // Récupération du membre par username
        Member member = memberRepository.findByUsername(username).get();
        if (member == null) {
            throw new IllegalArgumentException("Member not found");
        }

        // Récupération du type de subscription
        SubscriptionType subscriptionType = subscriptionTypeRepository.findById(idSubscriptionType)
            .orElseThrow(() -> new IllegalArgumentException("SubscriptionType not found"));

        // Récupération du librarian
        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new IllegalArgumentException("Librarian not found"));

        // Calcul de la date de début et fin de subscription
        LocalDate subscriptionStart;
        if (member.getMemberType().getId() == 2L) {  // si statut membre == 2, start date = now
            subscriptionStart = LocalDate.now();
        } else {
            // Récupérer la dernière subscription du membre, triée par endDate décroissant
            Subscription lastSubscription = subscriptionRepository.findTopByMemberOrderBySubscriptionEndDesc(member);
            if (lastSubscription == null) {
                subscriptionStart = LocalDate.now();
            } else {
                subscriptionStart = lastSubscription.getSubscriptionEnd().plusDays(1);
            }
        }

        // La date de fin = date de début + durée (en jours) du type subscription
        LocalDate subscriptionEnd = subscriptionStart.plusDays(subscriptionType.getDuration());

        // La date d'inscription est aujourd'hui
        LocalDate subscriptionDate = LocalDate.now();

        // Création de la nouvelle subscription
        Subscription subscription = new Subscription();
        subscription.setMember(member);
        subscription.setSubscriptionType(subscriptionType);
        subscription.setLibrarian(librarian);
        subscription.setSubscriptionDate(subscriptionDate);
        subscription.setSubscriptionStart(subscriptionStart);
        subscription.setSubscriptionEnd(subscriptionEnd);

        // Sauvegarder la subscription en base
        subscriptionRepository.save(subscription);
    }

    

    private boolean isNonWorkingDay(LocalDate date, List<LocalDate> holidays) {
        DayOfWeek day = date.getDayOfWeek();
        return day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY || holidays.contains(date);
    }

    @Transactional
    public void loan(String username, Long idBook, int loanDuration, LocalDate loanDate, Long idLibrarian) {
        LocalDate today = loanDate;

        // Récupération du membre
        Member member = memberRepository.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("Member not found: " + username));

        Long idMember = member.getId();

        // Vérifie statut actif
        Status lastStatus = memberStatusRepository.findTopByMemberIdOrderByStatusDateDesc(idMember)
            .map(MemberStatus::getStatus)
            .orElseThrow(() -> new RuntimeException("No status found for member"));
        if (lastStatus.getId() != 1)
            throw new RuntimeException("Member is not active");

        // Vérifie âge
        int age = Period.between(member.getBirth(), today).getYears();
        Book book = bookRepository.findById(idBook)
            .orElseThrow(() -> new RuntimeException("Book not found"));
        if (age < book.getAge())
            throw new RuntimeException("Member is too young");

        // Vérifie disponibilité
        Book availableBook = getAvalaibilityBook(today, idBook);
        if (!availableBook.isAvailable())
            throw new RuntimeException("No copy available today");

        // Vérifie durée autorisée
        int maxLoanDuration = member.getMemberType().getLoanDuration();
        if (loanDuration > maxLoanDuration)
            throw new RuntimeException("Loan duration too long");

        // Vérifie quota
        int totalQuota = memberQuotaLoanRepository.getQuotaRemaining(idMember);
        if (totalQuota <= 0)
            throw new RuntimeException("No loan quota left");

        // Sélection copie
        List<Copy> copies = copyRepository.findByBookId(idBook);
        Copy freeCopy = null;
        for (Copy copy : copies) {
            if (!loanRepository.existsByCopyIdAndDateConflict(copy.getId(), today)) {
                freeCopy = copy;
                break;
            }
        }
        if (freeCopy == null)
            throw new RuntimeException("No free copy");

        // Calcul du due date initial
        LocalDate dueDate = today.plusDays(loanDuration);

        // Récupération des jours fériés
        List<LocalDate> holidays = publicHolidayRepository.findAllDates();

        // Récupération de la stratégie before/after
        boolean before = beforeRepository.getUniqueFlag()
            .orElseThrow(() -> new RuntimeException("Missing before flag"))
            .isValue();

        // Correction du due date si jour non ouvré
        while (isNonWorkingDay(dueDate, holidays)) {
            dueDate = before ? dueDate.minusDays(1) : dueDate.plusDays(1);
        }

        // Insertion du prêt
        Loan loan = new Loan();
        loan.setMember(member);
        loan.setCopy(freeCopy);
        loan.setLibrarianLoan(librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found")));
        loan.setLoanDate(today);
        loan.setStartDate(today);
        loan.setDueDate(dueDate);
        loanRepository.save(loan);

        // Ajout quota utilisé
        MemberQuotaLoan quota = new MemberQuotaLoan();
        quota.setMember(member);
        quota.setQuota(-1);
        quota.setQuotaDate(today);
        quota.setLoan(loan);
        memberQuotaLoanRepository.save(quota);
    }

    @Transactional
    public void read(String username, Long idBook, Long idLibrarian) {
        LocalDate today = LocalDate.now();

        // Récupération du membre
        Member member = memberRepository.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("Member not found: " + username));

        Long idMember = member.getId();

        // Vérifie statut actif
        Status lastStatus = memberStatusRepository.findTopByMemberIdOrderByStatusDateDesc(idMember)
            .map(MemberStatus::getStatus)
            .orElseThrow(() -> new RuntimeException("No status found for member"));
        if (lastStatus.getId() != 1)
            throw new RuntimeException("Member is not active");

        // Vérifie âge
        int age = Period.between(member.getBirth(), today).getYears();
        Book book = bookRepository.findById(idBook)
            .orElseThrow(() -> new RuntimeException("Book not found"));
        if (age < book.getAge())
            throw new RuntimeException("Member is too young");

        // Vérifie disponibilité
        Book availableBook = getAvalaibilityBook(today, idBook);
        if (!availableBook.isAvailable())
            throw new RuntimeException("No copy available today");

        // Sélection copie
        List<Copy> copies = copyRepository.findByBookId(idBook);
        Copy freeCopy = null;
        for (Copy copy : copies) {
            if (!loanRepository.existsByCopyIdAndDateConflict(copy.getId(), today)) {
                freeCopy = copy;
                break;
            }
        }
        if (freeCopy == null)
            throw new RuntimeException("No free copy");

        // Calcul du due date initial
        LocalDate dueDate = today;

        // Insertion du prêt
        Loan loan = new Loan();
        loan.setMember(member);
        loan.setCopy(freeCopy);
        loan.setLibrarianLoan(librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found")));
        loan.setLoanDate(today);
        loan.setStartDate(today);
        loan.setDueDate(dueDate);
        loanRepository.save(loan);
    }


    @Transactional
    public void returnLoan(Long idLoan, Long idLibrarian, LocalDate returnDate) {
        // Vérifier si le bibliothécaire existe
        Librarian librarian = librarianRepository.findById(idLibrarian)
            .orElseThrow(() -> new RuntimeException("Librarian not found with id: " + idLibrarian));

        // Récupérer le prêt
        Loan loan = loanRepository.findById(idLoan)
            .orElseThrow(() -> new RuntimeException("Loan not found with id: " + idLoan));

        // Validation de la date de retour
        if (returnDate.isBefore(loan.getStartDate())) {
            throw new RuntimeException("Return date cannot be before the loan start date");
        }

        // Mettre à jour les infos de retour
        loan.setReturnDate(returnDate);
        loan.setLibrarianReturn(librarian);
        loanRepository.save(loan);

        MemberQuotaLoan quota = new MemberQuotaLoan();
        quota.setMember(loan.getMember());
        quota.setQuota(1);
        quota.setQuotaDate(LocalDate.now());
        quota.setLoan(loan);
        memberQuotaLoanRepository.save(quota);

        // Vérifier s'il y a un retard (basé sur la date de retour saisie)
        if (returnDate.isAfter(loan.getDueDate())) {
            Member member = loan.getMember();
            MemberType memberType = member.getMemberType();

            // Durée de la pénalité
            int penalityDuration = memberType.getPenalityDuration();
            LocalDate startDate = returnDate;
            LocalDate endDate = startDate.plusDays(penalityDuration);

            // Insertion pénalité
            Penality penality = new Penality(loan, member, startDate, endDate);
            penalityRepository.save(penality);

            // Insertion du statut -3 dans member_status
            Status status = statusRepository.findById(-3L)
                .orElseThrow(() -> new RuntimeException("Status -3 not found"));

            MemberStatus memberStatus = new MemberStatus();
            memberStatus.setMember(member);
            memberStatus.setStatus(status);
            memberStatus.setStatusDate(returnDate);
            memberStatusRepository.save(memberStatus);
        }
    }

    // Méthode de compatibilité qui utilise la date actuelle
    @Transactional
    public void returnLoan(Long idLoan, Long idLibrarian) {
        returnLoan(idLoan, idLibrarian, LocalDate.now());
    }

}
