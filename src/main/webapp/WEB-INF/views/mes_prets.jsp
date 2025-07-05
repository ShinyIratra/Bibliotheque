<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes prêts en cours</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f8f8; }
        .container { max-width: 1000px; margin: 40px auto; background: #fff; padding: 30px 40px; border-radius: 8px; box-shadow: 0 2px 8px #ddd; }
        h2 { color: #2c3e50; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #aaa; padding: 8px 12px; text-align: left; }
        th { background: #f2f2f2; }
        tr:nth-child(even) { background: #fafafa; }
        tr:hover { background: #e6f7ff; }
        .empty, .vide { color: #bbb; font-style: italic; }
        .message { color: green; font-weight: bold; }
        .erreur { color: red; font-weight: bold; }
        button { background: #2980b9; color: #fff; border: none; padding: 6px 16px; border-radius: 4px; cursor: pointer; }
        button:hover { background: #1c5d8c; }
        a { color: #2980b9; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h2>Mes prêts en cours</h2>
    <c:if test="${not empty erreur}">
        <div class="erreur">${erreur}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="message">${message}</div>
    </c:if>
    <c:choose>
        <c:when test="${empty prets}">
            <div class="empty">Aucun prêt en cours.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Livre</th>
                    <th>Référence</th>
                    <th>Date de prêt</th>
                    <th>Date de retour prévue</th>
                    <th>Statut</th>
                    <th>Pénalité</th>
                    <th>Action</th>
                </tr>
                <c:forEach items="${prets}" var="pret">
                    <tr>
                        <td><c:out value="${pret.titre}" default="—"/></td>
                        <td><c:out value="${pret.reference}" default="—"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.date_pret}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.date_pret}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.date_retour}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.date_retour}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.statut}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.statut}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pret.penalite}">Oui <c:if test="${not empty pret.montantPenalite}">(${pret.montantPenalite} €)</c:if></c:when>
                                <c:otherwise>Non</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form action="prolonger" method="post" style="display:inline;">
                                <input type="hidden" name="id_pret" value="${pret.id_pret}" />
                                <button type="submit">Prolonger</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
    <a href="front-office">Retour</a>
</div>
</body>
</html>