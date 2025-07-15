package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "member_quota_loan")
public class MemberQuotaLoan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @Column(nullable = false)
    private Integer quota;

    @Column(name = "quota_date", nullable = false)
    private LocalDate quotaDate;

    @ManyToOne
    @JoinColumn(name = "id_loan", referencedColumnName = "id")
    private Loan loan;

    public MemberQuotaLoan() {}

    public MemberQuotaLoan(Member member, Integer quota, LocalDate quotaDate, Loan loan) {
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.loan = loan;
    }

    public MemberQuotaLoan(Long id, Member member, Integer quota, LocalDate quotaDate, Loan loan) {
        this.id = id;
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.loan = loan;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }

    public LocalDate getQuotaDate() { return quotaDate; }
    public void setQuotaDate(LocalDate quotaDate) { this.quotaDate = quotaDate; }

    public Loan getLoan() { return loan; }
    public void setLoan(Loan loan) { this.loan = loan; }
}
