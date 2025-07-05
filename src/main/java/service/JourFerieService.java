package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.JourFerieRepository;
import java.sql.Date;
import java.util.List;
import model.JourFerie;

@Service
public class JourFerieService {
    @Autowired
    private JourFerieRepository jourFerieRepository;

    public List<JourFerie> getAllJoursFeries() {
        return jourFerieRepository.findAll();
    }

    public void ajouterJourFerie(Date date_ferie) {
        jourFerieRepository.insert(date_ferie);
    }

    public boolean isJourFerie(Date date) {
        return jourFerieRepository.isJourFerie(date);
    }
}