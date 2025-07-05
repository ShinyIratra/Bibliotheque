<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Historique des prêts</title>
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
    </style>
</head>
<body>
<div class="container">
    <h2>Historique des prêts de l'adhérent</h2>
    <c:if test="${not empty erreur}">
        <div class="erreur">${erreur}</div>
    </c:if>
    <c:choose>
        <c:when test="${empty historique}">
            <div class="empty">Aucun prêt trouvé.</div>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Livre</th>
                    <th>Référence</th>
                    <th>Date de prêt</th>
                    <th>Date de retour prévue</th>
                    <th>Date de retour effective</th>
                    <th>Retard</th>
                    <th>Adhérent</th>
                    <th>Statut</th>
                    <th>Pénalité</th>
                </tr>
                <c:forEach items="${historique}" var="pret">
                    <tr>
                        <td><c:out value="${pret.titre}" default="—"/></td>
                        <td><c:out value="${pret.reference}" default="—"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.datePret}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.datePret}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.dateRetourPrevue}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.dateRetourPrevue}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.dateRetourEffective}"><span class="vide">Non rendu</span></c:when>
                                <c:otherwise>${pret.dateRetourEffective}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pret.retard}">Oui</c:when>
                                <c:otherwise>Non</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${empty pret.nomAdherent}"><span class="vide">—</span></c:when>
                                <c:otherwise>${pret.nomAdherent}</c:otherwise>
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
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
    <a href="front-office">Retour</a>
</div>
</body>
</html>