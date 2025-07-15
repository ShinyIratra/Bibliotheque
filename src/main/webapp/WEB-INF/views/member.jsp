<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>LIBRARY</title>
    <style>
        main {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        padding: 20px;
        max-width: 1000px;
        margin: auto;
        }

        #card, #loans, #reservations {
        background: #fff;
        border: 1px solid #ccc;
        border-radius: 6px;
        padding: 15px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.1);
        }

        #card {
        grid-column: 1 / 2; /* Colonne 1 */
        }

        #loans {
        grid-column: 2 / 3; /* Colonne 2 */
        }

        #reservations {
        grid-column: 1 / 3; /* Prend toute la largeur sous les deux autres */
        }

        @media (max-width: 768px) {
        main {
            grid-template-columns: 1fr;
        }
        #card, #loans, #reservations {
            grid-column: auto;
        }
        }
    </style>
</head>
<body>
    <header>
        <h1>LIBRARY</h1>
        <nav>
            <ul>
                <li><a href="home">Home</a></li>
                <li><a href="disconnect">Disconnect</a></li>
            </ul>
        </nav>
    </header>
    
    
    <main>
        <!-- Member Card Section -->
       <div id="card" >
            <div class="member-card">
                <p><strong>Member Id :</strong> ${member.id}</p>
                <p><strong>Username :</strong> ${member.username}</p>
                <p><strong>Email :</strong> ${member.email}</p>
                <p><strong>Member type :</strong> ${member.memberType.value}</p>
                <p><strong>Registration date :</strong> ${member.registrationDate}</p>
                <p><strong>Status :</strong> <span class="status-approved">active</span></p>
                <p><strong>Loan quota :</strong> ${member.memberType.quotaLoan}</p>
                <p><strong>Reservation quota :</strong> ${member.memberType.quotaReservation}</p>
                <p><strong>Extension quota :</strong> ${member.memberType.quotaExtension}</p>
                <p><strong>Subscription :</strong></p>
                <ul>
                    <li><strong>Name :</strong> ${subscription.subscriptionType.name}</li>
                    <li><strong>Duration :</strong> ${subscription.subscriptionType.duration} days</li>
                    <li><strong>Start date :</strong> ${subscription.subscriptionStart}</li>
                    <li><strong>End date :</strong> ${subscription.subscriptionEnd}</li>
                </ul>
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
         
        <!-- Loans Section -->
        <div id="loans">
            <h3>My loans</h3>
            <table id="loansTable">
                <thead>
                    <tr>
                        <th data-sort="loanId">Loan ID</th>
                        <th data-sort="copyId">Copy ID</th>
                        <th data-sort="librarian">Librarian</th>
                        <th data-sort="loanDate">Loan Date</th>
                        <th data-sort="startDate">Start Date</th>
                        <th data-sort="dueDate">Due Date</th>
                        <th>Extensions</th>
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
                                    <div class="form-group">
                                        <label for="extension">Extension (days):</label>
                                        <input type="number" name="duration" id="duration" min="1" max="7" required>
                                    </div>
                                    <button type="submit">Ask for extension</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
        
        <!-- Reservations Section -->
        <div id="reservations">
            <h3>Do a reservation</h3>
            <form action="reservation" method="post" class="reservation-form">
                <c:if test="${not empty error}">
                    <div class="error-message">
                        ${error}
                    </div>
                </c:if>
                <c:choose>
                    <c:when test="${not empty book}">
                        <div class="form-group">
                            <strong>Book :</strong>
                            <ul>
                                <li><strong>Book ID :</strong> ${book.id}</li>
                                <li><strong>Title :</strong> ${book.title}</li>
                                <li><strong>Author :</strong> ${book.author.name}</li>
                                <li><strong>Book genre :</strong> ${book.bookGenre.value}</li>
                            </ul>
                            <input type="hidden" name="book" value="${book.id}">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p><a href="home" class="action-link">Want to reserve a book? Choose one first</a></p>
                    </c:otherwise>
                </c:choose>

                <div class="form-group">
                    <label for="start_date">Start date :</label>
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
                        header.classList.add(`sort-${newDir}`);
                        
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
                const aValue = a.querySelector(`td:nth-child(${getColumnIndex(table, sortKey)})`).textContent;
                const bValue = b.querySelector(`td:nth-child(${getColumnIndex(table, sortKey)})`).textContent;
                
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