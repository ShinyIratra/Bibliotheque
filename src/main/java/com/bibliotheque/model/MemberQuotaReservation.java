package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "member_quota_reservation")
public class MemberQuotaReservation {

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
    @JoinColumn(name = "id_reservation", referencedColumnName = "id")
    private Reservation reservation;

    public MemberQuotaReservation() {}

    public MemberQuotaReservation(Member member, Integer quota, LocalDate quotaDate, Reservation reservation) {
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.reservation = reservation;
    }

    public MemberQuotaReservation(Long id, Member member, Integer quota, LocalDate quotaDate, Reservation reservation) {
        this.id = id;
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.reservation = reservation;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }

    public LocalDate getQuotaDate() { return quotaDate; }
    public void setQuotaDate(LocalDate quotaDate) { this.quotaDate = quotaDate; }

    public Reservation getReservation() { return reservation; }
    public void setReservation(Reservation reservation) { this.reservation = reservation; }
}
