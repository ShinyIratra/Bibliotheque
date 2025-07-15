package com.bibliotheque.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;


@Service
public class RegistrationService {

       @Autowired
    private MemberQuotaLoanRepository memberQuotaLoanRepository;

    @Autowired
    private MemberQuotaReservationRepository memberQuotaReservationRepository;

    @Autowired
    private MemberQuotaExtensionRepository memberQuotaExtensionRepository;

    
    @Autowired
    private MemberTypeRepository memberTypeRepository;

    @Autowired
    private SubscriptionTypeRepository subscriptionTypeRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private MemberStatusRepository memberStatusRepository;

    @Autowired
    private StatusRepository statusRepository;

    public List<MemberType> getAllMemberTypes() {
        return memberTypeRepository.findAll();
    }

    public List<SubscriptionType> getAllSubscriptionTypes() {
        return subscriptionTypeRepository.findAll();
    }

    @Transactional
public Long addMember(
        String email,
        String username,
        LocalDate birth,
        Long idMemberType,
        Long idSubscriptionType,
        String password,
        String confirmPassword
) throws Exception {

    if (!password.equals(confirmPassword)) {
        throw new Exception("Password and confirmation do not match");
    }

    if (memberRepository.findByUsername(username).isPresent()) {
        throw new Exception("Username already used: " + username);
    }

    if (memberRepository.findByEmail(email).isPresent()) {
        throw new Exception("Email already used: " + email);
    }

    MemberType memberType = memberTypeRepository.findById(idMemberType)
            .orElseThrow(() -> new Exception("Member type does not exist"));

    SubscriptionType subscriptionType = subscriptionTypeRepository.findById(idSubscriptionType)
            .orElseThrow(() -> new Exception("Subscription type does not exist"));

    Member member = new Member(email, memberType, username, password, birth, LocalDate.now());

    Subscription subscription = new Subscription(
            member,
            subscriptionType,
            null,
            LocalDate.now(),
            LocalDate.now(),
            LocalDate.now().plusDays(subscriptionType.getDuration())
    );

    Status status = statusRepository.findById(1L)
            .orElseThrow(() -> new Exception("Default status not found"));

    MemberStatus memberStatus = new MemberStatus(member, status, LocalDate.now());

    memberRepository.save(member);
    subscriptionRepository.save(subscription);
    memberStatusRepository.save(memberStatus);

    // 🔽 INSERTIONS DES QUOTAS INDIVIDUELS

    MemberQuotaLoan quotaLoan = new MemberQuotaLoan(
            member,
            memberType.getQuotaLoan(),
            LocalDate.now(),
            null  // id_loan encore vide à l’inscription
    );

    MemberQuotaReservation quotaReservation = new MemberQuotaReservation(
            member,
            memberType.getQuotaReservation(),
            LocalDate.now(),
            null // id_reservation
    );

    MemberQuotaExtension quotaExtension = new MemberQuotaExtension(
            member,
            memberType.getQuotaExtension(),
            LocalDate.now(),
            null // id_extension
    );

    memberQuotaLoanRepository.save(quotaLoan);
    memberQuotaReservationRepository.save(quotaReservation);
    memberQuotaExtensionRepository.save(quotaExtension);

    return member.getId();
}


}
