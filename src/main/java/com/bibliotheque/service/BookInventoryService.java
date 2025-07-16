package com.bibliotheque.service;

import com.bibliotheque.dto.BookWithCopiesDTO;
import com.bibliotheque.dto.CopyWithStatusDTO;
import com.bibliotheque.model.Book;
import com.bibliotheque.model.Copy;
import com.bibliotheque.repository.BookRepository;
import com.bibliotheque.repository.CopyRepository;
import com.bibliotheque.repository.LoanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookInventoryService {

    @Autowired
    private BookRepository bookRepository;

    @Autowired
    private CopyRepository copyRepository;

    @Autowired
    private LoanRepository loanRepository;

    public List<BookWithCopiesDTO> getAllBooksWithCopiesAndStatus(LocalDate date) {
        List<Book> books = bookRepository.findAll();
        
        return books.stream()
                .map(book -> mapToBookWithCopiesDTO(book, date))
                .collect(Collectors.toList());
    }

    private BookWithCopiesDTO mapToBookWithCopiesDTO(Book book, LocalDate date) {
        List<Copy> copies = copyRepository.findByBookId(book.getId());
        
        List<CopyWithStatusDTO> copyDTOs = copies.stream()
                .map(copy -> mapToCopyWithStatusDTO(copy, date))
                .collect(Collectors.toList());
        
        return new BookWithCopiesDTO(
                book.getId(),
                book.getTitle(),
                book.getAuthor() != null ? book.getAuthor().getName() : "Unknown",
                book.getBookGenre() != null ? book.getBookGenre().getValue() : "Unknown",
                book.getEditionDate(),
                book.getAge(),
                copyDTOs
        );
    }

    private CopyWithStatusDTO mapToCopyWithStatusDTO(Copy copy, LocalDate date) {
        String status = getCopyStatusAtDate(copy, date);
        
        return new CopyWithStatusDTO(
                copy.getId(),
                copy.getCopyId(),
                status
        );
    }

    private String getCopyStatusAtDate(Copy copy, LocalDate date) {
        // Vérifier si l'exemplaire est emprunté à la date donnée
        boolean isLoaned = loanRepository.existsByCopyIdAndDateConflict(copy.getId(), date);
        
        return isLoaned ? "Emprunté" : "Disponible";
    }
}
