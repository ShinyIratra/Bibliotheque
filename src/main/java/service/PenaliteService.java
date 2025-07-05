package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.PenaliteRepository;

@Service
public class PenaliteService {
    @Autowired
    private PenaliteRepository penaliteRepository;

    public void appliquerPenaliteRetard(int idAdherent, String justificatif) {
        penaliteRepository.insertPenalite(1, idAdherent, justificatif); // 1 = Retard
    }
}