<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Reporte 1</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 20px; }
        .filtros { background: white; padding: 18px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap; }
        .filtros label { font-size: 13px; color: #555; display: block; margin-bottom: 5px; }
        .filtros select { padding: 8px; border: 1px solid #ccc; border-radius: 5px; font-size: 13px; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; background: #1a3c5e; color: white; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-Activo { background: #d4edda; color: #155724; }
        .badge-Suspendido { background: #fff3cd; color: #856404; }
        .badge-Retirado { background: #f8d7da; color: #721c24; }
        .total { padding: 12px 15px; font-weight: bold; color: #1a3c5e; font-size: 14px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/reportes">← Reportes</a>
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <h2>📋 Reporte 1: Listado de Asociados por Estado y Agencia</h2>
    <div class="filtros">
        <form method="get" action="${pageContext.request.contextPath}/reportes" style="display:flex;gap:15px;align-items:flex-end;flex-wrap:wrap">
            <input type="hidden" name="tipo" value="1">
            <div>
                <label>Estado</label>
                <select name="estado">
                    <option value="">Todos</option>
                    <option value="Activo" ${param.estado=='Activo'?'selected':''}>Activo</option>
                    <option value="Suspendido" ${param.estado=='Suspendido'?'selected':''}>Suspendido</option>
                    <option value="Retirado" ${param.estado=='Retirado'?'selected':''}>Retirado</option>
                </select>
            </div>
            <div>
                <label>Agencia</label>
                <select name="agencia">
                    <option value="">Todas</option>
                    <option value="1" ${param.agencia=='1'?'selected':''}>Tuluá Centro</option>
                    <option value="2" ${param.agencia=='2'?'selected':''}>Riofrío</option>
                    <option value="3" ${param.agencia=='3'?'selected':''}>Trujillo</option>
                </select>
            </div>
            <button type="submit" class="btn">Filtrar</button>
        </form>
    </div>
    <div class="card">
        <table>
            <thead>
                <tr><th>Cédula</th><th>Nombre</th><th>Tipo</th><th>Fecha afiliación</th><th>Estado</th><th>Cuentas</th><th>Créditos</th></tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${datos}">
                <tr>
                    <td>${f.cedula}</td>
                    <td>${f.nombre}</td>
                    <td>${f.tipoVinculacion}</td>
                    <td>${f.fechaAfiliacion}</td>
                    <td><span class="badge badge-${f.estado}">${f.estado}</span></td>
                    <td>${f.numCuentas}</td>
                    <td>${f.numCreditos}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="total">Total registros: ${datos.size()}</div>
    </div>
</div>
</body>
</html>
