package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "subscription")
public class Subscription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "id_subscription_type", referencedColumnName = "id")
    private SubscriptionType subscriptionType;

    @ManyToOne
    @JoinColumn(name = "id_librarian", referencedColumnName = "id")
    private Librarian librarian;

    @Column(name = "subscription_date", nullable = false)
    private LocalDate subscriptionDate;

    @Column(name = "subscription_start", nullable = false)
    private LocalDate subscriptionStart;

    @Column(name = "subscription_end", nullable = false)
    private LocalDate subscriptionEnd;

    public Subscription() {}

    public Subscription(Member member, SubscriptionType subscriptionType, Librarian librarian, LocalDate subscriptionDate, LocalDate subscriptionStart, LocalDate subscriptionEnd) {
        this.member = member;
        this.subscriptionType = subscriptionType;
        this.librarian = librarian;
        this.subscriptionDate = subscriptionDate;
        this.subscriptionStart = subscriptionStart;
        this.subscriptionEnd = subscriptionEnd;
    }

    public Subscription(Long id, Member member, SubscriptionType subscriptionType, Librarian librarian, LocalDate subscriptionDate, LocalDate subscriptionStart, LocalDate subscriptionEnd) {
        this.id = id;
        this.member = member;
        this.subscriptionType = subscriptionType;
        this.librarian = librarian;
        this.subscriptionDate = subscriptionDate;
        this.subscriptionStart = subscriptionStart;
        this.subscriptionEnd = subscriptionEnd;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public SubscriptionType getSubscriptionType() { return subscriptionType; }
    public void setSubscriptionType(SubscriptionType subscriptionType) { this.subscriptionType = subscriptionType; }

    public Librarian getLibrarian() { return librarian; }
    public void setLibrarian(Librarian librarian) { this.librarian = librarian; }

    public LocalDate getSubscriptionDate() { return subscriptionDate; }
    public void setSubscriptionDate(LocalDate subscriptionDate) { this.subscriptionDate = subscriptionDate; }

    public LocalDate getSubscriptionStart() { return subscriptionStart; }
    public void setSubscriptionStart(LocalDate subscriptionStart) { this.subscriptionStart = subscriptionStart; }

    public LocalDate getSubscriptionEnd() { return subscriptionEnd; }
    public void setSubscriptionEnd(LocalDate subscriptionEnd) { this.subscriptionEnd = subscriptionEnd; }
}