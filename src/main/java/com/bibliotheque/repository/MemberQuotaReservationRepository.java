package com.bibliotheque.repository;

import com.bibliotheque.model.MemberQuotaReservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberQuotaReservationRepository extends JpaRepository<MemberQuotaReservation, Long> {
    @Query("SELECT COALESCE(SUM(m.quota), 0) FROM MemberQuotaReservation m WHERE m.member.id = :memberId")
    int getTotalQuotaVariationByMemberId(@Param("memberId") Long memberId);
@Query("SELECT COALESCE(SUM(mqr.quota), 0) FROM MemberQuotaReservation mqr WHERE mqr.member.id = :idMember")
int sumQuotaByMemberId(@Param("idMember") Long idMember);

}
