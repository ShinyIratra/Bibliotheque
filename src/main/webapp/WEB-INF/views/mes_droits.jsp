<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes droits d'emprunt</title>
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
        h2 {
            color: var(--black);
            font-size: 2em;
            font-weight: 700;
            margin-bottom: 28px;
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
    <h2>Mes droits d'emprunt</h2>
    <p>Profil : <strong><c:out value="${nomProfil}" default="Non renseigné"/></strong></p>
    <ul>
        <li>Quota d'emprunt : ${droits.quota}</li>
        <li>Nombre de prolongements : ${droits.nbr_prolongement}</li>
        <li>Quota de réservation : ${droits.quota_reservation}</li>
    </ul>
    <a href="front-office">Retour à l'espace membre</a>
</div>
</body>
</html>