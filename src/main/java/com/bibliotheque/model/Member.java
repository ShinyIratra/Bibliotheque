package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "member")
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @ManyToOne
    @JoinColumn(name = "id_member_type", referencedColumnName = "id")
    private MemberType memberType;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(name = "birth", nullable = false)
    private LocalDate birth;

    @Column(name = "registration_date", nullable = false)
    private LocalDate registrationDate;

    public Member() {}

    public Member(String email, MemberType memberType, String username,
            String password, LocalDate birth, LocalDate registrationDate) {
        this.email = email;
        this.memberType = memberType;
        this.username = username;
        this.password = password;
        this.birth = birth;
        this.registrationDate = registrationDate;
    }

    public Member(Long id, String email, MemberType memberType, String username,
            String password, LocalDate birth, LocalDate registrationDate) {
        this.id = id;
        this.email = email;
        this.memberType = memberType;
        this.username = username;
        this.password = password;
        this.birth = birth;
        this.registrationDate = registrationDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public MemberType getMemberType() { return memberType; }
    public void setMemberType(MemberType memberType) { this.memberType = memberType; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public LocalDate getBirth() { return birth; }
    public void setBirth(LocalDate birth) { this.birth = birth; }

    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }

}
