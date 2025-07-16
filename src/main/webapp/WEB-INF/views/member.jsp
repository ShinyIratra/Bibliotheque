<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Bibliothèque - Mon Compte</title>
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
        
        nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: block;
            background: linear-gradient(45deg, #667eea, #764ba2);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        nav a:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            background: linear-gradient(45deg, #764ba2, #667eea);
        }
        
        main {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            padding: 2rem;
            max-width: 1400px;
            margin: auto;
        }

        #card, #loans, #reservations {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        #card::before, #loans::before, #reservations::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        #card {
            grid-column: 1 / 2;
        }

        #loans {
            grid-column: 2 / 3;
        }

        #reservations {
            grid-column: 1 / 3;
        }
        
        .section-title {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .member-card p, .member-card li {
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .member-card strong {
            color: #34495e;
            min-width: 150px;
            font-weight: 600;
        }
        
        .status-approved {
            color: #27ae60;
            font-weight: bold;
            background: #d5f4e6;
            padding: 0.2rem 0.8rem;
            border-radius: 15px;
        }
        
        .subscription-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
            border-left: 4px solid #667eea;
        }
        
        .subscription-info ul {
            list-style: none;
            padding: 0;
        }

        @media (max-width: 768px) {
            main {
                grid-template-columns: 1fr;
                gap: 1rem;
                padding: 1rem;
            }
            #card, #loans, #reservations {
                grid-column: auto;
            }
            
            .member-card p, .member-card li {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .member-card strong {
                min-width: auto;
                margin-bottom: 0.3rem;
            }
        }
        
        /* Styles pour les tableaux */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }
        
        th {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            font-weight: 600;
            cursor: pointer;
            position: relative;
            transition: all 0.3s ease;
        }
        
        th:hover {
            background: linear-gradient(45deg, #764ba2, #667eea);
        }
        
        tr:hover {
            background-color: #f8f9fa;
        }
        
        tr:nth-child(even) {
            background-color: rgba(102, 126, 234, 0.05);
        }
        
        .extension-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .extension-form input[type="date"] {
            padding: 0.5rem;
            border: 2px solid #e1e8ed;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        
        .extension-form button {
            background: linear-gradient(45deg, #f39c12, #d68910);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        
        .extension-form button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(243, 156, 18, 0.3);
        }
        
        .no-data {
            text-align: center;
            color: #7f8c8d;
            font-style: italic;
            padding: 2rem;
        }
        
        /* Animation de chargement */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        #card, #loans, #reservations {
            animation: fadeIn 0.6s ease forwards;
        }
        
        #loans {
            animation-delay: 0.2s;
        }
        
        #reservations {
            animation-delay: 0.4s;
        }
    </style>
</head>
<body>
    <header>
        <h1>📚 BIBLIOTHÈQUE</h1>
        <nav>
            <ul>
                <li><a href="home">🏠 Accueil</a></li>
                <li><a href="disconnect">🚪 Déconnexion</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <!-- Carte de Membre -->
       <div id="card">
            <h2 class="section-title">👤 Ma Carte de Membre</h2>
            <div class="member-card">
                <p><strong>🆔 ID Membre :</strong> ${member.id}</p>
                <p><strong>👤 Nom d'utilisateur :</strong> ${member.username}</p>
                <p><strong>📧 Email :</strong> ${member.email}</p>
                <p><strong>🏷️ Type de membre :</strong> ${member.memberType.value}</p>
                <p><strong>📅 Date d'inscription :</strong> ${member.registrationDate}</p>
                <p><strong>✅ Statut :</strong> <span class="status-approved">Actif</span></p>
                <p><strong>📚 Quota de prêts :</strong> ${member.memberType.quotaLoan}</p>
                <p><strong>📋 Quota de réservations :</strong> ${member.memberType.quotaReservation}</p>
                <p><strong>🔄 Quota d'extensions :</strong> ${member.memberType.quotaExtension}</p>
                
                <div class="subscription-info">
                    <p><strong>💳 Abonnement :</strong></p>
                    <ul>
                        <li><strong>📜 Nom :</strong> ${subscription.subscriptionType.name}</li>
                        <li><strong>⏱️ Durée :</strong> ${subscription.subscriptionType.duration} jours</li>
                        <li><strong>📅 Date de début :</strong> ${subscription.subscriptionStart}</li>
                        <li><strong>🏁 Date de fin :</strong> ${subscription.subscriptionEnd}</li>
                    </ul>
                </div>
            </div>
        </div>

        
        <!-- Notifications Section -->
        <%-- <div id="notifications">
            <h3>Notifications</h3>
            
            <div class="notification-card">
                <h5>Extension ID : 6</h5>
                <p><strong>Due date ask :</strong> 2025-05-04</p>
                <p><strong>Extension date :</strong> 2025-04-30</p>
                <p><strong>Status :</strong> <span class="status-declined">Declined</span></p>
                <p><strong>Librarian :</strong> Jeanne</p>
                <p><strong>Treatment date :</strong> 2025-05-04</p>
                <div>
                    <p><strong>Loan ID :</strong> 14</p>
                    <div>
                        <strong>Copy :</strong>
                        <ul>
                            <li><strong>Copy ID :</strong> 2X</li>
                            <li><strong>Title :</strong> Harry Potter and the gobelets of fire</li>
                            <li><strong>Author :</strong> JK Rowling</li>
                            <li><strong>Book genre :</strong> Novel</li>
                        </ul>
                    </div>
                    <p><strong>Librarian loanner :</strong> Jeanne</p>
                    <p><strong>Start date :</strong> 2025-04-15</p>
                    <p><strong>Due date :</strong> 2025-05-01</p>
                </div>
            </div>
            
            <div class="notification-card">
                <h5>Reservation ID : 4</h5>
                <div>
                    <strong>Book :</strong>
                    <ul>
                        <li><strong>Book ID :</strong> 2</li>
                        <li><strong>Title :</strong> Harry Potter and the gobelets of fire</li>
                        <li><strong>Author :</strong> JK Rowling</li>
                        <li><strong>Book genre :</strong> Novel</li>
                    </ul>
                </div>
                <p><strong>Reservation date :</strong> 2025-04-29</p>
                <p><strong>Start date ask:</strong> 2025-05-20</p>
                <p><strong>Due date ask:</strong> 2025-05-30</p>
                <p><strong>Status :</strong> <span class="status-approved">Approved</span></p>
                <p><strong>Librarian :</strong> Jeanne</p>
                <p><strong>Treatment date :</strong> 2025-05-04</p>
                <div>
                    <li><strong>Copy ID :</strong> 2</li>
                    <p><strong>Start date :</strong> 2025-05-20</p>
                    <p><strong>Due date :</strong> 2025-05-30</p>
                </div>
            </div>
        </div>
         --%>
         
        <!-- Section des Prêts -->
        <div id="loans">
            <h2 class="section-title">📚 Mes Prêts en Cours</h2>
            <table id="loansTable">
                <thead>
                    <tr>
                        <th data-sort="loanId">🆔 ID Prêt</th>
                        <th data-sort="copyId">📋 ID Exemplaire</th>
                        <th data-sort="librarian">👨‍💼 Bibliothécaire</th>
                        <th data-sort="loanDate">📅 Date de Prêt</th>
                        <th data-sort="startDate">🏁 Date de Début</th>
                        <th data-sort="dueDate">⏰ Date d'Échéance</th>
                        <th>🔄 Extensions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="loan" items="${loans}">
                        <tr>
                            <td>${loan.id}</td>
                            <td>${loan.copy.copyId}</td>
                            <td>${loan.librarianLoan.username}</td>
                            <td>${loan.loanDate}</td>
                            <td>${loan.startDate}</td>
                            <td>${loan.dueDate}</td>
                            <td>
                                <form action="extension" method="post" class="extension-form">
                                    <input type="hidden" name="loan" value="${loan.id}">
                                    <input type="date" name="dueDate" required>
                                    <button type="submit">🔄 Prolonger</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty loans}">
                        <tr>
                            <td colspan="7" class="no-data">📚 Aucun prêt en cours</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <!-- Section des Réservations -->
        <div id="reservations">
            <h2 class="section-title">📋 Faire une Réservation</h2>
            <form action="reservation" method="post" class="reservation-form">
                <c:if test="${not empty error}">
                    <div class="error-message" style="background: #fee; color: #c33; padding: 1rem; border-radius: 5px; margin-bottom: 1rem; border-left: 4px solid #c33;">
                        ⚠️ ${error}
                    </div>
                </c:if>
                <c:choose>
                    <c:when test="${not empty book}">
                        <div class="book-reservation-info" style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; margin-bottom: 1.5rem; border-left: 4px solid #667eea;">
                            <h4 style="color: #2c3e50; margin-bottom: 1rem;">📚 Livre à Réserver :</h4>
                            <ul style="list-style: none; padding: 0;">
                                <li style="margin-bottom: 0.5rem;"><strong>🆔 ID :</strong> ${book.id}</li>
                                <li style="margin-bottom: 0.5rem;"><strong>📖 Titre :</strong> ${book.title}</li>
                                <li style="margin-bottom: 0.5rem;"><strong>✍️ Auteur :</strong> ${book.author.name}</li>
                                <li style="margin-bottom: 0.5rem;"><strong>📚 Genre :</strong> ${book.bookGenre.value}</li>
                            </ul>
                            <input type="hidden" name="book" value="${book.id}">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 2rem; background: #f8f9fa; border-radius: 10px; border: 2px dashed #bdc3c7;">
                            <p style="color: #7f8c8d; font-size: 1.1rem; margin-bottom: 1rem;">📚 Vous souhaitez réserver un livre ?</p>
                            <a href="home" style="background: linear-gradient(45deg, #667eea, #764ba2); color: white; padding: 1rem 2rem; text-decoration: none; border-radius: 25px; font-weight: 600; transition: all 0.3s ease; display: inline-block;">🏠 Choisir un livre</a>
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty book}">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1.5rem;">
                        <div class="form-group">
                            <label for="start_date" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #34495e;">📅 Date de début :</label>
                            <input type="date" name="start_date" id="start_date" required style="width: 100%; padding: 0.8rem; border: 2px solid #e1e8ed; border-radius: 8px; font-size: 1rem;">
                        </div>
                        <div class="form-group">
                            <label for="due_date" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #34495e;">🏁 Date de fin :</label>
                            <input type="date" name="due_date" id="due_date" required style="width: 100%; padding: 0.8rem; border: 2px solid #e1e8ed; border-radius: 8px; font-size: 1rem;">
                        </div>
                    </div>
                    <button type="submit" style="width: 100%; background: linear-gradient(45deg, #27ae60, #219a52); color: white; border: none; padding: 1rem; border-radius: 10px; font-size: 1.1rem; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">📋 Confirmer la Réservation</button>
                </c:if>
            </form>
        </div>
                    <input type="date" name="start_date" id="start_date" required>
                </div>
                
                <div class="form-group">
                    <label for="duration">Duration (days) :</label>
                    <input type="number" name="duration" id="duration" min="1" max="14" required>
                </div>
                
                <button type="submit">Reserve</button>
            </form>
        </div>
    </main>

    <script>
        // Tri du tableau
        document.addEventListener('DOMContentLoaded', function() {
            const table = document.getElementById('loansTable');
            if (table) {
                const headers = table.querySelectorAll('th[data-sort]');
                
                headers.forEach(header => {
                    header.addEventListener('click', () => {
                        const sortKey = header.getAttribute('data-sort');
                        const isAscending = header.classList.contains('sort-asc');
                        const newDir = isAscending ? 'desc' : 'asc';
                        
                        // Réinitialiser tous les en-têtes
                        headers.forEach(h => {
                            h.classList.remove('sort-asc', 'sort-desc');
                        });
                        
                        // Définir la nouvelle direction
                        header.classList.add('sort-' + newDir);
                        
                        // Trier le tableau
                        sortTable(table, sortKey, newDir);
                    });
                });
            }
            
            // Navigation entre sections
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const sectionId = this.getAttribute('data-section');
                    
                    // Masquer toutes les sections
                    document.querySelectorAll('.content-section').forEach(section => {
                        section.classList.remove('active');
                    });
                    
                    // Afficher la section sélectionnée
                    document.getElementById(sectionId).classList.add('active');
                });
            });
        });
        
        function sortTable(table, sortKey, direction) {
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            rows.sort((a, b) => {
                const aValue = a.querySelector('td:nth-child(' + getColumnIndex(table, sortKey) + ')').textContent;
                const bValue = b.querySelector('td:nth-child(' + getColumnIndex(table, sortKey) + ')').textContent;
                
                // Pour les dates
                if (sortKey.includes('Date')) {
                    return direction === 'asc' 
                        ? new Date(aValue) - new Date(bValue)
                        : new Date(bValue) - new Date(aValue);
                }
                
                // Pour les nombres
                if (!isNaN(aValue)) {
                    return direction === 'asc'
                        ? parseFloat(aValue) - parseFloat(bValue)
                        : parseFloat(bValue) - parseFloat(aValue);
                }
                
                // Pour les chaînes de caractères
                return direction === 'asc'
                    ? aValue.localeCompare(bValue)
                    : bValue.localeCompare(aValue);
            });
            
            // Réattacher les lignes triées
            rows.forEach(row => tbody.appendChild(row));
        }
        
        function getColumnIndex(table, sortKey) {
            const headers = table.querySelectorAll('th');
            for (let i = 0; i < headers.length; i++) {
                if (headers[i].getAttribute('data-sort') === sortKey) {
                    return i + 1;
                }
            }
            return 1;
        }
    </script>

</body>
</html>