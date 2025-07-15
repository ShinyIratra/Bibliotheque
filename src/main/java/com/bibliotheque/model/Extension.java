package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "extension")
public class Extension {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_loan", referencedColumnName = "id")
    private Loan loan;

    @Column(name = "extension_date", nullable = false)
    private LocalDate extensionDate;

    @Column(name = "actual_due_date", nullable = false)
    private LocalDate actualDueDate;

    @Column(name = "ask_due_date", nullable = false)
    private LocalDate askDueDate;

    @ManyToOne
    @JoinColumn(name = "id_librarian", referencedColumnName = "id")
    private Librarian librarian;

    @Column(name = "treatment_date")
    private LocalDate treatmentDate;

    @Column(name = "is_allowed")
    private Boolean isAllowed;

    public Extension() {}

    public Extension(Loan loan, LocalDate extensionDate, LocalDate actualDueDate, LocalDate askDueDate, Librarian librarian, LocalDate treatmentDate, Boolean isAllowed) {
        this.loan = loan;
        this.extensionDate = extensionDate;
        this.actualDueDate = actualDueDate;
        this.askDueDate = askDueDate;
        this.librarian = librarian;
        this.treatmentDate = treatmentDate;
        this.isAllowed = isAllowed;
    }

    public Extension(Long id, Loan loan, LocalDate extensionDate, LocalDate actualDueDate, LocalDate askDueDate, Librarian librarian, LocalDate treatmentDate, Boolean isAllowed) {
        this.id = id;
        this.loan = loan;
        this.extensionDate = extensionDate;
        this.actualDueDate = actualDueDate;
        this.askDueDate = askDueDate;
        this.librarian = librarian;
        this.treatmentDate = treatmentDate;
        this.isAllowed = isAllowed;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Loan getLoan() { return loan; }
    public void setLoan(Loan loan) { this.loan = loan; }

    public LocalDate getExtensionDate() { return extensionDate; }
    public void setExtensionDate(LocalDate extensionDate) { this.extensionDate = extensionDate; }

    public LocalDate getActualDueDate() { return actualDueDate; }
    public void setActualDueDate(LocalDate actualDueDate) { this.actualDueDate = actualDueDate; }

    public LocalDate getAskDueDate() { return askDueDate; }
    public void setAskDueDate(LocalDate askDueDate) { this.askDueDate = askDueDate; }

    public Librarian getLibrarian() { return librarian; }
    public void setLibrarian(Librarian librarian) { this.librarian = librarian; }

    public LocalDate getTreatmentDate() { return treatmentDate; }
    public void setTreatmentDate(LocalDate treatmentDate) { this.treatmentDate = treatmentDate; }

    public Boolean getIsAllowed() { return isAllowed; }
    public void setIsAllowed(Boolean isAllowed) { this.isAllowed = isAllowed; }
}