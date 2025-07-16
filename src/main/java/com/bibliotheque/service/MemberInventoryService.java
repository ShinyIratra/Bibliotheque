package com.bibliotheque.service;

import com.bibliotheque.dto.MemberWithDetailsDTO;
import com.bibliotheque.dto.PenalityDetailDTO;
import com.bibliotheque.model.*;
import com.bibliotheque.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MemberInventoryService {

    private static final Logger logger = LoggerFactory.getLogger(MemberInventoryService.class);

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private PenalityRepository penalityRepository;

    public List<MemberWithDetailsDTO> getAllMembersWithDetails(LocalDate checkDate) {
        logger.info("Récupération de tous les adhérents avec détails pour la date: {}", checkDate);
        
        List<Member> members = memberRepository.findAll();
        
        return members.stream()
                .map(member -> createMemberWithDetailsDTO(member, checkDate))
                .collect(Collectors.toList());
    }

    private MemberWithDetailsDTO createMemberWithDetailsDTO(Member member, LocalDate checkDate) {
        // Vérifier si l'adhérent est actif à la date donnée
        boolean isActive = isActiveMember(member, checkDate);
        
        // Récupérer les pénalités actives à la date donnée
        List<PenalityDetailDTO> penalities = getActivePenalities(member, checkDate);
        
        return new MemberWithDetailsDTO(
                member.getId(),
                member.getEmail(),
                member.getUsername(),
                member.getBirth(),
                member.getRegistrationDate(),
                member.getMemberType() != null ? member.getMemberType().getValue() : "N/A",
                isActive,
                penalities
        );
    }

    private boolean isActiveMember(Member member, LocalDate checkDate) {
        try {
            // Utiliser la méthode optimisée du repository
            List<Subscription> activeSubscriptions = subscriptionRepository
                    .findActiveSubscriptionsForMemberAtDate(member.getId(), checkDate);
            
            return !activeSubscriptions.isEmpty();
        } catch (Exception e) {
            logger.error("Erreur lors de la vérification du statut actif pour le membre {}: {}", 
                        member.getId(), e.getMessage());
            return false;
        }
    }

    private List<PenalityDetailDTO> getActivePenalities(Member member, LocalDate checkDate) {
        try {
            // Utiliser la méthode optimisée du repository
            List<Penality> penalities = penalityRepository
                    .findActivePenalitiesForMemberAtDate(member.getId(), checkDate);
            
            // Convertir en DTO
            return penalities.stream()
                    .map(this::createPenalityDetailDTO)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération des pénalités pour le membre {}: {}", 
                        member.getId(), e.getMessage());
            return List.of();
        }
    }

    private PenalityDetailDTO createPenalityDetailDTO(Penality penality) {
        String bookTitle = null;
        Long loanId = null;
        
        if (penality.getLoan() != null) {
            loanId = penality.getLoan().getId();
            if (penality.getLoan().getCopy() != null && 
                penality.getLoan().getCopy().getBook() != null) {
                bookTitle = penality.getLoan().getCopy().getBook().getTitle();
            }
        }
        
        return new PenalityDetailDTO(
                penality.getId(),
                penality.getstartDate(),
                penality.getendDate(),
                loanId,
                bookTitle
        );
    }
}
