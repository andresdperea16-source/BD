<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Reportes</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 25px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border-left: 5px solid #1a3c5e; text-decoration: none; color: inherit; display: block; transition: transform 0.2s; }
        .card:hover { transform: translateY(-3px); box-shadow: 0 6px 16px rgba(0,0,0,0.12); }
        .card .num { font-size: 28px; font-weight: bold; color: #1a3c5e; margin-bottom: 8px; }
        .card h3 { font-size: 15px; color: #333; margin-bottom: 6px; }
        .card p { font-size: 13px; color: #888; }
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
    <h2>📊 Reportes del Sistema</h2>
    <div class="grid">
        <a href="${pageContext.request.contextPath}/reportes?tipo=1" class="card">
            <div class="num">01</div>
            <h3>Asociados por estado y agencia</h3>
            <p>Listado filtrable con número de productos activos</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=2" class="card">
            <div class="num">02</div>
            <h3>Extracto de cuenta de ahorro</h3>
            <p>Movimientos con saldo calculado dinámicamente</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=3" class="card">
            <div class="num">03</div>
            <h3>Cartera por línea y estado</h3>
            <p>Agrupado con totales y porcentajes</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=4" class="card">
            <div class="num">04</div>
            <h3>Asociados en mora</h3>
            <p>Cuotas vencidas con días de mora</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=5" class="card">
            <div class="num">05</div>
            <h3>Historial de pagos</h3>
            <p>Plan de pagos completo de un crédito</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=6" class="card">
            <div class="num">06</div>
            <h3>Productividad de asesores</h3>
            <p>Indicadores por asesor y agencia</p>
        </a>
        <a href="${pageContext.request.contextPath}/reportes?tipo=7" class="card">
            <div class="num">07</div>
            <h3>Codeudorías activas</h3>
            <p>Créditos con codeudor registrado</p>
        </a>
    </div>
</div>
</body>
</html>
