package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "author")
public class Author {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Column(name = "artist_name")
    private String artistName;

    public Author() {}

    public Author(Long id, String name, String artistName) {
        this.id = id;
        this.name = name;
        this.artistName = artistName;
    }

    public Author(String name, String artistName) {
        this.name = name;
        this.artistName = artistName;
    }

    // Getters and setters (à générer si Lombok n’est pas utilisé)

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }
}
