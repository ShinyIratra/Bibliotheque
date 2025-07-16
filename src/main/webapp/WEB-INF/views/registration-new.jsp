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
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .registration-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 600px;
            position: relative;
            overflow: hidden;
        }
        
        .registration-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #27ae60, #219a52);
        }
        
        .registration-title {
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
        
        .registration-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .form-group {
            position: relative;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #34495e;
            font-size: 1rem;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #27ae60;
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
            transform: translateY(-2px);
        }
        
        .registration-button {
            background: linear-gradient(45deg, #27ae60, #219a52);
            color: white;
            border: none;
            padding: 1.2rem;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
            margin-top: 1rem;
            grid-column: 1 / -1;
        }
        
        .registration-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #c33;
            margin-bottom: 1rem;
            text-align: center;
            grid-column: 1 / -1;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #28a745;
            margin-bottom: 1rem;
            text-align: center;
            grid-column: 1 / -1;
        }
        
        .login-links {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #ecf0f1;
            grid-column: 1 / -1;
        }
        
        .login-links a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }
        
        .login-links a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .form-info {
            background: #e8f4f8;
            color: #2980b9;
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            grid-column: 1 / -1;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            main {
                padding: 1rem;
            }
            
            .registration-container {
                padding: 2rem;
                margin: 1rem;
            }
            
            .registration-form {
                grid-template-columns: 1fr;
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
        
        .registration-container {
            animation: fadeInUp 0.6s ease forwards;
        }
        
        /* Animation pour les champs requis */
        .form-group input:required:invalid {
            border-color: #e74c3c;
        }
        
        .form-group input:required:valid {
            border-color: #27ae60;
        }
    </style>
</head>
<body>
    <header>
        <h1>📚 BIBLIOTHÈQUE</h1>
        <nav>
            <ul>
                <li><a href="home">🏠 Accueil</a></li>
                <li><a href="member-login">👤 Connexion Membre</a></li>
                <li><a href="librarian-login">👨‍💼 Connexion Bibliothécaire</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <div class="registration-container">
            <h2 class="registration-title">✍️ Inscription à la Bibliothèque</h2>
            
            <div class="form-info">
                <strong>ℹ️ Information :</strong> Votre inscription sera validée par un bibliothécaire avant activation de votre compte.
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ⚠️ ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="success-message">
                    ✅ ${success}
                </div>
            </c:if>
            
            <form id="registrationForm" action="registration" method="post" class="registration-form">
                <div class="form-group">
                    <label for="username">👤 Nom d'utilisateur *</label>
                    <input type="text" name="username" id="username" required placeholder="Choisissez un nom d'utilisateur">
                </div>
                
                <div class="form-group">
                    <label for="email">📧 Adresse email *</label>
                    <input type="email" name="email" id="email" required placeholder="votre.email@exemple.com">
                </div>
                
                <div class="form-group">
                    <label for="password">🔒 Mot de passe *</label>
                    <input type="password" name="password" id="password" required placeholder="Mot de passe sécurisé">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">🔒 Confirmer le mot de passe *</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Répétez le mot de passe">
                </div>
                
                <div class="form-group">
                    <label for="firstName">👤 Prénom *</label>
                    <input type="text" name="firstName" id="firstName" required placeholder="Votre prénom">
                </div>
                
                <div class="form-group">
                    <label for="lastName">👤 Nom de famille *</label>
                    <input type="text" name="lastName" id="lastName" required placeholder="Votre nom de famille">
                </div>
                
                <div class="form-group">
                    <label for="phone">📞 Téléphone</label>
                    <input type="tel" name="phone" id="phone" placeholder="Votre numéro de téléphone">
                </div>
                
                <div class="form-group">
                    <label for="memberType">🏷️ Type de membre</label>
                    <select name="memberType" id="memberType">
                        <option value="">Choisir un type de membre</option>
                        <c:forEach var="type" items="${memberTypes}">
                            <option value="${type.id}">${type.value}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group full-width">
                    <label for="address">🏠 Adresse complète</label>
                    <input type="text" name="address" id="address" placeholder="Votre adresse complète">
                </div>
                
                <button type="submit" class="registration-button">✍️ S'inscrire à la Bibliothèque</button>
            </form>
            
            <div class="login-links">
                <p>Déjà inscrit ? 
                    <a href="member-login">👤 Connexion Membre</a> | 
                    <a href="librarian-login">👨‍💼 Connexion Bibliothécaire</a>
                </p>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registrationForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            
            // Validation du mot de passe en temps réel
            function validatePasswords() {
                if (password.value !== confirmPassword.value) {
                    confirmPassword.setCustomValidity('Les mots de passe ne correspondent pas');
                    confirmPassword.style.borderColor = '#e74c3c';
                } else {
                    confirmPassword.setCustomValidity('');
                    confirmPassword.style.borderColor = '#27ae60';
                }
            }
            
            password.addEventListener('input', validatePasswords);
            confirmPassword.addEventListener('input', validatePasswords);
            
            // Améliorations interactives
            const inputs = document.querySelectorAll('input, select');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });
            
            // Animation du bouton d'inscription
            const registrationButton = document.querySelector('.registration-button');
            registrationButton.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05) translateY(-2px)';
            });
            
            registrationButton.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1) translateY(0)';
            });
            
            // Validation du formulaire
            form.addEventListener('submit', function(e) {
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    alert('Les mots de passe ne correspondent pas !');
                    return false;
                }
            });
        });
    </script>

</body>
</html>
