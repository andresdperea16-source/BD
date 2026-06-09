<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - ${asociado == null ? 'Nuevo' : 'Editar'} Asociado</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 700px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h2 { color: #1a3c5e; margin-bottom: 25px; font-size: 18px; border-bottom: 2px solid #f0f2f5; padding-bottom: 12px; }
        .grid2 { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
        .form-group { margin-bottom: 18px; }
        .form-group.full { grid-column: 1 / -1; }
        label { display: block; margin-bottom: 6px; color: #333; font-size: 13px; font-weight: bold; }
        input, select { width: 100%; padding: 9px 12px; border: 1px solid #ccc; border-radius: 5px; font-size: 14px; }
        input:focus, select:focus { outline: none; border-color: #1a3c5e; }
        .btn { padding: 10px 22px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; text-decoration: none; display: inline-block; }
        .btn-primary { background: #1a3c5e; color: white; }
        .btn-primary:hover { background: #2a5c8e; }
        .btn-secondary { background: #ccc; color: #333; margin-left: 10px; }
        .error { background: #ffe0e0; color: #c00; padding: 12px; border-radius: 6px; margin-bottom: 18px; font-size: 13px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/asociados">← Volver a Asociados</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="card">
        <h2>${asociado == null ? '➕ Nuevo Asociado' : '✏️ Editar Asociado'}</h2>
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/asociados">
            <input type="hidden" name="accion" value="${asociado == null ? 'nuevo' : 'editar'}">
            <div class="grid2">
                <div class="form-group">
                    <label>Cédula *</label>
                    <input type="text" name="cedula" value="${asociado.cedula}" ${asociado != null ? 'readonly' : ''} required>
                </div>
                <div class="form-group">
                    <label>Tipo de vinculación *</label>
                    <select name="tipoVinculacion" required>
                        <option value="Regular" ${asociado.tipoVinculacion=='Regular'?'selected':''}>Regular</option>
                        <option value="Fundador" ${asociado.tipoVinculacion=='Fundador'?'selected':''}>Fundador</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Nombre *</label>
                    <input type="text" name="nombre" value="${asociado.nombre}" required>
                </div>
                <div class="form-group">
                    <label>Apellido *</label>
                    <input type="text" name="apellido" value="${asociado.apellido}" required>
                </div>
                <div class="form-group">
                    <label>Fecha de nacimiento *</label>
                    <input type="date" name="fechaNacimiento" value="${asociado.fechaNacimiento}" required>
                </div>
                <div class="form-group">
                    <label>Fecha de afiliación *</label>
                    <input type="date" name="fechaAfiliacion" value="${asociado.fechaAfiliacion}" required>
                </div>
                <div class="form-group">
                    <label>Teléfono</label>
                    <input type="text" name="telefono" value="${asociado.telefono}">
                </div>
                <div class="form-group">
                    <label>Municipio *</label>
                    <input type="text" name="municipio" value="${asociado.municipio}" required>
                </div>
                <div class="form-group full">
                    <label>Dirección *</label>
                    <input type="text" name="direccion" value="${asociado.direccion}" required>
                </div>
                <div class="form-group">
                    <label>Correo electrónico</label>
                    <input type="email" name="correo" value="${asociado.correo}">
                </div>
                <div class="form-group">
                    <label>Estado *</label>
                    <select name="estado" required>
                        <option value="Activo" ${asociado.estado=='Activo'?'selected':''}>Activo</option>
                        <option value="Suspendido" ${asociado.estado=='Suspendido'?'selected':''}>Suspendido</option>
                        <option value="Retirado" ${asociado.estado=='Retirado'?'selected':''}>Retirado</option>
                    </select>
                </div>
            </div>
            <div style="margin-top:10px">
                <button type="submit" class="btn btn-primary">💾 Guardar</button>
                <a href="${pageContext.request.contextPath}/asociados" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
