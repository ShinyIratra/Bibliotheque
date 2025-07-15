package com.bibliotheque.repository;

import com.bibliotheque.model.MemberQuotaLoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberQuotaLoanRepository extends JpaRepository<MemberQuotaLoan, Long> {
    @Query("SELECT COALESCE(SUM(m.quota), 0) FROM MemberQuotaLoan m WHERE m.member.id = :memberId")
    int getTotalQuotaVariationByMemberId(@Param("memberId") Long memberId);
// MemberQuotaLoanRepository
@Query("SELECT COALESCE(SUM(mql.quota), 0) FROM MemberQuotaLoan mql WHERE mql.member.id = :idMember")
int getQuotaRemaining(@Param("idMember") Long idMember);
}
