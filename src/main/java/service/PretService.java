package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.PretRepository;
import repository.AdherentRepository;
import repository.ProfilRepository;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class PretService {
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private AdherentRepository adherentRepository;
    @Autowired
    private ProfilRepository profilRepository;

    public void creerPret(Timestamp datePret, Timestamp dateRetour, int idTypePret, int idExemplaire, int idAdherent) {
        pretRepository.insert(datePret, dateRetour, idTypePret, idExemplaire, idAdherent);
    }

    public boolean isQuotaDepasse(int idAdherent) {
        int nbPrets = pretRepository.countPretsEmportableEnCoursByAdherent(idAdherent);
        int idProfil = adherentRepository.getProfilIdByAdherent(idAdherent);
        int quota = profilRepository.getQuotaByProfil(idProfil);
        return nbPrets >= quota;
    }

    public int getIdExemplaireByPret(int idPret) {
        return pretRepository.getIdExemplaireByPret(idPret);
    }

    public void retourPret(int idPret) {
        pretRepository.insertRetourPret(idPret);
    }

    public List<Map<String, Object>> getPretsEnCoursByAdherent(int idAdherent) {
        return pretRepository.getPretsEnCoursByAdherent(idAdherent);
    }

    public List<Map<String, Object>> getHistoriquePretsByAdherent(int idAdherent) {
        return pretRepository.getHistoriquePretsByAdherent(idAdherent);
    }

    public boolean existePretPourExemplaireSurPeriode(int idExemplaire, LocalDate debut, LocalDate fin) {
        return !pretRepository.isExemplaireDisponibleSurPeriode(idExemplaire, debut, fin);
    }

    public Integer getLastPretIdForAdherent(int idAdherent, int idExemplaire, Timestamp datePret) {
        return pretRepository.getLastPretIdForAdherent(idAdherent, idExemplaire, datePret);
    }
}