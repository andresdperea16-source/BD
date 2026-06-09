<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Asociados en Mora</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 20px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #c0392b; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #fff5f5; }
        .dias-mora { color: #c0392b; font-weight: bold; }
        .total { padding: 12px 15px; font-weight: bold; color: #c0392b; font-size: 14px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/reportes">← Reportes</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <h2>⚠️ Reporte 4: Asociados en Mora</h2>
    <div class="card">
        <table>
            <thead>
                <tr><th>Asociado</th><th>Crédito</th><th>N° Cuota</th><th>Fecha vencimiento</th><th>Días en mora</th><th>Asesor responsable</th></tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${datos}">
                <tr>
                    <td>${f.asociado}</td>
                    <td>${f.numeroRadicado}</td>
                    <td>${f.numeroCuota}</td>
                    <td>${f.fechaVencimiento}</td>
                    <td class="dias-mora">${f.diasMora} días</td>
                    <td>${f.asesor}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="total">Total cuotas vencidas: ${datos.size()}</div>
    </div>
</div>
</body>
</html>
