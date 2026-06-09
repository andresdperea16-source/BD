<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Nuevo Crédito</title>
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
        .btn-secondary { background: #ccc; color: #333; margin-left: 10px; }
        .error { background: #ffe0e0; color: #c00; padding: 12px; border-radius: 6px; margin-bottom: 18px; font-size: 13px; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/creditos">← Volver a Créditos</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <div class="card">
        <h2>➕ Nuevo Crédito</h2>
        <c:if test="${error != null}"><div class="error">${error}</div></c:if>
        <form method="post" action="${pageContext.request.contextPath}/creditos">
            <input type="hidden" name="accion" value="nuevo">
            <div class="grid2">
                <div class="form-group">
                    <label>Número de radicado *</label>
                    <input type="number" name="numeroRadicado" required>
                </div>
                <div class="form-group">
                    <label>Línea de crédito *</label>
                    <select name="lineaCredito" required>
                        <option value="">Seleccione...</option>
                        <option value="Libre inversión">Libre inversión</option>
                        <option value="Vivienda">Vivienda</option>
                        <option value="Agropecuario">Agropecuario</option>
                        <option value="Educativo">Educativo</option>
                        <option value="Empresarial">Empresarial</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Valor solicitado *</label>
                    <input type="number" name="valorSolicitado" step="0.01" required>
                </div>
                <div class="form-group">
                    <label>Plazo (meses) *</label>
                    <input type="number" name="plazoMeses" required>
                </div>
                <div class="form-group">
                    <label>Fecha solicitud *</label>
                    <input type="date" name="fechaSolicitud" required>
                </div>
                <div class="form-group">
                    <label>Fecha aprobación</label>
                    <input type="date" name="fechaAprobacion">
                </div>
                <div class="form-group">
                    <label>Valor aprobado</label>
                    <input type="number" name="valorAprobado" step="0.01">
                </div>
                <div class="form-group">
                    <label>Estado *</label>
                    <select name="estado" required>
                        <option value="En estudio">En estudio</option>
                        <option value="Aprobado">Aprobado</option>
                        <option value="Rechazado">Rechazado</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Asociado titular *</label>
                    <select name="cedulaAsociado" required>
                        <option value="">Seleccione...</option>
                        <c:forEach var="a" items="${asociados}">
                            <option value="${a.cedula}">${a.nombre} ${a.apellido} - ${a.cedula}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Codeudor (opcional)</label>
                    <select name="cedulaCodeudor">
                        <option value="">Sin codeudor</option>
                        <c:forEach var="a" items="${asociados}">
                            <option value="${a.cedula}">${a.nombre} ${a.apellido} - ${a.cedula}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Agencia *</label>
                    <select name="codigoAgencia" required>
                        <option value="1">Tuluá Centro</option>
                        <option value="2">Riofrío</option>
                        <option value="3">Trujillo</option>
                    </select>
                </div>
            </div>
            <div style="margin-top:10px">
                <button type="submit" class="btn btn-primary">💾 Guardar</button>
                <a href="${pageContext.request.contextPath}/creditos" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
