<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Administrador</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 20px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; }
        .navbar a:hover { text-decoration: underline; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        .welcome { background: white; padding: 20px 25px; border-radius: 8px; margin-bottom: 25px; border-left: 5px solid #1a3c5e; }
        .welcome h2 { color: #1a3c5e; margin-bottom: 5px; }
        .welcome p { color: #666; font-size: 14px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .card { background: white; padding: 25px; border-radius: 8px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); text-decoration: none; color: inherit; border-top: 4px solid #1a3c5e; transition: transform 0.2s; }
        .card:hover { transform: translateY(-3px); box-shadow: 0 6px 16px rgba(0,0,0,0.12); }
        .card .icon { font-size: 36px; margin-bottom: 12px; }
        .card h3 { color: #1a3c5e; font-size: 15px; }
        .section-title { color: #1a3c5e; font-size: 18px; margin-bottom: 15px; font-weight: bold; }
        .reportes-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px; }
        .reporte-card { background: white; padding: 18px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .reporte-card h4 { color: #1a3c5e; margin-bottom: 8px; font-size: 14px; }
        .reporte-card a { display: inline-block; margin-top: 8px; padding: 6px 14px; background: #1a3c5e; color: white; border-radius: 4px; text-decoration: none; font-size: 13px; }
        .reporte-card a:hover { background: #2a5c8e; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA Ltda.</h1>
    <div>
        <span style="margin-right:20px">👤 ${sessionScope.usuario.nombreUsuario} — Administrador</span>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="welcome">
        <h2>Bienvenido, ${sessionScope.usuario.nombreUsuario}</h2>
        <p>Panel de administración del sistema COOVALLUNA</p>
    </div>

    <div class="grid">
        <a href="${pageContext.request.contextPath}/asociados" class="card">
            <div class="icon">👥</div>
            <h3>Asociados</h3>
        </a>
        <a href="${pageContext.request.contextPath}/creditos" class="card">
            <div class="icon">💰</div>
            <h3>Créditos</h3>
        </a>
        <a href="${pageContext.request.contextPath}/cuentas" class="card">
            <div class="icon">🏧</div>
            <h3>Cuentas de Ahorro</h3>
        </a>
        <a href="${pageContext.request.contextPath}/reportes" class="card">
            <div class="icon">📊</div>
            <h3>Reportes</h3>
        </a>
    </div>

    <div class="section-title">Acceso rápido a reportes</div>
    <div class="reportes-grid">
        <div class="reporte-card">
            <h4>📋 Asociados por estado y agencia</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=1">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>📄 Extracto de cuenta</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=2">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>📈 Cartera por línea y estado</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=3">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>⚠️ Asociados en mora</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=4">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>🗓️ Historial de pagos</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=5">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>👨‍💼 Productividad asesores</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=6">Ver reporte</a>
        </div>
        <div class="reporte-card">
            <h4>🤝 Codeudorías activas</h4>
            <a href="${pageContext.request.contextPath}/reportes?tipo=7">Ver reporte</a>
        </div>
    </div>
</div>
</body>
</html>
