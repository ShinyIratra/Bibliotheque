package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.TypePretRepository;
import java.util.List;
import java.util.Map;

@Service
public class TypePretService {
    @Autowired
    private TypePretRepository typePretRepository;

    public List<Map<String, Object>> getAllTypesPret() {
        return typePretRepository.findAll();
    }
}