package com.bibliotheque.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    
    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;
    
    /**
     * Génère un sel aléatoirement
     */
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
     * Hash un mot de passe avec un sel
     */
    public static String hashPassword(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(Base64.getDecoder().decode(salt));
            byte[] hashedPassword = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erreur lors du hashage du mot de passe", e);
        }
    }
    
    /**
     * Vérifie si un mot de passe correspond au hash
     */
    public static boolean verifyPassword(String password, String salt, String hash) {
        String passwordHash = hashPassword(password, salt);
        return passwordHash.equals(hash);
    }
    
    /**
     * Hash un mot de passe avec génération automatique du sel
     * Retourne le format: sel:hash
     */
    public static String hashPasswordWithSalt(String password) {
        String salt = generateSalt();
        String hash = hashPassword(password, salt);
        return salt + ":" + hash;
    }
    
    /**
     * Vérifie un mot de passe contre un hash avec sel intégré
     */
    public static boolean verifyPasswordWithSalt(String password, String saltedHash) {
        try {
            String[] parts = saltedHash.split(":");
            if (parts.length != 2) {
                return false;
            }
            String salt = parts[0];
            String hash = parts[1];
            return verifyPassword(password, salt, hash);
        } catch (Exception e) {
            return false;
        }
    }
}
