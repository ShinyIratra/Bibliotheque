<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>LIBRARY</title>
<style>
    body {
        font-family: sans-serif;
        margin: 0;
        padding: 0;
        background-color: #fafafa;
    }

    header {
        background-color: #222;
        color: white;
        padding: 10px;
    }

    header h1 {
        margin: 0;
        font-size: 20px;
    }

    header nav ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        gap: 10px;
    }

    header nav a {
        color: white;
        text-decoration: none;
    }

    main {
        padding: 20px;
    }

    h3 {
        margin-top: 30px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        margin-bottom: 20px;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 5px 10px;
        text-align: left;
    }

    .notification-card {
        border: 1px solid #bbb;
        background-color: #fff;
        padding: 10px;
        margin: 10px 0;
    }

    form {
        margin: 10px 0;
        padding: 10px;
        background: #f2f2f2;
        border: 1px solid #ccc;
    }

    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    input, select, button {
        margin-bottom: 10px;
        padding: 5px;
        width: 100%;
        box-sizing: border-box;
    }

    .error-message {
        background: #ffdada;
        color: red;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid red;
    }

    .form-group ul {
        margin: 0;
        padding-left: 20px;
    }

    .form-group li {
        margin-bottom: 3px;
    }

    .action-link {
        color: blue;
        text-decoration: underline;
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
    <c:if test="${not empty error}">
        <div class="error-message">
            ${error}
        </div>
    </c:if>
    <!-- Zone des emprunts -->
<div id="loans">
    <h3>Active Loans</h3>
<c:choose>
    <c:when test="${empty loans}">
        <p>No active loans.</p>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
            <tr>
                <th>Loan ID</th>
                <th>Member</th>
                <th>Copy ID</th>
                <th>Librarian</th>
                <th>Loan Date</th>
                <th>Start Date</th>
                <th>Due Date</th>
                <th>Returned</th>
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
                                <form action="return-loan" method="post">
                                    <input type="hidden" name="loan" value="${loan.id}" />
                                    <button type="submit">Mark as Returned</button>
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
    <h3>Loan Extensions Requests</h3>
    <c:choose>
        <c:when test="${empty extensions}">
            <p>No extension requests.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="ext" items="${extensions}">
                <div class="notification-card">
                    <h5>Extension #${ext.id}</h5>
                    <p><strong>Requested Due Date:</strong> ${ext.askDueDate}</p>
                    <p><strong>Extension Date:</strong> ${ext.extensionDate}</p>

                    <p><strong>Loan:</strong> #${ext.loan.id} by ${ext.loan.member.username}</p>
                    <ul>
                        <li>Book Title: ${ext.loan.copy.book.title}</li>
                        <li>Author: ${ext.loan.copy.book.author.name}</li>
                        <li>Genre: ${ext.loan.copy.book.bookGenre.value}</li>
                    </ul>
                    <p><strong>Original Due Date:</strong> ${ext.loan.dueDate}</p>

                    <form action="extension-librarian" method="post">
                        <input type="hidden" name="extension" value="${ext.id}">
                        <label><input type="radio" name="decision" value="approve" required> Approve</label>
                        <label><input type="radio" name="decision" value="decline"> Decline</label>
                        <button type="submit">Submit</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <h3>Reservations Requests</h3>
    <c:choose>
        <c:when test="${empty reservations}">
            <p>No reservation requests.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="res" items="${reservations}">
                <div class="notification-card">
                    <h5>Reservation #${res.id}</h5>
                    <p><strong>Member:</strong> ${res.member.username}</p>
                    <ul>
                        <li>Book: ${res.book.title}</li>
                        <li>Author: ${res.book.author.name}</li>
                        <li>Genre: ${res.book.bookGenre.value}</li>
                    </ul>
                    <p><strong>Reservation Date:</strong> ${res.reservationDate}</p>
                    <p><strong>Requested Start Date:</strong> ${res.askStartDate}</p>
                    <p><strong>Requested Due Date:</strong> ${res.askDueDate}</p>

                    <form action="reservation-librarian" method="post">
                        <input type="hidden" name="reservation" value="${res.id}">
                        <label><input type="radio" name="decision" value="approve" required> Approve</label>
                        <label><input type="radio" name="decision" value="decline"> Decline</label>
                        <button type="submit">Submit</button>
                    </form>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

    <div id="read">
        <h3>Form to read a book in the library</h3>
        <form action="read" method="post">
            <c:choose>
                <c:when test="${not empty book_read}">
                    <div class="form-group">
                        <strong>Book :</strong>
                        <ul>
                            <li><strong>Book ID :</strong> ${book_read.id}</li>
                            <li><strong>Title :</strong> ${book_read.title}</li>
                            <li><strong>Author :</strong> ${book_read.author.name}</li>
                            <li><strong>Book genre :</strong> ${book_read.bookGenre.value}</li>
                        </ul>
                        <input type="hidden" name="book" value="${book_read.id}">
                    </div>
                </c:when>
                <c:otherwise>
                    <p><a href="home" class="action-link">Want to read a book? Choose one first</a></p>
                </c:otherwise>
            </c:choose>
            <label for="username">Username :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <button type="submit">Read</button>
        </form>
    </div>

    <div id="loan">
        <h3>Form to loan a book in the library</h3>
        <form action="loan" method="post">
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
                    <p><a href="home" class="action-link">Want to loan a book? Choose one first</a></p>
                </c:otherwise>
            </c:choose>
            <label for="username">Username :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <label for="duration">Duration :</label>
            <input type="number" name="duration" id="duration" min="1" required>
            <button type="submit">Loan</button>
        </form>
    </div>

    <div id="subscribe">
        <h3>Form to subscribe in the library</h3>
        <form action="subscribe" method="post">
            <label for="username">Username :</label>
            <input list="usernames" id="username" name="username" required />
            <datalist id="usernames">
                <c:forEach var="member" items="${members}">
                    <option value="${member.username}">${member.username}</option>
                </c:forEach>
            </datalist>
            <label for="subscription_type">Subscription type :</label>
            <select name="subscription_type" id="subscription_type" required>
                <option value="">Select subscription type</option>
                <c:forEach var="sub" items="${subscriptionTypes}">
                    <option value="${sub.id}">${sub.name}--${sub.duration}</option>
                </c:forEach>
            </select>
            <label for="start_date">Start date :</label>
            <input type="date" name="start_date" id="start_date" required><br>
            <button type="submit">Subscribe</button>
        </form>
    </div>
</main>
</body>
</html>
