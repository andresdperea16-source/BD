<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Extracto de Cuenta</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 20px; }
        .filtros { background: white; padding: 18px; border-radius: 8px; margin-bottom: 20px; }
        .filtros-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 15px; align-items: flex-end; }
        label { font-size: 13px; color: #555; display: block; margin-bottom: 5px; }
        input, select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 5px; font-size: 13px; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; background: #1a3c5e; color: white; width: 100%; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .deposito { color: #155724; font-weight: bold; }
        .retiro { color: #721c24; font-weight: bold; }
        .saldo-box { background: #1a3c5e; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; font-size: 16px; font-weight: bold; }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🏦 COOVALLUNA</h1>
    <div>
        <a href="${pageContext.request.contextPath}/reportes">← Reportes</a>
        <a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
    </div>
</div>
<div class="container">
    <h2>📄 Reporte 2: Extracto de Cuenta de Ahorro</h2>
    <div class="filtros">
        <form method="get" action="${pageContext.request.contextPath}/reportes">
            <input type="hidden" name="tipo" value="2">
            <div class="filtros-grid">
                <div>
                    <label>Número de cuenta *</label>
                    <input type="text" name="cuenta" value="${param.cuenta}" placeholder="CA-001" required>
                </div>
                <div>
                    <label>Fecha inicio</label>
                    <input type="date" name="fechaInicio" value="${param.fechaInicio}">
                </div>
                <div>
                    <label>Fecha fin</label>
                    <input type="date" name="fechaFin" value="${param.fechaFin}">
                </div>
                <div>
                    <label>Tipo movimiento</label>
                    <select name="tipoMov">
                        <option value="">Todos</option>
                        <option value="Depósito" ${param.tipoMov=='Depósito'?'selected':''}>Depósito</option>
                        <option value="Retiro" ${param.tipoMov=='Retiro'?'selected':''}>Retiro</option>
                        <option value="Transferencia entrante" ${param.tipoMov=='Transferencia entrante'?'selected':''}>Transferencia entrante</option>
                        <option value="Transferencia saliente" ${param.tipoMov=='Transferencia saliente'?'selected':''}>Transferencia saliente</option>
                    </select>
                </div>
                <div>
                    <label>Canal</label>
                    <select name="canal">
                        <option value="">Todos</option>
                        <option value="Presencial" ${param.canal=='Presencial'?'selected':''}>Presencial</option>
                        <option value="Aplicación móvil" ${param.canal=='Aplicación móvil'?'selected':''}>Aplicación móvil</option>
                        <option value="Cajero automático" ${param.canal=='Cajero automático'?'selected':''}>Cajero automático</option>
                    </select>
                </div>
                <div style="align-self:flex-end">
                    <button type="submit" class="btn">Consultar</button>
                </div>
            </div>
        </form>
    </div>

    <c:if test="${datos != null}">
        <div class="card">
            <table>
                <thead>
                    <tr><th>Transacción</th><th>Fecha y hora</th><th>Tipo</th><th>Canal</th><th>Valor</th></tr>
                </thead>
                <tbody>
                <c:set var="saldo" value="0"/>
                <c:forEach var="f" items="${datos}">
                    <c:choose>
                        <c:when test="${f.tipo == 'Depósito' || f.tipo == 'Transferencia entrante'}">
                            <c:set var="saldo" value="${saldo + f.valor}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="saldo" value="${saldo - f.valor}"/>
                        </c:otherwise>
                    </c:choose>
                    <tr>
                        <td>${f.transaccion}</td>
                        <td>${f.fechaHora}</td>
                        <td class="${f.tipo == 'Depósito' || f.tipo == 'Transferencia entrante' ? 'deposito' : 'retiro'}">${f.tipo}</td>
                        <td>${f.canal}</td>
                        <td class="${f.tipo == 'Depósito' || f.tipo == 'Transferencia entrante' ? 'deposito' : 'retiro'}">
                            ${f.tipo == 'Depósito' || f.tipo == 'Transferencia entrante' ? '+' : '-'} $ ${f.valor}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="saldo-box">
                <span>Saldo actual cuenta ${cuenta}</span>
                <span>$ <c:out value="${saldo}"/></span>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
