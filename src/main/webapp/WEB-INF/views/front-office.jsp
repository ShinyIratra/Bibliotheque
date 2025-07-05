<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Espace Membre</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: var(--gray-100);
            color: var(--black);
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        body {
            min-height: 100vh;
            display: flex;
        }
        .sidebar {
            width: 240px;
            background: var(--white);
            box-shadow: 2px 0 8px var(--gray-200);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 36px 0 0 0;
            gap: 24px;
            min-height: 100vh;
            position: sticky;
            top: 0;
        }
        .sidebar .avatar {
            font-size: 3.8em;
            color: var(--black);
            background: var(--gray-200);
            border-radius: 50%;
            padding: 10px;
            margin-bottom: 10px;
            box-shadow: 0 2px 8px var(--gray-200);
        }
        .sidebar .user-info {
            text-align: center;
            margin-bottom: 20px;
        }
        .sidebar .user-info strong {
            color: var(--accent);
            font-size: 1.12em;
        }
        .sidebar .user-info small {
            color: var(--gray-400);
            font-size: 0.97em;
        }
        .sidebar nav {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .sidebar nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 32px;
            color: var(--black);
            text-decoration: none;
            font-weight: 500;
            border-radius: 0 22px 22px 0;
            transition: background 0.16s, color 0.16s;
            background: transparent;
        }
        .sidebar nav a.active,
        .sidebar nav a:hover {
            background: var(--gray-200);
            color: var(--accent);
        }
        .sidebar nav a.logout {
            background: var(--danger);
            color: var(--white);
            margin-top: 22px;
            border-radius: 0 22px 22px 0;
            transition: background 0.18s, color 0.18s;
        }
        .sidebar nav a.logout:hover {
            background: #b91c1c;
            color: var(--white);
        }
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 48px 7vw 48px 7vw;
            min-width: 0;
        }
        .main-content h2 {
            font-size: 2.3em;
            margin: 0 0 26px 0;
            color: var(--black);
            font-weight: 700;
            letter-spacing: -1px;
        }
        .main-content .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 34px;
        }
        .main-content .actions a {
            display: flex;
            align-items: center;
            gap: 10px;
            background: var(--black);
            color: var(--white);
            text-decoration: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 500;
            box-shadow: 0 2px 8px var(--gray-200);
            transition: background 0.18s, color 0.18s, transform 0.12s;
            border: 1px solid var(--gray-300);
        }
        .main-content .actions a:hover {
            background: var(--accent);
            color: var(--white);
            transform: translateY(-2px) scale(1.04);
            border-color: var(--accent);
        }
        .main-content .search-section {
            background: var(--white);
            padding: 24px 28px;
            border-radius: 12px;
            box-shadow: 0 2px 12px var(--gray-200);
            margin-bottom: 32px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-width: 520px;
            border: 1px solid var(--gray-200);
        }
        .main-content .search-section label {
            font-weight: 600;
            margin-bottom: 4px;
            color: var(--gray-700);
        }
        .main-content .search-section select,
        .main-content .search-section button {
            padding: 10px 14px;
            border-radius: 6px;
            border: 1px solid var(--gray-300);
            font-size: 1em;
        }
        .main-content .search-section select {
            background: var(--gray-100);
            color: var(--black);
        }
        .main-content .search-section button {
            background: var(--black);
            color: var(--white);
            border: none;
            font-weight: 600;
            margin-top: 10px;
            cursor: pointer;
            transition: background 0.16s, color 0.16s;
        }
        .main-content .search-section button:hover {
            background: var(--accent);
            color: var(--white);
        }
        .main-content .links {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 32px;
        }
        .main-content .links a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--accent);
            text-decoration: underline;
            font-weight: 500;
            font-size: 1.04em;
            transition: color 0.16s;
        }
        .main-content .links a:hover {
            color: var(--black);
        }
        .admin-panel {
            margin-top: 40px;
            background: var(--gray-100);
            border-radius: 12px;
            box-shadow: 0 2px 12px var(--gray-200);
            padding: 28px 28px 22px 28px;
            border: 1px solid var(--gray-200);
        }
        .admin-panel h3 {
            color: var(--danger);
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 1.35em;
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        .admin-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }
        .admin-actions a {
            display: flex;
            align-items: center;
            gap: 8px;
            background: var(--black);
            color: var(--white);
            text-decoration: none;
            padding: 12px 22px;
            border-radius: 7px;
            font-weight: 500;
            box-shadow: 0 2px 8px var(--gray-200);
            transition: background 0.18s, color 0.18s, transform 0.12s;
            border: 1px solid var(--gray-300);
        }
        .admin-actions a:hover {
            background: var(--danger);
            color: var(--white);
            transform: translateY(-2px) scale(1.04);
            border-color: var(--danger);
        }
        @media (max-width: 900px) {
            .sidebar { width: 70px; padding: 18px 0 0 0; }
            .sidebar .user-info, .sidebar nav a span { display: none; }
            .sidebar nav a { justify-content: center; padding: 13px 0; }
            .sidebar nav a.logout { margin-top: 12px; }
        }
        @media (max-width: 700px) {
            body { flex-direction: column; }
            .sidebar { flex-direction: row; width: 100vw; height: 70px; min-height: 0; box-shadow: 0 2px 8px var(--gray-200); position: static; }
            .sidebar .avatar { font-size: 2em; }
            .main-content { padding: 24px 3vw; }
        }
        @media (max-width: 500px) {
            .main-content { padding: 12px 2vw; }
            .main-content .search-section { padding: 12px 8px; }
            .admin-panel { padding: 14px 6px 10px 6px; }
        }
    </style>
</head>
<body>
    <aside class="sidebar">
        <i class="fa-solid fa-user-circle avatar"></i>
        <div class="user-info">
            <div style="font-size:1.08em;">Connecté avec l'ID</div>
            <strong>${sessionScope.userId}</strong>
            <div style="font-size:0.93em;color:var(--gray-400);margin-top:2px;">
                <i class="fa-solid fa-user-tag"></i>
                <c:out value="${sessionScope.nomProfil}"/>
            </div>
        </div>
        <nav>
            <a href="retour"><i class="fa-solid fa-undo"></i> <span>Retourner un prêt</span></a>
            <a href="mes-prets"><i class="fa-solid fa-book"></i> <span>Mes prêts en cours</span></a>
            <a href="pret"><i class="fa-solid fa-plus"></i> <span>Faire un prêt</span></a>
            <a href="reservation"><i class="fa-solid fa-calendar-plus"></i> <span>Réserver un exemplaire</span></a>
            <a href="mes-droits"><i class="fa-solid fa-id-card"></i> <span>Mes droits d'emprunt</span></a>
            <a href="historique"><i class="fa-solid fa-clock-rotate-left"></i> <span>Historique de mes prêts</span></a>
            <a href="/logout" class="logout"><i class="fa-solid fa-sign-out-alt"></i> <span>Déconnexion</span></a>
        </nav>
    </aside>
    <main class="main-content">
        <h2>Bienvenue dans votre espace membre</h2>
        <div class="actions">
            <a href="pret"><i class="fa-solid fa-plus"></i> Faire un prêt</a>
            <a href="reservation"><i class="fa-solid fa-calendar-plus"></i> Réserver un exemplaire</a>
            <a href="mes-prets"><i class="fa-solid fa-book"></i> Mes prêts en cours</a>
            <a href="retour"><i class="fa-solid fa-undo"></i> Retourner un prêt</a>
        </div>
        <section class="search-section">
            <form action="livre" method="get" style="display:flex;flex-direction:column;gap:10px;">
                <label for="idLivre"><i class="fa-solid fa-search"></i> Rechercher une fiche livre :</label>
                <select id="idLivre" name="idLivre" required>
                    <option disabled selected value="">Choisir un livre</option>
                    <c:forEach var="livre" items="${livres}">
                        <option value="${livre.id_livre}">
                            <c:out value="${livre.titre}"/> (ID: ${livre.id_livre})
                        </option>
                    </c:forEach>
                </select>
                <button type="submit"><i class="fa-solid fa-eye"></i> Voir la fiche</button>
            </form>
        </section>
        <div class="links">
            <a href="mes-droits"><i class="fa-solid fa-id-card"></i> Consulter mes droits d'emprunt</a>
            <a href="historique"><i class="fa-solid fa-clock-rotate-left"></i> Voir l'historique de mes prêts</a>
        </div>
        <!-- Affichage pour tous -->
        <div style="font-size:0.98em;color:var(--gray-400);margin-bottom:18px;">
            <i class="fa-solid fa-clock"></i>
            Date système actuelle : <strong>${dateNow}</strong>
        </div>
        <!-- Actions réservées au bibliothécaire -->
        <c:if test="${sessionScope.nomProfil == 'Bibliothecaire'}">
            <section class="admin-panel">
                <h3><i class="fa-solid fa-user-tie"></i> Actions Bibliothécaire</h3>
                <div class="admin-actions">
                    <a href="inscription"><i class="fa-solid fa-user-plus"></i> Enregistrer une cotisation / inscription</a>
                    <a href="pret-sur-place"><i class="fa-solid fa-hand-holding-book"></i> Prêt sur place</a>
                    <a href="admin/jours-feries"><i class="fa-solid fa-calendar-day"></i> Configurer les jours fériés</a>
                    <a href="validation-pret"><i class="fa-solid fa-check"></i> Valider les prêts en attente</a>
                </div>
                <form action="modifier-date-systeme" method="post" style="margin-bottom:18px;">
                    <label>Changer la date système :</label>
                    <input type="datetime-local" name="nouvelleDate" required>
                    <button type="submit">Définir</button>
                    <a href="reset-date-systeme" style="margin-left:10px;">Réinitialiser</a>
                </form>
            </section>
        </c:if>
    </main>
</body>
</html>