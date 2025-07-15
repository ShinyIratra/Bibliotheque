package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "penality")
public class Penality {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_loan", referencedColumnName = "id")
    private Loan loan;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;


    public Penality() {}

    public Penality(Loan loan, Member member, LocalDate startDate, LocalDate endDate) {
        this.loan = loan;
        this.member = member;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Penality(Long id, Loan loan, Member member, LocalDate startDate, LocalDate endDate) {
        this.id = id;
        this.loan = loan;
        this.member = member;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Loan getLoan() { return loan; }
    public void setLoan(Loan loan) { this.loan = loan; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public LocalDate getstartDate() { return startDate; }
    public void setstartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getendDate() { return endDate; }
    public void setendDate(LocalDate endDate) { this.endDate = endDate; }

}