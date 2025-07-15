package com.bibliotheque.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;

@Service
public class ListService {

    @Autowired 
    private BookGenreRepository bookGenreRepository;

    @Autowired
    private AuthorRepository authorRepository;
    
    @Autowired
    private BookRepository bookRepository;


    @Autowired
    private CopyRepository copyRepository;

    @Autowired LoanRepository loanRepository;

    public List<BookGenre> getAllBookGenres() {
        return bookGenreRepository.findAll();
    }
    
    public List<Author> getAllAuthors() {
        return authorRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Book> getAllBooksWithThemes(String bookGenreId, String authorId, String editionDateMin, String editionDateMax) {
        Long bookGenreLong = (bookGenreId == null || bookGenreId.isEmpty()) ? null : Long.valueOf(bookGenreId);
        Long authorLong = (authorId == null || authorId.isEmpty()) ? null : Long.valueOf(authorId);
        LocalDate dateMin = (editionDateMin == null || editionDateMin.isEmpty()) ? null : LocalDate.parse(editionDateMin);
        LocalDate dateMax = (editionDateMax == null || editionDateMax.isEmpty()) ? null : LocalDate.parse(editionDateMax);
        List<Book> books =  bookRepository.findAllWithThemesFiltered(bookGenreLong, authorLong, dateMin, dateMax);
        for (Book b : books) {
            b.getThemes().size();
        }
        return books;
    }

    @Transactional(readOnly = true)
    public Book getAvalaibilityBook(LocalDate date, Long bookId) {
        Book book = bookRepository.findById(bookId)
            .orElseThrow(() -> new RuntimeException("Book not found: id=" + bookId));

        // Forcer chargement des thèmes si lazy
        book.getThemes().size();

        // Nombre total de copies
        List<Copy> copies = copyRepository.findByBookId(bookId);

        boolean available = false;
        for (Copy copy : copies) {
            // Vérifier si cette copie est occupée à la date donnée
            boolean isTaken = loanRepository.existsByCopyIdAndDateConflict(copy.getId(), date);
            if (!isTaken) {
                available = true;
                break;
            }
        }

        book.setCheckDate(date);
        book.setAvailable(available);

        return book;
    }



}
