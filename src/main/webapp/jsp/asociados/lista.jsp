<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Asociados</title>
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
        .filtros { background: white; padding: 18px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 15px; align-items: flex-end; }
        .filtros label { font-size: 13px; color: #555; display: block; margin-bottom: 5px; }
        .filtros select, .filtros input { padding: 8px; border: 1px solid #ccc; border-radius: 5px; font-size: 13px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-Activo { background: #d4edda; color: #155724; }
        .badge-Suspendido { background: #fff3cd; color: #856404; }
        .badge-Retirado { background: #f8d7da; color: #721c24; }
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
        <h2>👥 Gestión de Asociados</h2>
        <a href="${pageContext.request.contextPath}/asociados?accion=nuevo" class="btn btn-primary">+ Nuevo Asociado</a>
    </div>

    <c:if test="${param.msg == 'ok'}">
        <div class="success">✅ Operación realizada exitosamente.</div>
    </c:if>

    <div class="filtros">
        <form method="get" action="${pageContext.request.contextPath}/asociados" style="display:flex;gap:15px;align-items:flex-end;flex-wrap:wrap">
            <div>
                <label>Estado</label>
                <select name="estado">
                    <option value="">Todos</option>
                    <option value="Activo" ${estadoFiltro=='Activo'?'selected':''}>Activo</option>
                    <option value="Suspendido" ${estadoFiltro=='Suspendido'?'selected':''}>Suspendido</option>
                    <option value="Retirado" ${estadoFiltro=='Retirado'?'selected':''}>Retirado</option>
                </select>
            </div>
            <div>
                <label>Agencia</label>
                <select name="agencia">
                    <option value="">Todas</option>
                    <option value="1" ${agenciaFiltro=='1'?'selected':''}>Tuluá Centro</option>
                    <option value="2" ${agenciaFiltro=='2'?'selected':''}>Riofrío</option>
                    <option value="3" ${agenciaFiltro=='3'?'selected':''}>Trujillo</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Filtrar</button>
        </form>
    </div>

    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>Cédula</th><th>Nombre</th><th>Municipio</th>
                    <th>Tipo</th><th>Fecha afiliación</th><th>Estado</th><th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${asociados}">
                <tr>
                    <td>${a.cedula}</td>
                    <td>${a.nombre} ${a.apellido}</td>
                    <td>${a.municipio}</td>
                    <td>${a.tipoVinculacion}</td>
                    <td>${a.fechaAfiliacion}</td>
                    <td><span class="badge badge-${a.estado}">${a.estado}</span></td>
                    <td><a href="${pageContext.request.contextPath}/asociados?accion=editar&cedula=${a.cedula}">✏️ Editar</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
