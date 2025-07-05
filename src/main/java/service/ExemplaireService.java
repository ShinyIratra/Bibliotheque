package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ExemplaireRepository;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
public class ExemplaireService {
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public List<Map<String, Object>> getAllExemplaires() {
        return exemplaireRepository.findAll();
    }

    public List<Map<String, Object>> getAllExemplairesDisponibles() {
        return exemplaireRepository.findAllDisponibles();
    }

    public List<Map<String, Object>> getAllExemplairesNonDisponibles() {
        return exemplaireRepository.findAllNonDisponibles();
    }

    public int getLastStatutForExemplaire(int idExemplaire) {
        return exemplaireRepository.getLastStatutForExemplaire(idExemplaire);
    }

    public String getLastStatutNameForExemplaire(int idExemplaire) {
        return exemplaireRepository.getLastStatutNameForExemplaire(idExemplaire);
    }

    public void setStatutExemplaire(int idExemplaire, int idStatut) {
        exemplaireRepository.insertStatutExemplaire(idExemplaire, idStatut);
    }

    public int getStatutIdByNom(String nom) {
        return exemplaireRepository.getStatutIdByNom(nom);
    }

    /**
     * Vérifie si l'exemplaire est autorisé pour la lecture sur place
     * (catégorie de prêt = 'Non Emportable')
     */
    public boolean isLectureSurPlaceAutorisee(int idExemplaire) {
        return exemplaireRepository.isLectureSurPlaceAutorisee(idExemplaire);
    }

    public List<Map<String, Object>> getAllExemplairesNonDisponiblesPourDate(LocalDate date) {
        return exemplaireRepository.getExemplairesNonDisponiblesPourDate(date);
    }

    public List<Map<String, Object>> getExemplairesReservablesPourDate(LocalDate date) {
        return exemplaireRepository.getExemplairesReservablesPourDate(date);
    }

    public List<Map<String, Object>> getAllExemplairesDisponiblesPourPeriode(LocalDate debut, LocalDate fin) {
        return exemplaireRepository.getExemplairesDisponiblesPourPeriode(debut, fin);
    }
}