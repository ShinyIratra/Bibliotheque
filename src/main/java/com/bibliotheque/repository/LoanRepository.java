package com.bibliotheque.repository;

import com.bibliotheque.model.Loan;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface LoanRepository extends JpaRepository<Loan, Integer> {
    @Query("""
        SELECT CASE WHEN COUNT(l) > 0 THEN true ELSE false END
        FROM Loan l
        WHERE l.copy.id = :copyId
        AND l.startDate <= :date
        AND l.dueDate >= :date
        AND l.returnDate IS NULL
    """)
    boolean existsByCopyIdAndDateConflict(@Param("copyId") Long copyId, @Param("date") LocalDate date);
    List<Loan> findByMemberIdOrderByLoanDateDesc(Long memberId);
    Optional<Loan> findById(Long idLoan);
    @Query("SELECT l FROM Loan l WHERE l.returnDate IS NULL")
    List<Loan> findLoansNotReturned();
}
