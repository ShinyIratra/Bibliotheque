package com.bibliotheque.dto;

import java.time.LocalDate;
import java.util.List;

public class MemberWithDetailsDTO {
    private Long id;
    private String email;
    private String username;
    private LocalDate birth;
    private LocalDate registrationDate;
    private String memberTypeName;
    private boolean isActive;
    private List<PenalityDetailDTO> penalities;

    public MemberWithDetailsDTO() {}

    public MemberWithDetailsDTO(Long id, String email, String username, LocalDate birth, 
                               LocalDate registrationDate, String memberTypeName, boolean isActive, 
                               List<PenalityDetailDTO> penalities) {
        this.id = id;
        this.email = email;
        this.username = username;
        this.birth = birth;
        this.registrationDate = registrationDate;
        this.memberTypeName = memberTypeName;
        this.isActive = isActive;
        this.penalities = penalities;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public LocalDate getBirth() { return birth; }
    public void setBirth(LocalDate birth) { this.birth = birth; }

    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }

    public String getMemberTypeName() { return memberTypeName; }
    public void setMemberTypeName(String memberTypeName) { this.memberTypeName = memberTypeName; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public List<PenalityDetailDTO> getPenalities() { return penalities; }
    public void setPenalities(List<PenalityDetailDTO> penalities) { this.penalities = penalities; }
}
