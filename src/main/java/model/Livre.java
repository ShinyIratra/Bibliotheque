package model;

public class Livre {
    private int id_livre;
    private String titre;
    // Ajoute d'autres champs si besoin (ex: auteur, année, etc.)

    public int getId_livre() {
        return id_livre;
    }

    public void setId_livre(int id_livre) {
        this.id_livre = id_livre;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }
}