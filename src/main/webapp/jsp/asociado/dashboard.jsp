<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Mi Cuenta</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #5e3a1a; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 20px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; padding: 25px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h2 { color: #5e3a1a; margin-bottom: 15px; font-size: 17px; border-bottom: 2px solid #f0f2f5; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #5e3a1a; color: white; padding: 10px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #faf5f0; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .info-item label { font-size: 12px; color: #999; display: block; }
        .info-item span { font-size: 14px; color: #333; font-weight: bold; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-activo { background: #d4edda; color: #155724; }
        .badge-pendiente { background: #fff3cd; color: #856404; }
        .badge-mora { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA Ltda.</h1>
    <div>
        <span style="margin-right:20px">👤 ${sessionScope.usuario.nombreUsuario}</span>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="card">
        <h2>👤 Mi Información</h2>
        <div class="info-grid">
            <div class="info-item"><label>Nombre completo</label><span>${asociado.nombre} ${asociado.apellido}</span></div>
            <div class="info-item"><label>Cédula</label><span>${asociado.cedula}</span></div>
            <div class="info-item"><label>Municipio</label><span>${asociado.municipio}</span></div>
            <div class="info-item"><label>Teléfono</label><span>${asociado.telefono}</span></div>
            <div class="info-item"><label>Correo</label><span>${asociado.correo}</span></div>
            <div class="info-item"><label>Fecha afiliación</label><span>${asociado.fechaAfiliacion}</span></div>
            <div class="info-item"><label>Tipo vinculación</label><span>${asociado.tipoVinculacion}</span></div>
            <div class="info-item"><label>Estado</label><span>${asociado.estado}</span></div>
        </div>
    </div>

    <div class="card">
        <h2>🏧 Mis Cuentas de Ahorro</h2>
        <table>
            <thead><tr><th>Número cuenta</th><th>Fecha apertura</th><th>Estado</th><th>Saldo</th><th>Extracto</th></tr></thead>
            <tbody>
            <c:forEach var="c" items="${cuentas}">
                <tr>
                    <td>${c.numeroCuenta}</td>
                    <td>${c.fechaApertura}</td>
                    <td><span class="badge badge-activo">${c.estado}</span></td>
                    <td>$ <c:out value="${c.saldo}"/></td>
                    <td><a href="${pageContext.request.contextPath}/reportes?tipo=2&cuenta=${c.numeroCuenta}">Ver extracto</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h2>💰 Mis Créditos</h2>
        <table>
            <thead><tr><th>Radicado</th><th>Línea</th><th>Valor aprobado</th><th>Plazo</th><th>Estado</th><th>Cuotas</th></tr></thead>
            <tbody>
            <c:forEach var="cr" items="${creditos}">
                <c:if test="${cr.cedulaAsociado == sessionScope.usuario.cedulaAsociado}">
                <tr>
                    <td>${cr.numeroRadicado}</td>
                    <td>${cr.lineaCredito}</td>
                    <td>$ ${cr.valorAprobado}</td>
                    <td>${cr.plazoMeses} meses</td>
                    <td><span class="badge badge-activo">${cr.estado}</span></td>
                    <td><a href="${pageContext.request.contextPath}/reportes?tipo=5&radicado=${cr.numeroRadicado}">Ver cuotas</a></td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
