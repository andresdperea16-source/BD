<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Codeudorías Activas</title>
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
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-Aprobado { background: #d4edda; color: #155724; }
        .badge-En\ estudio { background: #fff3cd; color: #856404; }
        .total { padding: 12px 15px; font-weight: bold; color: #1a3c5e; font-size: 14px; }
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
    <h2>🤝 Reporte 7: Asociados con Codeudoría Activa</h2>
    <div class="card">
        <table>
            <thead>
                <tr><th>Radicado</th><th>Titular</th><th>Codeudor</th><th>Valor aprobado</th><th>Fecha aprobación</th><th>Estado</th></tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${datos}">
                <tr>
                    <td>${f.numeroRadicado}</td>
                    <td>${f.titular}</td>
                    <td>${f.codeudor}</td>
                    <td>$ ${f.valorAprobado}</td>
                    <td>${f.fechaAprobacion}</td>
                    <td><span class="badge badge-${f.estado}">${f.estado}</span></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="total">Total créditos con codeudor: ${datos.size()}</div>
    </div>
</div>
</body>
</html>
