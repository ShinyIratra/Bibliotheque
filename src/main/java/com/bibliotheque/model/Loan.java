package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "loan")
public class Loan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "id_copy", referencedColumnName = "id")
    private Copy copy;

    @ManyToOne
    @JoinColumn(name = "id_librarian_loan", referencedColumnName = "id")
    private Librarian librarianLoan;

    @Column(name = "loan_date", nullable = false)
    private LocalDate loanDate;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "due_date", nullable = false)
    private LocalDate dueDate;

    @ManyToOne
    @JoinColumn(name = "id_librarian_return", referencedColumnName = "id")
    private Librarian librarianReturn;

    @Column(name = "return_date")
    private LocalDate returnDate;

    public Loan() {}

    public Loan(Member member, Copy copy, Librarian librarianLoan, LocalDate loanDate, LocalDate startDate, LocalDate dueDate, Librarian librarianReturn, LocalDate returnDate) {
        this.member = member;
        this.copy = copy;
        this.librarianLoan = librarianLoan;
        this.loanDate = loanDate;
        this.startDate = startDate;
        this.dueDate = dueDate;
        this.librarianReturn = librarianReturn;
        this.returnDate = returnDate;
    }

    public Loan(Long id, Member member, Copy copy, Librarian librarianLoan, LocalDate loanDate, LocalDate startDate, LocalDate dueDate, Librarian librarianReturn, LocalDate returnDate) {
        this.id = id;
        this.member = member;
        this.copy = copy;
        this.librarianLoan = librarianLoan;
        this.loanDate = loanDate;
        this.startDate = startDate;
        this.dueDate = dueDate;
        this.librarianReturn = librarianReturn;
        this.returnDate = returnDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Copy getCopy() { return copy; }
    public void setCopy(Copy copy) { this.copy = copy; }

    public Librarian getLibrarianLoan() { return librarianLoan; }
    public void setLibrarianLoan(Librarian librarianLoan) { this.librarianLoan = librarianLoan; }

    public LocalDate getLoanDate() { return loanDate; }
    public void setLoanDate(LocalDate loanDate) { this.loanDate = loanDate; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public Librarian getLibrarianReturn() { return librarianReturn; }
    public void setLibrarianReturn(Librarian librarianReturn) { this.librarianReturn = librarianReturn; }

    public LocalDate getReturnDate() { return returnDate; }
    public void setReturnDate(LocalDate returnDate) { this.returnDate = returnDate; }
}