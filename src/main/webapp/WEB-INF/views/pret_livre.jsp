<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Prêter un livre</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f8f8; }
        .container { max-width: 600px; margin: 40px auto; background: #fff; padding: 30px 40px; border-radius: 8px; box-shadow: 0 2px 8px #ddd; }
        h2 { color: #2c3e50; }
        .erreur { color: red; font-weight: bold; }
        .empty { color: #bbb; font-style: italic; }
        label { display: block; margin-top: 12px; }
        select, input[type="date"] { width: 100%; padding: 6px; margin-top: 4px; }
        button { margin-top: 16px; background: #2980b9; color: #fff; border: none; padding: 8px 20px; border-radius: 4px; cursor: pointer; }
        button:hover { background: #1c5d8c; }
    </style>
</head>
<body>
<div class="container">
    <h2>Prêter un livre</h2>
    <c:if test="${quotaDepasse}">
        <div class="erreur">Vous avez atteint votre quota de prêts autorisés.</div>
    </c:if>
    <c:if test="${not empty erreurExemplaire}">
        <div class="erreur">${erreurExemplaire}</div>
    </c:if>
    <form action="pret" method="post">
        <div>
            <label>Type de prêt :</label>
            <select name="id_type_pret" required>
                <c:choose>
                    <c:when test="${empty typesPret}">
                        <option disabled selected>Aucun type de prêt</option>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${typesPret}" var="tp">
                            <option value="${tp.id_type_pret}">${tp.nom}</option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
        <div>
            <label>Date de début du prêt :</label>
            <input type="date" name="date_pret" required>
        </div>
        <div>
            <label>Date de retour :</label>
            <input type="date" name="date_retour" required>
        </div>
        <div>
            <label>Exemplaire à prêter :</label>
            <select name="id_exemplaire" required>
                <option disabled selected>Veuillez choisir une période</option>
            </select>
        </div>
        <button type="submit">Valider le prêt</button>
    </form>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    function updateExemplairesDisponibles() {
        const datePret = document.querySelector('input[name="date_pret"]').value;
        const dateRetour = document.querySelector('input[name="date_retour"]').value;
        if (!datePret || !dateRetour) return;
        fetch('/spring-web-1.0-SNAPSHOT/exemplaires-disponibles?date_pret=' + datePret + '&date_retour=' + dateRetour)
            .then(r => r.json())
            .then(exemplaires => {
                const select = document.querySelector('select[name="id_exemplaire"]');
                select.innerHTML = '';
                if (!exemplaires || exemplaires.length === 0) {
                    select.innerHTML = '<option disabled selected>Aucun exemplaire disponible</option>';
                } else {
                    exemplaires.forEach(ex => {
                        const opt = document.createElement('option');
                        opt.value = ex.id_exemplaire;
                        opt.textContent = (ex.reference || '—') + ' (Livre #' + (ex.id_livre || '—') + ')';
                        select.appendChild(opt);
                    });
                }
            });
    }
    const inputPret = document.querySelector('input[name="date_pret"]');
    const inputRetour = document.querySelector('input[name="date_retour"]');
    if (inputPret && inputRetour) {
        inputPret.addEventListener('change', updateExemplairesDisponibles);
        inputRetour.addEventListener('change', updateExemplairesDisponibles);
        updateExemplairesDisponibles();
    }
});
</script>
</body>
</html>