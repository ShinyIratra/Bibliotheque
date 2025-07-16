<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Bibliothèque - Inscription</title>
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
        
        /* Header & Navigation */
        header {
            background: white;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
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
        main {
            display: flex;
            flex-direction: column;
            max-width: 600px;
            margin: 3rem auto;
            padding: 0 1.5rem;
        }
        
        .registration-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            overflow: hidden;
            padding: 2rem;
        }
        
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
        
        /* Formulaire */
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid var(--gray-light);
            border-radius: 8px;
            font-size: 0.95rem;
            transition: var(--transition);
            background: white;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
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