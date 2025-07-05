<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Configuration des jours fériés</title>
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
            max-width: 600px;
            margin: 48px auto;
            background: var(--white);
            padding: 40px 48px 32px 48px;
            border-radius: 14px;
            box-shadow: 0 4px 24px var(--gray-200);
            border: 1px solid var(--gray-200);
        }
        h2, h3 {
            color: var(--black);
        }
        label {
            display: block;
            margin-top: 12px;
            font-weight: 500;
        }
        input[type="date"], input[type="text"] {
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
        ul {
            padding-left: 20px;
        }
        li {
            margin-bottom: 6px;
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
    <h2>Jours fériés</h2>
    <form action="jours-feries" method="post">
        <label>Date :</label>
        <input type="date" name="date" required>
        <label>Description :</label>
        <input type="text" name="description">
        <button type="submit">Ajouter</button>
    </form>
    <h3>Liste des jours fériés</h3>
    <ul>
        <c:choose>
            <c:when test="${empty joursFeries}">
                <li class="empty">Aucun jour férié enregistré.</li>
            </c:when>
            <c:otherwise>
                <c:forEach items="${joursFeries}" var="jf">
                    <li>
                        <c:out value="${jf.date}" default="—"/>
                        <c:if test="${not empty jf.description}"> - ${jf.description}</c:if>
                    </li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</div>
</body>
</html>