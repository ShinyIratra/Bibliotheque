<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Fiche Livre</title>
    <style>
        :root {
            --black: #18181b;
            --white: #fff;
            --gray-100: #f4f4f5;
            --gray-200: #e4e4e7;
            --gray-300: #d4d4d8;
            --gray-400: #a1a1aa;
            --gray-700: #3f3f46;
            --accent: #2563eb;
            --danger: #e11d48;
            --shadow: 0 4px 24px #e4e4e7;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: var(--gray-100);
            color: var(--black);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 700px;
            margin: 48px auto;
            background: var(--white);
            padding: 40px 48px 32px 48px;
            border-radius: 14px;
            box-shadow: 0 4px 24px var(--gray-200);
            border: 1px solid var(--gray-200);
        }
        h2, h3, h4 {
            color: var(--black);
        }
        .label {
            font-weight: 600;
        }
        .empty {
            color: var(--gray-400);
            font-style: italic;
            margin: 18px 0;
        }
        .message {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 14px;
        }
        .erreur {
            color: var(--danger);
            font-weight: 600;
            margin-bottom: 14px;
        }
        .note-block {
            border-bottom: 1px solid var(--gray-200);
            margin-bottom: 12px;
            padding-bottom: 8px;
        }
        textarea {
            width: 100%;
            min-height: 60px;
            border-radius: 6px;
            border: 1px solid var(--gray-300);
            padding: 8px;
            background: var(--gray-100);
            color: var(--black);
        }
        form { margin-top: 10px; }
        button {
            background: var(--black);
            color: var(--white);
            border: none;
            padding: 10px 22px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1em;
            cursor: pointer;
            box-shadow: 0 2px 8px var(--gray-200);
            transition: background 0.18s, color 0.18s, transform 0.12s;
        }
        button:hover {
            background: var(--accent);
            color: var(--white);
            transform: translateY(-2px) scale(1.04);
        }
        a {
            color: var(--accent);
            text-decoration: underline;
            font-weight: 500;
            transition: color 0.16s;
        }
        a:hover {
            color: var(--black);
        }
        @media (max-width: 700px) {
            .container { padding: 18px 6vw; }
            h2 { font-size: 1.3em; }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Fiche du livre</h2>
    <div>
        <span class="label">ID :</span> <c:out value="${livre.id_livre}" default="Non renseigné"/><br>
        <span class="label">Titre :</span> <c:out value="${livre.titre}" default="Non renseigné"/><br>
        <%-- Si tu ajoutes d'autres champs dans Livre.java, tu peux les afficher ici --%>
    </div>
    <c:if test="${not empty erreur}">
        <div class="erreur">${erreur}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    <h3>Notes et avis</h3>
    <c:choose>
        <c:when test="${empty notes}">
            <div class="empty">Aucun avis pour ce livre.</div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${notes}" var="n">
                <div class="note-block">
                    <span class="label">Note :</span> <c:out value="${n.note}" default="—"/> / 5<br>
                    <span class="label">Commentaire :</span>
                    <c:choose>
                        <c:when test="${empty n.commentaire}"><span class="empty">Aucun commentaire</span></c:when>
                        <c:otherwise>${n.commentaire}</c:otherwise>
                    </c:choose><br>
                    <c:if test="${sessionScope.nomProfil == 'Bibliothecaire'}">
                        <form action="/note/${n.id_note}/delete" method="post" style="display:inline;">
                            <input type="hidden" name="idLivre" value="${idLivre}" />
                            <button type="submit">Supprimer</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <c:if test="${canNoter}">
        <h4>Donner votre avis</h4>
        <form action="/livre/${idLivre}/noter" method="post">
            <label>Note (1 à 5) :</label>
            <input type="number" name="note" min="1" max="5" required><br>
            <label>Commentaire :</label>
            <textarea name="commentaire" required></textarea><br>
            <button type="submit">Envoyer</button>
        </form>
    </c:if>
    <a href="/front-office">Retour</a>
</div>
</body>
</html>