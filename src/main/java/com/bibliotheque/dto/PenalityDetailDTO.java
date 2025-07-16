package com.bibliotheque.dto;

import java.time.LocalDate;

public class PenalityDetailDTO {
    private Long id;
    private LocalDate startDate;
    private LocalDate endDate;
    private Long loanId;
    private String bookTitle; // Si on veut inclure le titre du livre concerné

    public PenalityDetailDTO() {}

    public PenalityDetailDTO(Long id, LocalDate startDate, LocalDate endDate, Long loanId, String bookTitle) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.loanId = loanId;
        this.bookTitle = bookTitle;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public Long getLoanId() { return loanId; }
    public void setLoanId(Long loanId) { this.loanId = loanId; }

    public String getBookTitle() { return bookTitle; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
}
