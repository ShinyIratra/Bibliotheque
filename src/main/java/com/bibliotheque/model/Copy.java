package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "copy")
public class Copy {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_book", referencedColumnName = "id")
    private Book book;

    @Column(name = "copy_id", nullable = false)
    private Integer copyId;

    public Copy() {}

    public Copy(Book book, Integer copyId) {
        this.book = book;
        this.copyId = copyId;
    }

    public Copy(Long id, Book book, Integer copyId) {
        this.id = id;
        this.book = book;
        this.copyId = copyId;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public Integer getCopyId() { return copyId; }
    public void setCopyId(Integer copyId) { this.copyId = copyId; }
}