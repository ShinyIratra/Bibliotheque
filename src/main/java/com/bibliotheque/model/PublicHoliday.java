package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "public_holiday")
public class PublicHoliday {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(name = "date_holiday", nullable = false)
    private LocalDate dateHoliday;

    public PublicHoliday() {}

    public PublicHoliday(String name, LocalDate dateHoliday) {
        this.name = name;
        this.dateHoliday = dateHoliday;
    }

    public PublicHoliday(Long id, String name, LocalDate dateHoliday) {
        this.id = id;
        this.name = name;
        this.dateHoliday = dateHoliday;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public LocalDate getDateHoliday() { return dateHoliday; }
    public void setDateHoliday(LocalDate dateHoliday) { this.dateHoliday = dateHoliday; }
}