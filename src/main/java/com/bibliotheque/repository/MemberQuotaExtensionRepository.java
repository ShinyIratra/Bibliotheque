package com.bibliotheque.repository;

import com.bibliotheque.model.MemberQuotaExtension;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberQuotaExtensionRepository extends JpaRepository<MemberQuotaExtension, Long> {
    @Query("SELECT COALESCE(SUM(m.quota), 0) FROM MemberQuotaExtension m WHERE m.member.id = :memberId")
    int getTotalQuotaVariationByMemberId(@Param("memberId") Long memberId);
    @Query("SELECT COALESCE(SUM(mqe.quota), 0) FROM MemberQuotaExtension mqe WHERE mqe.member.id = :idMember")
int getQuotaRemaining(@Param("idMember") Long idMember);
}
