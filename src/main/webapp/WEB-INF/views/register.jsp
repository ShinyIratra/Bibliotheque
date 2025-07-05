<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
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
            max-width: 500px;
            margin: 48px auto;
            background: var(--white);
            padding: 40px 48px 32px 48px;
            border-radius: 14px;
            box-shadow: 0 4px 24px var(--gray-200);
            border: 1px solid var(--gray-200);
        }
        h2 {
            color: var(--black);
            font-size: 2em;
            font-weight: 700;
            margin-bottom: 28px;
        }
        label {
            display: block;
            margin-top: 12px;
            font-weight: 500;
        }
        input[type="text"], input[type="password"], input[type="date"], select {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 6px;
            border: 1px solid var(--gray-300);
            background: var(--gray-100);
            color: var(--black);
        }
        button {
            margin-top: 16px;
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
        .empty {
            color: var(--gray-400);
            font-style: italic;
        }
        @media (max-width: 700px) {
            .container { padding: 18px 6vw; }
            h2 { font-size: 1.3em; }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Inscription</h2>
    <form action="register" method="post">
        <div>
            <label>Nom complet:</label>
            <input type="text" name="nom" required>
        </div>
        <div>
            <label>Identifiant:</label>
            <input type="text" name="identifiant" required>
        </div>
        <div>
            <label>Mot de passe:</label>
            <input type="password" name="password" required>
        </div>
        <div>
            <label>Date de naissance:</label>
            <input type="date" name="date_naissance" required>
        </div>
        <div>
            <label>Profil:</label>
            <select name="profilId" required>
                <c:choose>
                    <c:when test="${empty profils}">
                        <option disabled selected>Aucun profil</option>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${profils}" var="profil">
                            <option value="${profil.id_profil}">${profil.nom}</option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
        <button type="submit">S'inscrire</button>
    </form>
</div>
</body>
</html>