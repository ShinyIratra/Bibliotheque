package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "book")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @ManyToOne
    @JoinColumn(name = "id_author", referencedColumnName = "id")
    private Author author;

    @ManyToOne
    @JoinColumn(name = "id_book_genre", referencedColumnName = "id")
    private BookGenre bookGenre;

    @Column(name = "edition_date", nullable = false)
    private LocalDate editionDate;

    @Column(nullable = false)
    private Integer age;

    @OneToMany(mappedBy = "book") 
    private List<BookDetails> themes;

    @Transient
    private LocalDate checkDate;

    @Transient
    private boolean available;

    public Book() {}

    public Book(String title, Author author, BookGenre bookGenre, LocalDate editionDate, Integer age) {
        this.title = title;
        this.author = author;
        this.bookGenre = bookGenre;
        this.editionDate = editionDate;
        this.age = age;
    }

    public Book(Long id, String title, Author author, BookGenre bookGenre, LocalDate editionDate, Integer age) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.bookGenre = bookGenre;
        this.editionDate = editionDate;
        this.age = age;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Author getAuthor() { return author; }
    public void setAuthor(Author author) { this.author = author; }

    public BookGenre getBookGenre() { return bookGenre; }
    public void setBookGenre(BookGenre bookGenre) { this.bookGenre = bookGenre; }

    public LocalDate getEditionDate() { return editionDate; }
    public void setEditionDate(LocalDate editionDate) { this.editionDate = editionDate; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public List<BookDetails> getThemes() {
        return themes;
    }

    public void setThemes(List<BookDetails> themes) {
        this.themes = themes;
    }

    public LocalDate getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(LocalDate checkDate) {
        this.checkDate = checkDate;
    }


    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}
