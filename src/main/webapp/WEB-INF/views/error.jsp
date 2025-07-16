
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Erreur - Bibliothèque</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        @font-face {
            font-family: 'LocalSans';
            src: local('Arial'), local('Helvetica'), local('Segoe UI');
            font-weight: normal;
            font-style: normal;
        }
        
        :root {
            --primary: #4361ee;
            --primary-light: #4895ef;
            --secondary: #3f37c9;
            --accent: #f72585;
            --success: #06d6a0;
            --warning: #ffd166;
            --danger: #ef476f;
            --dark: #1d3557;
            --light: #f8f9fa;
            --gray: #6c757d;
            --gray-light: #e9ecef;
            --border-radius: 12px;
            --card-shadow: 0 10px 30px rgba(0,0,0,0.08);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'LocalSans', Arial, sans-serif;
            line-height: 1.6;
            background-color: #f5f7fa;
            color: var(--dark);
            min-height: 100vh;
        }
        header {
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .container {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }
        .logo-icon {
            font-size: 2rem;
            color: var(--primary);
        }
        .logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark);
            letter-spacing: -0.5px;
        }
        nav ul {
            display: flex;
            list-style: none;
            gap: 1rem;
        }
        nav a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            border-radius: 30px;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        nav a:hover {
            background-color: var(--gray-light);
        }
        nav a.primary-btn {
            background: var(--primary);
            color: white;
        }
        nav a.primary-btn:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }
        
        /* Icônes Unicode et SVG */
        .icon {
            display: inline-block;
            width: 1em;
            height: 1em;
            vertical-align: -0.125em;
            margin-right: 0.25em;
        }
        
        .icon-home::before { content: "🏠"; }
        .icon-user::before { content: "👤"; }
        .icon-user-tie::before { content: "👔"; }
        .icon-logout::before { content: "🚪"; }
        .icon-signup::before { content: "✏️"; }
        .icon-book::before { content: "📖"; }
        .icon-book-open::before { content: "📚"; }
        .icon-search::before { content: "🔍"; }
        .icon-filter::before { content: "🔣"; }
        .icon-author::before { content: "✒️"; }
        .icon-calendar::before { content: "📅"; }
        .icon-id::before { content: "#️⃣"; }
        .icon-genre::before { content: "🏷️"; }
        .icon-edition::before { content: "📆"; }
        .icon-info::before { content: "ℹ️"; }
        .icon-check::before { content: "✅"; }
        .icon-error::before { content: "❌"; }
        .icon-question::before { content: "❓"; }
        .icon-loan::before { content: "🤲"; }
        .icon-read::before { content: "👀"; }
        .icon-reserve::before { content: "🔖"; }
        .icon-lock::before { content: "🔒"; }
        .icon-grid::before { content: "▦"; }
        .icon-list::before { content: "☰"; }
        
        .error-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            margin: 3rem auto 0;
            padding: 2.5rem 2rem;
            max-width: 600px;
            text-align: center;
            border-top: 6px solid var(--danger);
        }
        .error-icon {
            font-size: 3.5rem;
            color: var(--danger);
            margin-bottom: 1rem;
        }
        .error-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--danger);
            margin-bottom: 1rem;
        }
        .error-message {
            color: var(--dark);
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }
        .error-details {
            background: var(--gray-light);
            border-radius: 8px;
            padding: 1rem;
            margin: 1.5rem 0;
            color: var(--gray);
            text-align: left;
            font-size: 0.98rem;
        }
        .btn {
            display: inline-block;
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
            text-decoration: none;
        }
        .btn:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            .container, .error-card { padding: 1rem; }
            .error-card { margin: 1.5rem 0 0; }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <a href="home" class="logo">
                    <span class="logo-icon">📚</span>
                    <span class="logo-text">BIBLIOTHÈQUE</span>
                </a>
                <nav>
                    <ul>
                        <li><a href="home"><span>🏠</span> Accueil</a></li>
                        <li><a href="librarian-login"><span>👨‍💼</span> Bibliothécaire</a></li>
                        <li><a href="member-login"><span>👤</span> Membre</a></li>
                        <li><a href="registration" class="primary-btn"><span>✍️</span> Inscription</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
    <main>
        <div class="error-card">
            <div class="error-icon">❌</div>
            <div class="error-title">Une erreur est survenue</div>
            <div class="error-message">
                <c:choose>
                    <c:when test="${not empty error}">
                        ${error}
                    </c:when>
                    <c:otherwise>
                        Une erreur inattendue est survenue.
                    </c:otherwise>
                </c:choose>
            </div>
            <a href="home" class="btn">Retour à l'accueil</a>
            <c:if test="${not empty url or not empty exception}">
                <div class="error-details">
                    <c:if test="${not empty url}">
                        <p><strong>URL :</strong> ${url}</p>
                    </c:if>
                    <c:if test="${not empty exception}">
                        <p><strong>Type d'erreur :</strong> ${exception}</p>
                    </c:if>
                </div>
            </c:if>
        </div>
    </main>
</body>
</html>
