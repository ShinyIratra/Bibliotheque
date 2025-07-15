package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "member_status")
public class MemberStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "id_status", referencedColumnName = "id")
    private Status status;

    @Column(name = "status_date", nullable = false)
    private LocalDate statusDate;

    public MemberStatus() {}

    public MemberStatus(Member member, Status status, LocalDate statusDate) {
        this.member = member;
        this.status = status;
        this.statusDate = statusDate;
    }

    public MemberStatus(Long id, Member member, Status status, LocalDate statusDate) {
        this.id = id;
        this.member = member;
        this.status = status;
        this.statusDate = statusDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public LocalDate getStatusDate() { return statusDate; }
    public void setStatusDate(LocalDate statusDate) { this.statusDate = statusDate; }
}