package model;

import java.sql.Date;

public class JourFerie {
    private int id_ferie;
    private Date date_ferie;

    public int getId_ferie() { return id_ferie; }
    public void setId_ferie(int id_ferie) { this.id_ferie = id_ferie; }
    public Date getDate_ferie() { return date_ferie; }
    public void setDate_ferie(Date date_ferie) { this.date_ferie = date_ferie; }
}