<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>LIBRARY</title>
    <style>
        /* Reset de base */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }
        
        /* En-tête */
        .futuristic-header {
            background-color: #333;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        
        .futuristic-header h1 {
            margin: 0;
        }
        
        .futuristic-nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 1rem 0 0;
        }
        
        .futuristic-nav a {
            color: white;
            text-decoration: none;
        }
        
        /* Contenu principal */
        .futuristic-main {
            display: flex;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .futuristic-container {
            width: 100%;
            max-width: 600px;
        }
        
        .futuristic-content {
            background-color: white;
            padding: 2rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 2rem;
            color: #444;
        }
        
        /* Formulaire */
        .futuristic-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group input,
        .input-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }
        
        .input-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #666;
        }
        
        /* Masquer le highlight futuriste */
        .input-highlight {
            display: none;
        }
        
        /* Bouton */
        .futuristic-btn {
            background-color: #555;
            color: white;
            border: none;
            padding: 0.8rem;
            font-size: 1rem;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 1rem;
        }
        
        .futuristic-btn:hover {
            background-color: #666;
        }

        .error-message {
            color: red;
            background-color: #ffe6e6;
            border: 1px solid red;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 4px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header class="futuristic-header">
        <h1>LIBRARY</h1>
        <nav class="futuristic-nav">
            <ul>
                <li><a href="home.html">Home</a></li>
            </ul>
        </nav>
    </header>
    <main class="futuristic-main">
        <div class="futuristic-container">
            <div class="futuristic-content">
                <h3 class="section-title">Form to registre as a member</h3>
                    <!-- Message d'erreur -->
                <c:if test="${not empty error}">
                    <div class="error-message">
                        ${error}
                    </div>
                </c:if>

            <form id="futuristicForm" action="add-member" method="post" class="futuristic-form">
                <div class="input-group">
                    <input type="email" name="email" id="email" placeholder="Ex : jean@mail.com" required>
                    <label for="email">Email</label>
                </div>
                <div class="input-group">
                    <input type="text" name="username" id="username" placeholder="Ex : Jean" required>
                    <label for="username">Username</label>
                </div>
                <div class="input-group">
                    <input type="date" name="birth" id="birth" required>
                    <label for="birth">Birth</label>
                </div>
                <div class="input-group">
                    <select name="member_type" id="member_type" required>
                        <option value="">Select member type</option>
                        <c:forEach var="type" items="${memberTypes}">
                            <option value="${type.id}">${type.value}</option>
                        </c:forEach>
                    </select>
                    <label for="member_type">Member type</label>
                </div>
                <div class="input-group">
                    <select name="subscription_type" id="subscription_type" required>
                        <option value="">Select subscription type</option>
                        <c:forEach var="sub" items="${subscriptionTypes}">
                            <option value="${sub.id}">${sub.name}--${sub.duration}</option>
                        </c:forEach>
                    </select>
                    <label for="subscription_type">Subscription type</label>
                </div>
                <div class="input-group">
                    <input type="password" name="password" id="password" required>
                    <label for="password">Password</label>
                </div>
                <div class="input-group">
                    <input type="password" name="confirm_password" id="confirm_password" required>
                    <label for="confirm_password">Confirm password</label>
                </div>
                <button type="submit" class="futuristic-btn">Sign up</button>
            </form>
            </div>
        </div>
    </main>


</body>
</html>