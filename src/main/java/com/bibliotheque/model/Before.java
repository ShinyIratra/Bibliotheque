package com.bibliotheque.model;

import javax.persistence.*;

@Entity
@Table(name = "before")
public class Before {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private boolean value;

    public Before() {
    }

    public Before(Long id, boolean value) {
        this.id = id;
        this.value = value;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean isValue() {
        return value;
    }

    public void setValue(boolean value) {
        this.value = value;
    }
}
