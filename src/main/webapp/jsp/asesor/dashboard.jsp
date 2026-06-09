<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Asesor/Cajero</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a5e3a; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 20px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        .welcome { background: white; padding: 20px 25px; border-radius: 8px; margin-bottom: 25px; border-left: 5px solid #1a5e3a; }
        .welcome h2 { color: #1a5e3a; }
        .welcome p { color: #666; font-size: 14px; margin-top: 5px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; }
        .card { background: white; padding: 25px; border-radius: 8px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); text-decoration: none; color: inherit; border-top: 4px solid #1a5e3a; transition: transform 0.2s; }
        .card:hover { transform: translateY(-3px); }
        .card .icon { font-size: 36px; margin-bottom: 12px; }
        .card h3 { color: #1a5e3a; font-size: 15px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA Ltda.</h1>
    <div>
        <span style="margin-right:20px">👤 ${sessionScope.usuario.nombreUsuario} — Asesor/Cajero</span>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="welcome">
        <h2>Bienvenido, ${sessionScope.usuario.nombreUsuario}</h2>
        <p>Panel de Asesor / Cajero</p>
    </div>
    <div class="grid">
        <a href="${pageContext.request.contextPath}/asociados" class="card">
            <div class="icon">👥</div>
            <h3>Gestionar Asociados</h3>
        </a>
        <a href="${pageContext.request.contextPath}/creditos" class="card">
            <div class="icon">💰</div>
            <h3>Gestionar Créditos</h3>
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
</div>
</body>
</html>
