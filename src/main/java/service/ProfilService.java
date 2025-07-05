package service;

import model.Profil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ProfilRepository;

import java.util.List;

@Service
public class ProfilService {

    @Autowired
    private ProfilRepository profilRepository;

    public List<Profil> getAllProfils() {
        return profilRepository.findAll();
    }

    public String getNomProfilById(int idProfil) {
        return profilRepository.getNomProfilById(idProfil);
    }
}