<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Bibliothèque - Connexion Membre</title>
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
        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            max-width: 450px;
            margin: 3rem auto;
            padding: 0 1.5rem;
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
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 450px;
            position: relative;
            overflow: hidden;
        }
        
        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }
        
        .login-title {
            text-align: center;
            color: #2c3e50;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .form-group {
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #34495e;
            font-size: 1.1rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .login-button {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 1.2rem;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            margin-top: 1rem;
        }
        
        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #c33;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #ecf0f1;
        }
        
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .register-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            main {
                padding: 1rem;
            }
            
            .login-container {
                padding: 2rem;
                margin: 1rem;
            }
            
            nav ul {
                gap: 1rem;
            }
            
            nav a {
                padding: 0.6rem 1rem;
                font-size: 0.9rem;
            }
        }
        
        /* Animation d'apparition */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-container {
            animation: fadeInUp 0.6s ease forwards;
        }
    </style>
</head>
<body>
    <header>
        <h1>📚 BIBLIOTHÈQUE</h1>
        <nav>
            <ul>
                <li><a href="home">🏠 Accueil</a></li>
                <li><a href="librarian-login">👨‍💼 Bibliothécaire</a></li>
                <li><a href="registration">✍️ Inscription</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <div class="login-container">
            <h2 class="login-title">👤 Connexion Membre</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠️ ${error}
                </div>
            </c:if>
            
            <form id="memberLoginForm" action="member-connect" method="post" class="login-form">
                <div class="form-group">
                    <label for="username">👤 Nom d'utilisateur</label>
                    <input type="text" name="username" id="username" required placeholder="Entrez votre nom d'utilisateur">
                </div>
                
                <div class="form-group">
                    <label for="password">🔒 Mot de passe</label>
                    <input type="password" name="password" id="password" required placeholder="Entrez votre mot de passe">
                </div>
                
                <button type="submit" class="login-button">🚪 Se Connecter</button>
            </form>
            
            <div class="register-link">
                <p>Pas encore membre ? <a href="registration">✍️ S'inscrire ici</a></p>
            </div>
        </div>
    </main>

    <script>
        // Améliorations interactives
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });
            
            // Animation du bouton de connexion
            const loginButton = document.querySelector('.login-button');
            loginButton.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05) translateY(-2px)';
            });
            
            loginButton.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1) translateY(0)';
            });
        });
    </script>

</body>
</html>
