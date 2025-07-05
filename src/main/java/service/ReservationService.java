package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ReservationRepository;
import repository.PretRepository;
import repository.ProfilRepository;
import repository.InscriptionRepository;
import repository.ExemplaireRepository;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;
    @Autowired
    private ProfilRepository profilRepository;
    @Autowired
    private InscriptionRepository inscriptionRepository;
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public boolean isQuotaReservationDepasse(int idAdherent) {
        int nbReservations = reservationRepository.countReservationsEnCoursByAdherent(idAdherent);
        int idProfil = profilRepository.getProfilIdByAdherent(idAdherent);
        int quota = profilRepository.getQuotaReservationByProfil(idProfil);
        return nbReservations >= quota;
    }

    public boolean isAdherentActif(int idAdherent) {
        return inscriptionRepository.isActif(idAdherent);
    }

    public boolean isExemplaireReservable(int idExemplaire) {
        // Vérifie la catégorie de prêt de l'exemplaire
        return reservationRepository.isExemplaireReservable(idExemplaire);
    }

    public void reserver(int idAdherent, int idExemplaire) {
        reservationRepository.insertReservation(idAdherent, idExemplaire);
    }
}