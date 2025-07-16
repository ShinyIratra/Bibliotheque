package com.bibliotheque.dto;

public class CopyWithStatusDTO {
    private Long id;
    private Integer copyId;
    private String status;

    public CopyWithStatusDTO() {}

    public CopyWithStatusDTO(Long id, Integer copyId, String status) {
        this.id = id;
        this.copyId = copyId;
        this.status = status;
    }

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Integer getCopyId() { return copyId; }
    public void setCopyId(Integer copyId) { this.copyId = copyId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
