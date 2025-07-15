package com.bibliotheque.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "member_quota_extension")
public class MemberQuotaExtension {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_member", referencedColumnName = "id")
    private Member member;

    @Column(nullable = false)
    private Integer quota;

    @Column(name = "quota_date", nullable = false)
    private LocalDate quotaDate;

    @ManyToOne
    @JoinColumn(name = "id_extension", referencedColumnName = "id")
    private Extension extension;

    public MemberQuotaExtension() {}

    public MemberQuotaExtension(Member member, Integer quota, LocalDate quotaDate, Extension extension) {
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.extension = extension;
    }

    public MemberQuotaExtension(Long id, Member member, Integer quota, LocalDate quotaDate, Extension extension) {
        this.id = id;
        this.member = member;
        this.quota = quota;
        this.quotaDate = quotaDate;
        this.extension = extension;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Member getMember() { return member; }
    public void setMember(Member member) { this.member = member; }

    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }

    public LocalDate getQuotaDate() { return quotaDate; }
    public void setQuotaDate(LocalDate quotaDate) { this.quotaDate = quotaDate; }

    public Extension getExtension() { return extension; }
    public void setExtension(Extension extension) { this.extension = extension; }
}
