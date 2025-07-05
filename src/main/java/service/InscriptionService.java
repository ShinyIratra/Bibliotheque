package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.InscriptionRepository;
import java.sql.Timestamp;

@Service
public class InscriptionService {
    @Autowired
    private InscriptionRepository inscriptionRepository;

    public boolean hasInscriptionForPeriod(int idAdherent, Timestamp debut, Timestamp fin) {
        return inscriptionRepository.hasInscriptionForPeriod(idAdherent, debut, fin);
    }

    public void creerInscription(Timestamp debut, Timestamp fin, int idAdherent) {
        inscriptionRepository.insert(debut, fin, idAdherent);
    }

    public boolean isActif(int idAdherent) {
        return inscriptionRepository.isActif(idAdherent);
    }
}