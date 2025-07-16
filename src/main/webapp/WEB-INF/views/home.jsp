<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Bibliothèque - Accueil</title>
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
        
        /* Header & Navigation */
        header {
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .container {
            width: 100%;
            max-width: 1400px;
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
        
        /* Main content */
        .page-title {
            text-align: center;
            margin: 2rem 0;
        }
        
        .page-title h1 {
            font-size: 2.5rem;
            color: var(--dark);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .page-title p {
            color: var(--gray);
            font-size: 1.1rem;
        }
        
        main {
            display: flex;
            max-width: 1400px;
            margin: 0 auto 3rem;
            padding: 0 1.5rem;
            gap: 2rem;
            position: relative;
        }
        
        /* Filters panel */
        .filters-panel {
            width: 320px;
            position: sticky;
            top: 100px;
            height: fit-content;
        }
        
        .filters-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }
        
        .filters-header {
            background: var(--primary);
            color: white;
            padding: 1.2rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        
        .filters-header h3 {
            font-weight: 600;
            font-size: 1.2rem;
            margin: 0;
        }
        
        .filters-body {
            padding: 1.5rem;
        }
        
        .filter-group {
            margin-bottom: 1.5rem;
        }
        
        .filter-group:last-child {
            margin-bottom: 0;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .filter-group select, 
        .filter-group input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
            background: white;
        }
        
        .filter-group select:focus, 
        .filter-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .date-range {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            gap: 0.5rem;
            align-items: center;
        }
        
        .date-range span {
            text-align: center;
            color: var(--gray);
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
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
        }
        
        .btn-block {
            display: block;
            width: 100%;
        }
        
        .btn-primary {
            background: var(--primary);
        }
        
        .btn-success {
            background: var(--success);
        }
        
        .btn-warning {
            background: var(--warning);
            color: var(--dark);
        }
        
        /* Books grid */
        .books-container {
            flex: 1;
        }
        
        .books-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .books-stats {
            font-size: 1rem;
            color: var(--gray);
        }
        
        .books-stats strong {
            color: var(--dark);
        }
        
        .view-options {
            display: flex;
            gap: 0.5rem;
        }
        
        .view-btn {
            background: white;
            border: 1px solid var(--gray-light);
            padding: 0.5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .view-btn.active, .view-btn:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
        }
        
        .book-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }
        
        .book-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--gray-light);
            position: relative;
        }
        
        .book-badge {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-available {
            background: rgba(6, 214, 160, 0.1);
            color: var(--success);
        }
        
        .badge-unavailable {
            background: rgba(239, 71, 111, 0.1);
            color: var(--danger);
        }
        
        .book-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }
        
        .book-author {
            color: var(--gray);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .book-body {
            padding: 1.5rem;
            flex: 1;
        }
        
        .book-details {
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 0.5rem 1rem;
            margin-bottom: 1.5rem;
        }
        
        .book-detail-label {
            color: var(--gray);
            font-size: 0.9rem;
        }
        
        .book-detail-value {
            color: var(--dark);
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .availability-info {
            background: var(--gray-light);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }
        
        .availability-title {
            font-weight: 600;
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .availability-status {
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .status-icon {
            font-size: 1rem;
        }
        
        .status-available .status-icon {
            color: var(--success);
        }
        
        .status-unavailable .status-icon {
            color: var(--danger);
        }
        
        .status-unknown .status-icon {
            color: var(--warning);
        }
        
        .book-footer {
            padding: 1.5rem;
            border-top: 1px solid var(--gray-light);
            background: #fafafa;
        }
        
        .action-form {
            margin-bottom: 1rem;
        }
        
        .action-form:last-child {
            margin-bottom: 0;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .action-link {
            display: block;
            text-align: center;
            padding: 1rem;
            background: var(--gray-light);
            border-radius: 8px;
            color: var(--gray);
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .action-link:hover {
            background: #eaeaea;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .books-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            main {
                flex-direction: column;
            }
            
            .filters-panel {
                width: 100%;
                position: static;
            }
            
            .books-grid {
                grid-template-columns: 1fr;
            }
            
            .books-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(30px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .animate-fadeIn {
            animation: fadeIn 0.5s ease forwards;
        }
        
        .animate-slideUp {
            animation: slideUp 0.5s ease forwards;
        }
        
        .book-card {
            opacity: 0;
            animation: slideUp 0.5s ease forwards;
        }
        
        .book-card:nth-child(2) { animation-delay: 0.1s; }
        .book-card:nth-child(3) { animation-delay: 0.2s; }
        .book-card:nth-child(4) { animation-delay: 0.3s; }
        .book-card:nth-child(5) { animation-delay: 0.4s; }
        .book-card:nth-child(6) { animation-delay: 0.5s; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <a href="" class="logo">
                    <span class="logo-icon"><span class="icon-book-open"></span></span>
                    <span class="logo-text">BIBLIOTHÈQUE</span>
                </a>
                
                <nav>
                    <c:choose>
                        <c:when test="${not empty sessionScope.sessionLibrarian}">
                            <ul>
                                <li><a href=""><span class="icon-home"></span> Accueil</a></li>
                                <li><a href="librarian" class="primary-btn"><span class="icon-user-tie"></span> Menu Bibliothécaire</a></li>
                                <li><a href="disconnect"><span class="icon-logout"></span> Déconnexion</a></li>
                            </ul>
                        </c:when>
                        <c:when test="${not empty sessionScope.sessionMember}">
                            <ul>
                                <li><a href=""><span class="icon-home"></span> Accueil</a></li>
                                <li><a href="member" class="primary-btn"><span class="icon-user"></span> Mon Compte</a></li>
                                <li><a href="disconnect"><span class="icon-logout"></span> Déconnexion</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <ul>
                                <li><a href="librarian-login"><span class="icon-user-tie"></span> Bibliothécaire</a></li>
                                <li><a href="member-login"><span class="icon-user"></span> Membre</a></li>
                                <li><a href="registration" class="primary-btn"><span class="icon-signup"></span> Inscription</a></li>   
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </nav>
            </div>
        </div>
    </header>
    
    <div class="container">
        <div class="page-title animate-fadeIn">
            <h1>Découvrez notre collection de livres</h1>
            <p>Explorez et trouvez vos prochaines lectures préférées</p>
        </div>
    </div>
    
    <main>
        <!-- Filtres -->
        <div class="filters-panel animate-slideUp">
            <div class="filters-card">
                <div class="filters-header">
                    <span class="icon-filter"></span>
                    <h3>Filtres de recherche</h3>
                </div>
                <div class="filters-body">
                    <form action="home" method="get" class="filter-form">
                        <div class="filter-group">
                            <label for="book_genre"><span class="icon-book"></span> Genre</label>
                            <select name="book_genre" id="book_genre">
                                <option value="">Tous les genres</option>
                                <c:forEach var="genre" items="${bookGenres}">
                                    <option value="${genre.id}">${genre.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="author"><span class="icon-author"></span> Auteur</label>
                            <select name="author" id="author">
                                <option value="">Tous les auteurs</option>
                                <c:forEach var="author" items="${authors}">
                                    <option value="${author.id}">${author.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label><span class="icon-calendar"></span> Période d'édition</label>
                            <div class="date-range">
                                <input type="date" name="edition_date_min" id="edition_date_min">
                                <span>à</span>
                                <input type="date" name="edition_date_max" id="edition_date_max">
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-block">
                            <span class="icon-search"></span> Rechercher
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Livres -->
        <div class="books-container animate-slideUp" style="animation-delay: 0.2s;">
            <div class="books-header">
                <div class="books-stats">
                    <strong>${books.size()}</strong> livres trouvés
                </div>
                <div class="view-options">
                    <button class="view-btn active" title="Vue grille">
                        <span class="icon-grid"></span>
                    </button>
                    <button class="view-btn" title="Vue liste">
                        <span class="icon-list"></span>
                    </button>
                </div>
            </div>
            
            <div class="books-grid">
                <c:forEach var="book" items="${books}">
                    <div class="book-card">
                        <div class="book-header">
                            <c:if test="${not empty book.checkDate}">
                                <c:choose>
                                    <c:when test="${book.available}">
                                        <span class="book-badge badge-available">Disponible</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="book-badge badge-unavailable">Indisponible</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <h3 class="book-title">${book.title}</h3>
                            <div class="book-author">
                                <span class="icon-author"></span>
                                ${book.author.name}
                            </div>
                        </div>
                        
                        <div class="book-body">
                            <div class="book-details">
                                <span class="book-detail-label"><span class="icon-id"></span> ID:</span>
                                <span class="book-detail-value">${book.id}</span>
                                
                                <span class="book-detail-label"><span class="icon-genre"></span> Genre:</span>
                                <span class="book-detail-value">${book.bookGenre.value}</span>
                                
                                <span class="book-detail-label"><span class="icon-edition"></span> Édition:</span>
                                <span class="book-detail-value">${book.editionDate}</span>
                            </div>
                            
                            <div class="availability-info">
                                <div class="availability-title">
                                    <span class="icon-info"></span> Statut
                                </div>
                                <c:choose>
                                    <c:when test="${not empty book.checkDate}">
                                        <div class="availability-status">
                                            <span class="icon-calendar"></span> Vérifié le: ${book.checkDate}
                                        </div>
                                        <c:choose>
                                            <c:when test="${book.available}">
                                                <div class="availability-status status-available">
                                                    <span class="icon-check status-icon"></span> 
                                                    <span>Disponible pour emprunt</span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="availability-status status-unavailable">
                                                    <span class="icon-error status-icon"></span> 
                                                    <span>Non disponible</span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="availability-status status-unknown">
                                            <span class="icon-question status-icon"></span>
                                            <span>Disponibilité non vérifiée</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="book-footer">
                            <form action="availability" method="get" class="action-form">
                                <input type="hidden" name="book" value="${book.id}">
                                <div class="form-group">
                                    <label for="date_start_${book.id}" class="form-label">
                                        <span class="icon-calendar"></span> Date souhaitée:
                                    </label>
                                    <input type="date" class="form-control" name="date_start" id="date_start_${book.id}" required>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">
                                    <span class="icon-search"></span> Vérifier la disponibilité
                                </button>
                            </form>

                            <c:choose>
                                <c:when test="${not empty sessionScope.sessionLibrarian}">
                                    <form action="form-loan" method="post" class="action-form">
                                        <input type="hidden" name="book" value="${book.id}">
                                        <button type="submit" class="btn btn-success btn-block">
                                            <span class="icon-loan"></span> Prêter
                                        </button>
                                    </form>
                                    <form action="form-read" method="post" class="action-form">
                                        <input type="hidden" name="book_read" value="${book.id}">
                                        <button type="submit" class="btn btn-warning btn-block">
                                            <span class="icon-read"></span> Consultation sur place
                                        </button>
                                    </form>
                                </c:when>

                                <c:when test="${not empty sessionScope.sessionMember}">
                                    <form action="form-reservation" method="post" class="action-form">
                                        <input type="hidden" name="book" value="${book.id}">
                                        <button type="submit" class="btn btn-success btn-block">
                                            <span class="icon-reserve"></span> Réserver
                                        </button>
                                    </form>
                                </c:when>

                                <c:otherwise>
                                    <a href="member-login" class="action-link">
                                        <span class="icon-lock"></span> Connectez-vous pour accéder aux actions
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>

    <script>
        // Simple JavaScript pour les boutons de vue (grille/liste)
        document.addEventListener('DOMContentLoaded', function() {
            const viewButtons = document.querySelectorAll('.view-btn');
            const booksGrid = document.querySelector('.books-grid');
            
            viewButtons.forEach(button => {
                button.addEventListener('click', function() {
                    viewButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    if (this.querySelector('.icon-list')) {
                        booksGrid.style.gridTemplateColumns = '1fr';
                    } else {
                        booksGrid.style.gridTemplateColumns = 'repeat(auto-fill, minmax(320px, 1fr))';
                    }
                });
            });
        });
    </script>
</body>
</html>