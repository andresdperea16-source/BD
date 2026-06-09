<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Créditos</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .top-bar h2 { color: #1a3c5e; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primary { background: #1a3c5e; color: white; }
        .btn-primary:hover { background: #2a5c8e; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-Aprobado { background: #d4edda; color: #155724; }
        .badge-En\ estudio { background: #fff3cd; color: #856404; }
        .badge-Rechazado { background: #f8d7da; color: #721c24; }
        .success { background: #d4edda; color: #155724; padding: 12px; border-radius: 6px; margin-bottom: 15px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="top-bar">
        <h2>💰 Gestión de Créditos</h2>
        <a href="${pageContext.request.contextPath}/creditos?accion=nuevo" class="btn btn-primary">+ Nuevo Crédito</a>
    </div>
    <c:if test="${param.msg == 'ok'}">
        <div class="success">✅ Operación realizada exitosamente.</div>
    </c:if>
    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>Radicado</th><th>Asociado</th><th>Línea</th>
                    <th>Valor solicitado</th><th>Plazo</th><th>Estado</th><th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="c" items="${creditos}">
                <tr>
                    <td>${c.numeroRadicado}</td>
                    <td>${c.cedulaAsociado}</td>
                    <td>${c.lineaCredito}</td>
                    <td>$ ${c.valorSolicitado}</td>
                    <td>${c.plazoMeses} meses</td>
                    <td><span class="badge badge-${c.estado}">${c.estado}</span></td>
                    <td><a href="${pageContext.request.contextPath}/creditos?accion=ver&radicado=${c.numeroRadicado}">👁️ Ver</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
