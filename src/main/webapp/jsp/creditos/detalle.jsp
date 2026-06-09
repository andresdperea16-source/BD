<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Detalle Crédito</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .card h2 { color: #1a3c5e; margin-bottom: 20px; font-size: 18px; border-bottom: 2px solid #f0f2f5; padding-bottom: 12px; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .info-item label { font-size: 12px; color: #999; display: block; }
        .info-item span { font-size: 14px; color: #333; font-weight: bold; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primary { background: #1a3c5e; color: white; }
        .btn-success { background: #28a745; color: white; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/creditos">← Volver</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="card">
        <h2>💰 Detalle del Crédito #${credito.numeroRadicado}</h2>
        <div class="info-grid">
            <div class="info-item"><label>Línea de crédito</label><span>${credito.lineaCredito}</span></div>
            <div class="info-item"><label>Estado</label><span>${credito.estado}</span></div>
            <div class="info-item"><label>Valor solicitado</label><span>$ ${credito.valorSolicitado}</span></div>
            <div class="info-item"><label>Valor aprobado</label><span>$ ${credito.valorAprobado}</span></div>
            <div class="info-item"><label>Plazo</label><span>${credito.plazoMeses} meses</span></div>
            <div class="info-item"><label>Fecha solicitud</label><span>${credito.fechaSolicitud}</span></div>
            <div class="info-item"><label>Fecha aprobación</label><span>${credito.fechaAprobacion}</span></div>
            <div class="info-item"><label>Asociado</label><span>${credito.cedulaAsociado}</span></div>
            <div class="info-item"><label>Codeudor</label><span>${credito.cedulaCodeudor != null ? credito.cedulaCodeudor : 'Sin codeudor'}</span></div>
        </div>
        <div style="margin-top:20px">
            <a href="${pageContext.request.contextPath}/reportes?tipo=5&radicado=${credito.numeroRadicado}" class="btn btn-primary">📋 Ver plan de pagos</a>
        </div>
    </div>
</div>
</body>
</html>
