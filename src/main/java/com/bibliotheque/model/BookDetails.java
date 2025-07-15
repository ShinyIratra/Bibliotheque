package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "book_details")
public class BookDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_book", referencedColumnName = "id")
    private Book book;

    @ManyToOne
    @JoinColumn(name = "id_book_theme", referencedColumnName = "id")
    private BookTheme bookTheme;

    public BookDetails() {}

    public BookDetails(Book book, BookTheme bookTheme) {
        this.book = book;
        this.bookTheme = bookTheme;
    }

    public BookDetails(Long id, Book book, BookTheme bookTheme) {
        this.id = id;
        this.book = book;
        this.bookTheme = bookTheme;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public BookTheme getBookTheme() { return bookTheme; }
    public void setBookTheme(BookTheme bookTheme) { this.bookTheme = bookTheme; }
}