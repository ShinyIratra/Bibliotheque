package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "authorisation")
public class Authorisation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member_type", referencedColumnName = "id")
    private MemberType memberType;

    @ManyToOne
    @JoinColumn(name = "id_book", referencedColumnName = "id")
    private Book book;

    public Authorisation() {}

    public Authorisation(Long id, MemberType memberType, Book book) {
        this.id = id;
        this.memberType = memberType;
        this.book = book;
    }

    public Authorisation(MemberType memberType, Book book) {
        this.memberType = memberType;
        this.book = book;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public MemberType getMemberType() {
        return memberType;
    }

    public void setMemberType(MemberType memberType) {
        this.memberType = memberType;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}