package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "member_type")
public class MemberType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String value;

    @Column(name = "quota_loan", nullable = false)
    private Integer quotaLoan;

    @Column(name = "quota_reservation", nullable = false)
    private Integer quotaReservation;

    @Column(name = "quota_extension", nullable = false)
    private Integer quotaExtension;

    @Column(name = "loan_duration", nullable = false)
    private Integer loanDuration;

    @Column(name = "extension_duration", nullable = false)
    private Integer extensionDuration;

    @Column(name = "penality_duration", nullable = false)
    private Integer penalityDuration;

    public MemberType() {}

   public MemberType(String value, Integer quotaLoan, Integer quotaReservation, Integer quotaExtension,
            Integer loanDuration, Integer extensionDuration, Integer penalityDuration) {
        this.value = value;
        this.quotaLoan = quotaLoan;
        this.quotaReservation = quotaReservation;
        this.quotaExtension = quotaExtension;
        this.loanDuration = loanDuration;
        this.extensionDuration = extensionDuration;
        this.penalityDuration = penalityDuration;
    }

    public MemberType(Long id, String value, Integer quotaLoan, Integer quotaReservation, Integer quotaExtension,
            Integer loanDuration, Integer extensionDuration, Integer penalityDuration) {
        this.id = id;
        this.value = value;
        this.quotaLoan = quotaLoan;
        this.quotaReservation = quotaReservation;
        this.quotaExtension = quotaExtension;
        this.loanDuration = loanDuration;
        this.extensionDuration = extensionDuration;
        this.penalityDuration = penalityDuration;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getValue() { return value; }
    public void setValue(String value) { this.value = value; }

    public Integer getQuotaLoan() { return quotaLoan; }
    public void setQuotaLoan(Integer quotaLoan) { this.quotaLoan = quotaLoan; }

    public Integer getQuotaReservation() { return quotaReservation; }
    public void setQuotaReservation(Integer quotaReservation) { this.quotaReservation = quotaReservation; }

    public Integer getQuotaExtension() { return quotaExtension; }
    public void setQuotaExtension(Integer quotaExtension) { this.quotaExtension = quotaExtension; }

    public Integer getLoanDuration() { return loanDuration; }
    public void setLoanDuration(Integer loanDuration) { this.loanDuration = loanDuration; }

    public Integer getExtensionDuration() { return extensionDuration; }
    public void setExtensionDuration(Integer extensionDuration) { this.extensionDuration = extensionDuration; }

    public Integer getPenalityDuration() {
        return penalityDuration;
    }

    public void setPenalityDuration(Integer penalityDuration) {
        this.penalityDuration = penalityDuration;
    }
}
