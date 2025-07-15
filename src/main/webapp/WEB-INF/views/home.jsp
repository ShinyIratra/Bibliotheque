<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>LIBRARY</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            color: #333;
        }
        
        header {
            background-color: #555;
            color: white;
            padding: 10px;
        }
        
        header h1 {
            margin: 0;
            text-align: center;
        }
        
        nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 10px 0;
        }
        
        nav a {
            color: white;
            text-decoration: none;
        }
        
        /* Contenu principal */
        main {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 10px;
            gap: 20px;
        }
        
        /* Filtres */
        .filters {
            background-color: #ddd;
            padding: 15px;
            width: 250px;
        }
        
        .filter-group {
            margin-bottom: 15px;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 5px;
        }
        
        .filter-group input, 
        .filter-group select {
            width: 100%;
            padding: 5px;
            box-sizing: border-box;
        }
        
        .date-range {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .theme-filters {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 5px;
        }
        
        .filter-button button {
            background-color: #777;
            color: white;
            border: none;
            padding: 8px;
            width: 100%;
        }
        
        /* Grille de livres */
        .books-grid {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 15px;
        }
        
        .book-card {
            background-color: #eee;
            padding: 15px;
            border: 1px solid #ccc;
        }
        
        .book-actions {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #ccc;
        }
        
        .book-action-form {
            margin-bottom: 5px;
        }
        
        .book-action-form button {
            background-color: #666;
            color: white;
            border: none;
            padding: 5px;
            width: 100%;
        }
    </style>
</head>
<body>
    <header>
        <h1>LIBRARY</h1>
        <nav>
        <c:choose>
            <c:when test="${not empty sessionScope.sessionLibrarian}">
                <ul>
                    <li><a href="">Home</a></li>
                    <li><a href="librarian">Librarian Menu</a></li>
                    <li><a href="disconnect">Disconnect</a></li>
                </ul>
            </c:when>
            <c:when test="${not empty sessionScope.sessionMember}">
                <ul>
                    <li><a href="">Home</a></li>
                    <li><a href="member">Member Menu</a></li>
                    <li><a href="disconnect">Disconnect</a></li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul>
                    <li><a href="librarian-login">Librarian Login</a></li>
                    <li><a href="member-login">Member Login</a></li>
                    <li><a href="registration">Registration</a></li>   
                </ul>
            </c:otherwise>
        </c:choose>
        </nav>
    </header>
    
    <main>
        <!-- Filters Section -->
        <div class="filters">
            <h3>Filters criteries</h3>
            <form action="home" method="get" class="filter-form">
                
                
                <div class="filter-group">
                    <label for="book_genre">Book genre</label>
                    <select name="book_genre" id="book_genre">
                        <option value="">Choose a book genre</option>
                        <c:forEach var="genre" items="${bookGenres}">
                            <option value="${genre.id}">${genre.value}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="author">Author</label>
                    <select name="author" id="author">
                        <option value="">Choose an author</option>
                        <c:forEach var="author" items="${authors}">
                            <option value="${author.id}">${author.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label>Edition date range</label>
                    <div class="date-range">
                        <input type="date" name="edition_date_min" id="edition_date_min">
                        <span>to</span>
                        <input type="date" name="edition_date_max" id="edition_date_max">
                    </div>
                </div>
                
                <div class="filter-button">
                    <button type="submit">Filter</button>
                </div>
            </form>
        </div>

        <!-- Books Grid -->
        <div class="books-grid">
            <c:forEach var="book" items="${books}">
                <!-- Book Card -->
                <div class="book-card">
                    <p><strong>Book ID:</strong> ${book.id}</p>
                    <p><strong>Title:</strong> ${book.title}</p>
                    <p><strong>Author:</strong> ${book.author.name}</p>
                    <p><strong>Genre:</strong> ${book.bookGenre.value}</p>
                    <p><strong>Edition date:</strong> ${book.editionDate}</p>
                    
                    <div>
                        <strong>Availability:</strong>
                        <ul>
                            <c:if test="${not empty book.checkDate}">
                                <li>Date to check: ${book.checkDate}</li>
                                <li>Is available:
                                    <c:choose>
                                        <c:when test="${book.available}">
                                            <strong style="color: #00ff00;">Yes</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong style="color: red;">No</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </c:if>
                            <c:if test="${empty book.checkDate}">
                                <li>No availability checked yet.</li>
                            </c:if>
                        </ul>
                    </div>

                    
                    <div class="book-actions">
                        <form action="avalaibility" method="get" class="book-action-form">
                            <input type="hidden" name="book" value="${book.id}">
                            <label for="date_start">Date start:</label>
                            <input type="date" name="date_start" id="date_start" required>
                            <button type="submit">Check Availability</button>
                        </form>

                        <c:choose>
                            <c:when test="${not empty sessionScope.sessionLibrarian}">
                                <form action="form-loan" method="post" class="book-action-form">
                                    <input type="hidden" name="book" value="${book.id}">
                                    <button type="submit">Loan the book</button>
                                </form><br>
                                <form action="form-read" method="post" class="book-action-form">
                                    <input type="hidden" name="book_read" value="${book.id}">
                                    <button type="submit">Read the book</button>
                                </form>
                            </c:when>

                            <c:when test="${not empty sessionScope.sessionMember}">
                                <form action="form-reservation" method="post" class="book-action-form">
                                    <input type="hidden" name="book" value="${book.id}">
                                    <button type="submit">Reserve the book</button>
                                </form>
                            </c:when>

                            <c:otherwise>
                                <p><a href="#" class="action-link">Want some actions? Connect first</a></p>
                            </c:otherwise>
                        </c:choose>
                </div>
            </c:forEach>
        </div>

    </main>


</body>
</html>