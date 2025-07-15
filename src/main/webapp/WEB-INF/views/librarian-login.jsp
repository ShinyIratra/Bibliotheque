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
        }
        
        /* En-tête */
        .cyber-header {
            background-color: #333;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        
        .cyber-header h1 {
            margin: 0;
        }
        
        .cyber-nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 1rem 0 0;
        }
        
        .cyber-nav a {
            color: white;
            text-decoration: none;
        }
        
        /* Contenu principal */
        .cyber-main {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 120px);
            padding: 2rem;
        }
        
        /* Conteneur de login */
        .login-container {
            background-color: #e0e0e0;
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            position: relative;
            border: 1px solid #aaa;
        }
        
        .scanline {
            height: 2px;
            background-color: #777;
            margin-bottom: 1rem;
        }
        
        .login-title {
            text-align: center;
            margin-top: 0;
            color: #444;
        }
        
        /* Formulaire */
        .cyber-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .input-field {
            position: relative;
        }
        
        .input-field input {
            width: 100%;
            padding: 0.8rem;
            background-color: #f0f0f0;
            border: 1px solid #999;
            box-sizing: border-box;
        }
        
        .input-field label {
            position: absolute;
            left: 0.8rem;
            top: 0.8rem;
            color: #666;
            transition: all 0.3s;
            pointer-events: none;
        }
        
        .input-field input:focus + label,
        .input-field input:not(:placeholder-shown) + label {
            top: -0.8rem;
            left: 0.5rem;
            font-size: 0.8rem;
            background-color: #e0e0e0;
            padding: 0 0.3rem;
            color: #333;
        }
        
        /* Bouton */
        .cyber-btn {
            background-color: #555;
            color: white;
            border: none;
            padding: 0.8rem;
            cursor: pointer;
            font-size: 1rem;
        }
        
        .cyber-btn:hover {
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
    <header class="cyber-header">
        <h1>LIBRARY</h1>
        <nav class="cyber-nav">
            <ul>
                <li><a href="home">Home</a></li>
            </ul>
        </nav>
    </header>
    <main class="cyber-main">
        <div class="login-container">
            <div class="scanline"></div>
            <h3 class="login-title">Connect as a librarian</h3>
            <c:if test="${not empty error}">
                    <div class="error-message">
                        ${error}
                    </div>
                </c:if>
            <form id="cyberLoginForm" action="librarian-connect" method="post" class="cyber-form">
                <div class="input-field">
                    <input type="text" name="username" id="username"  required>
                    <label for="username">Username</label>
                </div>
                <div class="input-field">
                    <input type="password" name="password" id="password"  required>
                    <label for="password">Password</label>
                </div>
                <button type="submit" class="cyber-btn">Connect</button>
            </form>
        </div>
    </main>

</body>
</html>