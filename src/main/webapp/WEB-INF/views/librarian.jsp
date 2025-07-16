<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Bibliothèque - Bibliothécaire</title>
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
        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem 1.5rem;
        }
        h3 {
            margin-top: 2rem;
            border-bottom: 1px solid var(--gray-light);
            padding-bottom: 0.5rem;
            color: var(--primary);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            margin-bottom: 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }
        th, td {
            border: 1px solid var(--gray-light);
            padding: 0.8rem 1rem;
            text-align: left;
        }
        th {
            background: var(--primary);
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: var(--gray-light);
        }
        .notification-card {
            border: 1px solid var(--gray-light);
            background-color: #fff;
            padding: 1.2rem;
            margin: 1rem 0;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
        }
        form {
            margin: 1rem 0;
            padding: 1rem;
            background: var(--light);
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        input, select, button {
            margin-bottom: 0.8rem;
            padding: 0.7rem;
            width: 100%;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid var(--gray-light);
            font-size: 1rem;
        }
        button {
            background: var(--primary);
            color: white;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }
        button:hover {
            background: var(--primary-light);
            transform: translateY(-2px);
        }
        .error-message {
            background: #ffdada;
            color: var(--danger);
            padding: 1rem;
            margin-bottom: 1.2rem;
            border: 1px solid var(--danger);
            border-radius: 8px;
        }
        .action-link {
            color: var(--primary);
            text-decoration: underline;
        }
        @media (max-width: 900px) {
            main, .container { padding: 1rem; }
        }
        @media (max-width: 600px) {
            main, .container { padding: 0.5rem; }
            table, th, td { font-size: 0.95rem; }
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
                        <li><a href="member-login"><span>👤</span> Membre</a></li>
                        <li><a href="registration"><span>✍️</span> Inscription</a></li>
                        <li><a href="disconnect" class="primary-btn"><span>🚪</span> Déconnexion</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

<main>
    <c:if test="${not empty error}">
        <div class="error-message">
            ${error}
        </div>
    </c:if>
    <!-- Zone des emprunts -->
<div id="loans">
    <h3>Emprunts actifs</h3>
<c:choose>
    <c:when test="${empty loans}">
        <p>Aucun emprunt actif.</p>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
            <tr>
                <th>ID Emprunt</th>
                <th>Membre</th>
                <th>ID Exemplaire</th>
                <th>Bibliothécaire</th>
                <th>Date d'emprunt</th>
                <th>Date de début</th>
                <th>Date d'échéance</th>
                <th>Retourné</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="loan" items="${loans}">
                <tr>
                    <td>${loan.id}</td>
                    <td>${loan.member.username}</td>
                    <td>${loan.copy.id}</td>
                    <td>${loan.librarianLoan.username}</td>
                    <td>${loan.loanDate}</td>
                    <td>${loan.startDate}</td>
                    <td>${loan.dueDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${empty loan.returnDate}">
                                <form action="return-loan" method="post" class="return-form">
                                    <input type="hidden" name="loan" value="${loan.id}" />
                                    <div class="form-group">
                                        <label for="return_date_${loan.id}">Date de retour :</label>
                                        <input type="date" name="return_date" id="return_date_${loan.id}" 
                                               value="${today}" required>
                                    </div>
                                    <button type="submit">Marquer comme retourné</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                ${loan.returnDate}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

</div>

<!-- Zone des notifications -->
<div id="notifications">
    <h3>Demandes de prolongation d'emprunts</h3>
    <c:choose>
        <c:when test="${empty extensions}">
            <p>Aucune demande de prolongation.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="ext" items="${extensions}">
                <div class="notification-card">
                    <h5>Prolongation #${ext.id}</h5>
                    <p><strong>Date d'échéance demandée :</strong> ${ext.askDueDate}</p>
                    <p><strong>Date de prolongation :</strong> ${ext.extensionDate}</p>

                    <p><strong>Emprunt :</strong> #${ext.loan.id} par ${ext.loan.member.username}</p>
                    <ul>
                        <li>Titre du livre : ${ext.loan.copy.book.title}</li>
                        <li>Auteur : ${ext.loan.copy.book.author.name}</li>
                        <li>Genre : ${ext.loan.copy.book.bookGenre.value}</li>
                    </ul>
                    <p><strong>Date d'échéance initiale :</strong> ${ext.loan.dueDate}</p>

                    <form action="extension-librarian" method="post">
                        <input type="hidden" name="extension" value="${ext.id}">
                        <label><input type="radio" name="decision" value="approve" required> Approuver</label>
                        <label><input type="radio" name="decision" value="decline"> Refuser</label>
                        <button type="submit">Soumettre</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <h3>Demandes de réservation</h3>
    <c:choose>
        <c:when test="${empty reservations}">
            <p>Aucune demande de réservation.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="res" items="${reservations}">
                <div class="notification-card">
                    <h5>Réservation #${res.id}</h5>
                    <p><strong>Membre :</strong> ${res.member.username}</p>
                    <ul>
                        <li>Livre : ${res.book.title}</li>
                        <li>Auteur : ${res.book.author.name}</li>
                        <li>Genre : ${res.book.bookGenre.value}</li>
                    </ul>
                    <p><strong>Date de réservation :</strong> ${res.reservationDate}</p>
                    <p><strong>Date de début demandée :</strong> ${res.askStartDate}</p>
                    <p><strong>Date d'échéance demandée :</strong> ${res.askDueDate}</p>

                    <form action="reservation-librarian" method="post">
                        <input type="hidden" name="reservation" value="${res.id}">
                        <label><input type="radio" name="decision" value="approve" required> Approuver</label>
                        <label><input type="radio" name="decision" value="decline"> Refuser</label>
                        <button type="submit">Soumettre</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

    <div id="read">
        <h3>Formulaire pour lire un livre à la bibliothèque</h3>
        <form action="read" method="post">
            <c:choose>
                <c:when test="${not empty book_read}">
                    <div class="form-group">
                        <strong>Livre :</strong>
                        <ul>
                            <li><strong>ID Livre :</strong> ${book_read.id}</li>
                            <li><strong>Titre :</strong> ${book_read.title}</li>
                            <li><strong>Auteur :</strong> ${book_read.author.name}</li>
                            <li><strong>Genre :</strong> ${book_read.bookGenre.value}</li>
                        </ul>
                        <input type="hidden" name="book" value="${book_read.id}">
                    </div>
                </c:when>
                <c:otherwise>
                    <p><a href="home" class="action-link">Vous souhaitez lire un livre ? Choisissez-en un d'abord</a></p>
                </c:otherwise>
            </c:choose>
            <label for="username">Nom d'utilisateur :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <button type="submit">Lire</button>
        </form>
    </div>

    <div id="loan">
        <h3>Formulaire pour emprunter un livre à la bibliothèque</h3>
        <form action="loan" method="post">
            <c:choose>
                <c:when test="${not empty book}">
                    <div class="form-group">
                        <strong>Livre :</strong>
                        <ul>
                            <li><strong>ID Livre :</strong> ${book.id}</li>
                            <li><strong>Titre :</strong> ${book.title}</li>
                            <li><strong>Auteur :</strong> ${book.author.name}</li>
                            <li><strong>Genre :</strong> ${book.bookGenre.value}</li>
                        </ul>
                        <input type="hidden" name="book" value="${book.id}">
                    </div>
                </c:when>
                <c:otherwise>
                    <p><a href="home" class="action-link">Vous souhaitez emprunter un livre ? Choisissez-en un d'abord</a></p>
                </c:otherwise>
            </c:choose>
            <label for="username">Nom d'utilisateur :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <label for="loan_date">Date d'emprunt :</label>
            <input type="date" name="loan_date" id="loan_date" required>
            <label for="duration">Durée :</label>
            <input type="number" name="duration" id="duration" min="1" required>
            <button type="submit">Emprunter</button>
        </form>
    </div>

    <div id="subscribe">
        <h3>Formulaire pour s'abonner à la bibliothèque</h3>
        <form action="subscribe" method="post">
            <label for="username">Nom d'utilisateur :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <label for="subscription_type">Type d'abonnement :</label>
            <select name="subscription_type" id="subscription_type" required>
                <option value="">Sélectionnez un type d'abonnement</option>
                <c:forEach var="sub" items="${subscriptionTypes}">
                    <option value="${sub.id}">${sub.name}--${sub.duration}</option>
                </c:forEach>
            </select>
            <label for="start_date">Date de début :</label>
            <input type="date" name="start_date" id="start_date" required><br>
            <button type="submit">S'abonner</button>
        </form>
    </div>
</main>
</body>
</html>
