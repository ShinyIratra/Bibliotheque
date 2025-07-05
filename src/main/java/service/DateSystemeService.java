package service;

import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
public class DateSystemeService {
    private LocalDateTime dateNow = null;

    public LocalDateTime getDateNow() {
        return (dateNow != null) ? dateNow : LocalDateTime.now();
    }

    public void setDateNow(LocalDateTime dateNow) {
        this.dateNow = dateNow;
    }

    public void resetDateNow() {
        this.dateNow = null;
    }
}