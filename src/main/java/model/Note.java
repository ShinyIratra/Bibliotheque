package model;

public class Note {
    private int id_note;
    private int note;
    private String commentaire;
    private int id_adherent;
    private int id_livre;

    // Getters et setters
    public int getId_note() { return id_note; }
    public void setId_note(int id_note) { this.id_note = id_note; }
    public int getNote() { return note; }
    public void setNote(int note) { this.note = note; }
    public String getCommentaire() { return commentaire; }
    public void setCommentaire(String commentaire) { this.commentaire = commentaire; }
    public int getId_adherent() { return id_adherent; }
    public void setId_adherent(int id_adherent) { this.id_adherent = id_adherent; }
    public int getId_livre() { return id_livre; }
    public void setId_livre(int id_livre) { this.id_livre = id_livre; }
}