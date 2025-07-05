package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.AdherentRepository;

import java.util.List;
import java.util.Map;
import repository.AdherentRepository;

@Service
public class AdherentService {

    @Autowired
    private AdherentRepository adherentRepository;

    public List<String> getAllAdherentNames() {
        // Ici tu pourrais ajouter des règles métier si besoin
        return adherentRepository.findAllNames();
    }

    public void insert(String nom, String identifiant, String password, String dateNaissance, int profilId) {
        adherentRepository.insert(nom, identifiant, password, dateNaissance, profilId);
    }

    // Modifier la méthode authenticate
    public boolean authenticate(String identifiant, String password) {
        return adherentRepository.getByIdentifiantAndPassword(identifiant, password) != null;
    }

    // Modifier la méthode getByIdentifiant
    public Integer getByIdentifiant(String identifiant) {
        return adherentRepository.getByIdentifiant(identifiant);
    }
    
    public int getProfilIdByAdherent(int idAdherent) {
        return adherentRepository.getProfilIdByAdherent(idAdherent);
    }

    public List<Map<String, Object>> getAllAdherentIdentifiantsEtNoms() {
        return adherentRepository.findAllIdentifiantsEtNoms();
    }

}