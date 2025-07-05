package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.HistoriquePretRepository;

import java.util.List;
import java.util.Map;

@Service
public class HistoriquePretService {

    @Autowired
    private HistoriquePretRepository historiquePretRepository;

    public List<Map<String, Object>> getHistoriqueByAdherent(int idAdherent) {
        return historiquePretRepository.getHistoriqueByAdherent(idAdherent);
    }
}