package model;

import java.sql.Timestamp;

public class Inscription {
    private int id;
    private Timestamp dateDebut;
    private Timestamp dateFin;
    private int idAdherent;

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Timestamp getDateDebut() { return dateDebut; }
    public void setDateDebut(Timestamp dateDebut) { this.dateDebut = dateDebut; }
    public Timestamp getDateFin() { return dateFin; }
    public void setDateFin(Timestamp dateFin) { this.dateFin = dateFin; }
    public int getIdAdherent() { return idAdherent; }
    public void setIdAdherent(int idAdherent) { this.idAdherent = idAdherent; }
}