# Guide d'utilisation des Repositories Spring Data JPA

Ce document explique comment utiliser et étendre les repositories créés pour le système de bibliothèque.

## Vue d'ensemble

Tous les repositories étendent `JpaRepository<Entity, ID>` qui fournit des méthodes CRUD de base :
- `save(entity)` - Sauvegarde ou met à jour une entité
- `findById(id)` - Recherche par ID
- `findAll()` - Récupère toutes les entités
- `deleteById(id)` - Supprime par ID
- `count()` - Compte le nombre d'entités

## Types de méthodes personnalisées

### 1. Méthodes par convention de nommage

Spring Data JPA génère automatiquement l'implémentation basée sur le nom de la méthode :

```java
// Recherche par propriété simple
Optional<Adherent> findByIdentifiant(String identifiant);
List<Livre> findByTitre(String titre);

// Recherche avec opérateurs
List<Adherent> findByDateNaissanceAfter(LocalDate date);
List<ConfigurationProfil> findByQuotaGreaterThanEqual(Integer quota);

// Recherche par propriété d'entité liée
List<Livre> findByAuteurPrincipalNom(String nomAuteur);
List<Adherent> findByProfilNom(String nomProfil);

// Recherche avec Like et IgnoreCase
List<Auteur> findByNomContainingIgnoreCase(String nom);

// Tri
List<Livre> findAllByOrderByTitreAsc();

// Existence et comptage
boolean existsByIdentifiant(String identifiant);
long countByProfil(Profil profil);
```

### 2. Requêtes JPQL avec @Query

Pour des requêtes plus complexes :

```java
@Query("SELECT l FROM Livre l WHERE " +
       "LOWER(l.titre) LIKE LOWER(CONCAT('%', :titre, '%')) AND " +
       "LOWER(l.auteurPrincipal.nom) LIKE LOWER(CONCAT('%', :nomAuteur, '%'))")
List<Livre> findByTitreAndAuteur(@Param("titre") String titre, 
                                 @Param("nomAuteur") String nomAuteur);

@Query("SELECT p FROM Pret p WHERE p.dateRetour < CURRENT_TIMESTAMP " +
       "AND p.id NOT IN (SELECT rp.pret.id FROM RetourPret rp)")
List<Pret> findPretsEnRetard();
```

### 3. Requêtes avec agrégation

```java
@Query("SELECT AVG(n.note) FROM Note n WHERE n.livre = :livre")
Double calculateNoteMoyenne(@Param("livre") Livre livre);

@Query("SELECT l FROM Livre l JOIN l.notes n " +
       "GROUP BY l HAVING AVG(n.note) >= :noteMin " +
       "ORDER BY AVG(n.note) DESC")
List<Livre> findLivresBienNotes(@Param("noteMin") Double noteMin);
```

## Exemples d'utilisation pratiques

### Service d'authentification
```java
@Service
public class AuthService {
    @Autowired
    private AdherentRepository adherentRepository;
    
    public Optional<Adherent> authenticate(String identifiant, String password) {
        return adherentRepository.findByIdentifiant(identifiant)
            .filter(adherent -> adherent.getPassword().equals(password));
    }
}
```

### Service de recherche de livres
```java
@Service
public class RechercheService {
    @Autowired
    private LivreRepository livreRepository;
    
    public List<Livre> rechercherLivres(String titre, String auteur) {
        if (titre != null && auteur != null) {
            return livreRepository.findByTitreAndAuteur(titre, auteur);
        } else if (titre != null) {
            return livreRepository.findByTitreContainingIgnoreCase(titre);
        } else if (auteur != null) {
            return livreRepository.findByAuteurPrincipalNom(auteur);
        }
        return livreRepository.findAll();
    }
}
```

### Service de gestion des prêts
```java
@Service
public class PretService {
    @Autowired
    private PretRepository pretRepository;
    @Autowired
    private AdherentRepository adherentRepository;
    
    public List<Pret> getPretsEnRetard() {
        return pretRepository.findPretsEnRetard();
    }
    
    public List<Pret> getHistoriqueAdherent(Integer idAdherent, 
                                            LocalDateTime debut, 
                                            LocalDateTime fin) {
        return pretRepository.findByIdAdherentAndDateBetween(idAdherent, debut, fin);
    }
}
```

## Ajout de nouvelles méthodes

### Étapes pour ajouter une méthode personnalisée :

1. **Méthode par convention** : Ajoutez directement dans l'interface
```java
// Dans AdherentRepository
List<Adherent> findByNomStartingWithIgnoreCase(String prefixe);
```

2. **Méthode avec @Query** : Pour logique complexe
```java
@Query("SELECT a FROM Adherent a WHERE " +
       "YEAR(CURRENT_DATE) - YEAR(a.dateNaissance) BETWEEN :ageMin AND :ageMax")
List<Adherent> findByAgeBetween(@Param("ageMin") int ageMin, @Param("ageMax") int ageMax);
```

3. **Méthode native SQL** : Pour des requêtes très spécifiques
```java
@Query(value = "SELECT * FROM adherent WHERE " +
               "EXTRACT(YEAR FROM age(date_naissance)) >= ?1", 
       nativeQuery = true)
List<Adherent> findMajeursNative(int ageMajeur);
```

## Conventions de nommage Spring Data JPA

| Mot-clé | Exemple | Description |
|---------|---------|-------------|
| `find...By` | `findByNom` | Recherche des entités |
| `read...By` | `readByNom` | Alias de find |
| `get...By` | `getByNom` | Alias de find |
| `count...By` | `countByProfil` | Compte les entités |
| `exists...By` | `existsByIdentifiant` | Vérifie l'existence |
| `delete...By` | `deleteByNom` | Supprime des entités |
| `...First<number>...` | `findFirst10ByNom` | Limite les résultats |
| `...Top<number>...` | `findTop5ByNote` | Alias de First |

### Opérateurs de comparaison

| Opérateur | Exemple | SQL équivalent |
|-----------|---------|----------------|
| `Is`, `Equals` | `findByNomIs` | `= ?` |
| `Not` | `findByNomNot` | `<> ?` |
| `IsNull` | `findByNomIsNull` | `IS NULL` |
| `IsNotNull` | `findByNomIsNotNull` | `IS NOT NULL` |
| `Like` | `findByNomLike` | `LIKE ?` |
| `NotLike` | `findByNomNotLike` | `NOT LIKE ?` |
| `StartingWith` | `findByNomStartingWith` | `LIKE ?%` |
| `EndingWith` | `findByNomEndingWith` | `LIKE %?` |
| `Containing` | `findByNomContaining` | `LIKE %?%` |
| `IgnoreCase` | `findByNomIgnoreCase` | `UPPER(nom) = UPPER(?)` |
| `Between` | `findByDateBetween` | `BETWEEN ? AND ?` |
| `LessThan` | `findByAgeLessThan` | `< ?` |
| `GreaterThan` | `findByAgeGreaterThan` | `> ?` |
| `After` | `findByDateAfter` | `> ?` |
| `Before` | `findByDateBefore` | `< ?` |

## Bonnes pratiques

1. **Utilisez Optional** pour les méthodes qui peuvent ne pas retourner de résultat
2. **Préférez les méthodes par convention** quand c'est possible
3. **Documentez les requêtes complexes** avec des commentaires
4. **Utilisez des paramètres nommés** dans les @Query pour plus de clarté
5. **Pensez aux performances** : ajoutez des index sur les colonnes fréquemment recherchées
6. **Validez les paramètres** dans vos services avant d'appeler les repositories

## Tests des repositories

```java
@DataJpaTest
class AdherentRepositoryTest {
    
    @Autowired
    private TestEntityManager entityManager;
    
    @Autowired
    private AdherentRepository adherentRepository;
    
    @Test
    void testFindByIdentifiant() {
        // Given
        Adherent adherent = new Adherent();
        adherent.setIdentifiant("test123");
        adherent.setNom("Test User");
        entityManager.persistAndFlush(adherent);
        
        // When
        Optional<Adherent> found = adherentRepository.findByIdentifiant("test123");
        
        // Then
        assertThat(found).isPresent();
        assertThat(found.get().getNom()).isEqualTo("Test User");
    }
}
```
