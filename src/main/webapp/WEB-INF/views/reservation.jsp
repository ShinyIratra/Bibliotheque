<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Réserver un exemplaire</title>
    <style>
        :root {
            --black: #18181b;
            --white: #fff;
            --gray-100: #f4f4f5;
            --gray-200: #e4e4e7;
            --gray-300: #d4d4d8;
            --gray-400: #a1a1aa;
            --gray-700: #3f3f46;
            --accent: #2563eb;
            --danger: #e11d48;
            --shadow: 0 4px 24px #e4e4e7;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: var(--gray-100);
            color: var(--black);
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 48px auto;
            background: var(--white);
            padding: 40px 48px 32px 48px;
            border-radius: 14px;
            box-shadow: 0 4px 24px var(--gray-200);
            border: 1px solid var(--gray-200);
        }
        h2 {
            color: var(--black);
            font-size: 2em;
            font-weight: 700;
            margin-bottom: 28px;
        }
        .erreur {
            color: var(--danger);
            font-weight: 600;
            margin-bottom: 14px;
        }
        .message {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 14px;
        }
        label {
            display: block;
            margin-top: 12px;
            font-weight: 500;
        }
        select, input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 6px;
            border: 1px solid var(--gray-300);
            background: var(--gray-100);
            color: var(--black);
        }
        button {
            margin-top: 16px;
            background: var(--black);
            color: var(--white);
            border: none;
            padding: 10px 22px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1em;
            cursor: pointer;
            box-shadow: 0 2px 8px var(--gray-200);
            transition: background 0.18s, color 0.18s, transform 0.12s;
        }
        button:hover {
            background: var(--accent);
            color: var(--white);
            transform: translateY(-2px) scale(1.04);
        }
        .empty {
            color: var(--gray-400);
            font-style: italic;
        }
        .explication {
            color: var(--gray-700);
            font-size: 0.97em;
            margin-bottom: 10px;
        }
        @media (max-width: 700px) {
            .container { padding: 18px 6vw; }
            h2 { font-size: 1.3em; }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Réserver un exemplaire</h2>
    <c:if test="${not empty erreur}">
        <div class="erreur">${erreur}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    <form action="reservation" method="post">
        <div>
            <label>Date de réservation souhaitée :</label>
            <input type="date" name="date_reserver" required>
        </div>
        <div>
            <label>Exemplaires disponibles ou réservables :</label>
            <select name="id_exemplaire" required>
                <c:choose>
                    <c:when test="${empty exemplaires}">
                        <option disabled selected>Aucun exemplaire à réserver ou emprunter</option>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${exemplaires}" var="ex">
                            <option value="${ex.id_exemplaire}">
                                <c:out value="${ex.reference != null ? ex.reference : ex.Reference}" default="—"/>
                                (ID: <c:out value="${ex.id_exemplaire}"/>)
                                <c:choose>
                                    <c:when test="${ex.suggestion == 'pret_possible'}">
                                        - Disponible : prêt immédiat possible
                                    </c:when>
                                    <c:when test="${ex.suggestion == 'reservation_possible'}">
                                        - Réservable à la date choisie
                                    </c:when>
                                    <c:otherwise>
                                        - Indisponible
                                    </c:otherwise>
                                </c:choose>
                            </option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
        <button type="submit">Valider</button>
    </form>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.querySelector('input[name="date_reserver"]');
    const selectEx = document.querySelector('select[name="id_exemplaire"]');

    function updateExemplaires() {
        const date = dateInput.value;
        selectEx.innerHTML = '';
        // Option par défaut
        const optDefault = document.createElement('option');
        optDefault.disabled = true;
        optDefault.selected = true;
        optDefault.textContent = 'Veuillez choisir une date';
        selectEx.appendChild(optDefault);

        if (!date) return;
        fetch('/spring-web-1.0-SNAPSHOT/exemplaires-non-disponibles?date=' + date)
            .then(r => r.json())
            .then(exemplaires => {
                selectEx.innerHTML = '';
                if (!exemplaires || exemplaires.length === 0) {
                    const opt = document.createElement('option');
                    opt.disabled = true;
                    opt.selected = true;
                    opt.textContent = 'Aucun exemplaire à réserver ou emprunter';
                    selectEx.appendChild(opt);
                } else {
                    exemplaires.forEach(ex => {
                        const opt = document.createElement('option');
                        opt.value = ex.id_exemplaire;
                        let label = (ex.reference || ex.Reference || '—') + ' (ID: ' + ex.id_exemplaire + ')';
                        if (ex.suggestion === 'pret_possible') {
                            label += ' - Disponible : prêt immédiat possible';
                        } else if (ex.suggestion === 'reservation_possible') {
                            label += ' - Réservable à la date choisie';
                        } else {
                            label += ' - Indisponible';
                        }
                        opt.textContent = label;
                        selectEx.appendChild(opt);
                    });
                }
            });
    }

    if (dateInput) {
        dateInput.addEventListener('change', updateExemplaires);
        if (dateInput.value) updateExemplaires();
    }
});
</script>
</body>
</html>