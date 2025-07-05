package service;

import java.util.List;
import model.Livre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.LivreRepository;

@Service
public class LivreService {
    @Autowired
    private LivreRepository livreRepository;

    public Livre getLivreById(int idLivre) {
        return livreRepository.findById(idLivre);
    }

    public List<Livre> getAllLivres() {
        return livreRepository.findAll();
    }
}