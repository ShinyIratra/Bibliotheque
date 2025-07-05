package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.BlacklistingRepository;
import repository.PenaliteRepository;
import repository.AdherentRepository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Service
public class BlacklistingService {
    private static final int SEUIL_RETARDS = 3; // X retards
    private static final int PERIODE_MOIS = 2;  // Y mois
    private static final int DUREE_BLOCAGE_JOURS = 15; // Durée par défaut

    @Autowired
    private BlacklistingRepository blacklistingRepository;
    @Autowired
    private PenaliteRepository penaliteRepository;
    @Autowired
    private DateSystemeService dateSystemeService;

    public boolean isBlacklisted(int idAdherent) {
        return blacklistingRepository.isBlacklisted(idAdherent, dateSystemeService.getDateNow());
    }

    public void analyseEtBlacklist(int idAdherent) {
        int nbRetards = penaliteRepository.countRetardsRecents(idAdherent, PERIODE_MOIS, dateSystemeService.getDateNow().toLocalDate());
        if (nbRetards >= SEUIL_RETARDS && !isBlacklisted(idAdherent)) {
            int joursBlocage = DUREE_BLOCAGE_JOURS + (nbRetards - SEUIL_RETARDS) * 5;
            LocalDateTime now = dateSystemeService.getDateNow();
            Timestamp debut = Timestamp.valueOf(now);
            Timestamp fin = Timestamp.valueOf(now.plusDays(joursBlocage));
            blacklistingRepository.insert(debut, fin, idAdherent);
            // TODO : Notifier le bibliothécaire (ex: email, log, etc.)
        }
    }
}