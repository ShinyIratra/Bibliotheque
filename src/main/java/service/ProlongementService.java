package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ProlongementRepository;
import repository.PretRepository;
import repository.PenaliteRepository;
import repository.ProfilRepository;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Service
public class ProlongementService {
    @Autowired
    private ProlongementRepository prolongementRepository;
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private PenaliteRepository penaliteRepository;
    @Autowired
    private ProfilRepository profilRepository;

    public String prolongerPret(int idPret, int idAdherent) {
        // 1. Vérifier la date de retour (au moins 2 jours avant)
        Timestamp dateRetour = pretRepository.getDateRetourByPret(idPret);
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime retour = dateRetour.toLocalDateTime();
        if (now.plusDays(2).isAfter(retour)) {
            return "La prolongation doit être demandée au moins 2 jours avant la date de retour.";
        }

        // 2. Vérifier pénalité
        int penalites = penaliteRepository.countRetardsRecents(idAdherent, 12); // 12 mois = historique
        if (penalites > 0) {
            return "Vous avez une pénalité en cours. Prolongation impossible.";
        }

        // 3. Vérifier quota de prolongements
        int idProfil = profilRepository.getProfilIdByAdherent(idAdherent);
        int quota = profilRepository.getQuotaByProfil(idProfil);
        int nbProlongements = prolongementRepository.countProlongementsByPret(idPret);
        if (nbProlongements >= quota) {
            return "Vous avez atteint le nombre maximal de prolongements autorisés.";
        }

        // 4. Vérifier réservation par un autre adhérent
        if (pretRepository.isLivreReserveParUnAutre(idPret, idAdherent)) {
            return "Ce livre est réservé par un autre adhérent. Prolongation impossible.";
        }

        // 5. Calculer la nouvelle date de retour (exemple : +7 jours)
        LocalDateTime nouvelleDateRetour = retour.plusDays(7);
        Timestamp nouvelleDateRetourTs = Timestamp.valueOf(nouvelleDateRetour);

        // 6. Mettre à jour la date de retour du prêt
        pretRepository.updateDateRetour(idPret, nouvelleDateRetourTs);

        // 7. Insérer le prolongement
        prolongementRepository.insertProlongement(idPret, nouvelleDateRetourTs);

        return null; // null = succès
    }
}