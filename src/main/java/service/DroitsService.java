package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.DroitsRepository;

import java.util.Map;

@Service
public class DroitsService {
    @Autowired
    private DroitsRepository droitsRepository;

    public Map<String, Object> getDroitsByProfil(int idProfil) {
        return droitsRepository.getDroitsByProfil(idProfil);
    }
}