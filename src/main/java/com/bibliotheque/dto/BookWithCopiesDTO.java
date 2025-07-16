package com.bibliotheque.dto;

import java.time.LocalDate;
import java.util.List;

public class BookWithCopiesDTO {
    private Long id;
    private String title;
    private String author;
    private String genre;
    private LocalDate editionDate;
    private Integer age;
    private List<CopyWithStatusDTO> copies;

    public BookWithCopiesDTO() {}

    public BookWithCopiesDTO(Long id, String title, String author, String genre, LocalDate editionDate, Integer age, List<CopyWithStatusDTO> copies) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.editionDate = editionDate;
        this.age = age;
        this.copies = copies;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public LocalDate getEditionDate() { return editionDate; }
    public void setEditionDate(LocalDate editionDate) { this.editionDate = editionDate; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public List<CopyWithStatusDTO> getCopies() { return copies; }
    public void setCopies(List<CopyWithStatusDTO> copies) { this.copies = copies; }
}
