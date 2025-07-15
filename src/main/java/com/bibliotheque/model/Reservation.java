package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reservation")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "id_book", referencedColumnName = "id")
    private Book book;

    @Column(name = "reservation_date", nullable = false)
    private LocalDate reservationDate;

    @Column(name = "ask_start_date", nullable = false)
    private LocalDate askStartDate;

    @Column(name = "ask_due_date", nullable = false)
    private LocalDate askDueDate;

    @ManyToOne
    @JoinColumn(name = "id_librarian", referencedColumnName = "id")
    private Librarian librarian;

    @Column(name = "treatment_date")
    private LocalDate treatmentDate;

    @ManyToOne
    @JoinColumn(name = "id_loan", referencedColumnName = "id")
    private Loan loan;

    public Reservation() {}

    public Reservation(Member member, Book book, LocalDate reservationDate, LocalDate askStartDate, LocalDate askDueDate, Librarian librarian, LocalDate treatmentDate, Loan loan) {
        this.member = member;
        this.book = book;
        this.reservationDate = reservationDate;
        this.askStartDate = askStartDate;
        this.askDueDate = askDueDate;
        this.librarian = librarian;
        this.treatmentDate = treatmentDate;
        this.loan = loan;
    }

    public Reservation(Long id, Member member, Book book, LocalDate reservationDate, LocalDate askStartDate, LocalDate askDueDate, Librarian librarian, LocalDate treatmentDate, Loan loan) {
        this.id = id;
        this.member = member;
        this.book = book;
        this.reservationDate = reservationDate;
        this.askStartDate = askStartDate;
        this.askDueDate = askDueDate;
        this.librarian = librarian;
        this.treatmentDate = treatmentDate;
        this.loan = loan;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public LocalDate getReservationDate() { return reservationDate; }
    public void setReservationDate(LocalDate reservationDate) { this.reservationDate = reservationDate; }

    public LocalDate getAskStartDate() { return askStartDate; }
    public void setAskStartDate(LocalDate askStartDate) { this.askStartDate = askStartDate; }

    public LocalDate getAskDueDate() { return askDueDate; }
    public void setAskDueDate(LocalDate askDueDate) { this.askDueDate = askDueDate; }

    public Librarian getLibrarian() { return librarian; }
    public void setLibrarian(Librarian librarian) { this.librarian = librarian; }

    public LocalDate getTreatmentDate() { return treatmentDate; }
    public void setTreatmentDate(LocalDate treatmentDate) { this.treatmentDate = treatmentDate; }

    public Loan getLoan() { return loan; }
    public void setLoan(Loan loan) { this.loan = loan; }
}
