<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Historial de Pagos</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 20px; }
        .filtros { background: white; padding: 18px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 15px; align-items: flex-end; }
        label { font-size: 13px; color: #555; display: block; margin-bottom: 5px; }
        input { padding: 8px; border: 1px solid #ccc; border-radius: 5px; font-size: 13px; width: 200px; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; background: #1a3c5e; color: white; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
        .badge { padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold; }
        .badge-tiempo { background: #d4edda; color: #155724; }
        .badge-mora { background: #f8d7da; color: #721c24; }
        .badge-pendiente { background: #fff3cd; color: #856404; }
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
    <h2>🗓️ Reporte 5: Historial de Pagos de Crédito</h2>
    <div class="filtros">
        <form method="get" action="${pageContext.request.contextPath}/reportes" style="display:flex;gap:15px;align-items:flex-end">
            <input type="hidden" name="tipo" value="5">
            <div>
                <label>Número de radicado</label>
                <input type="number" name="radicado" value="${param.radicado}" placeholder="Ej: 1001" required>
            </div>
            <button type="submit" class="btn">Consultar</button>
        </form>
    </div>
    <c:if test="${datos != null}">
        <div class="card">
            <table>
                <thead>
                    <tr><th>N° Cuota</th><th>Fecha vencimiento</th><th>Fecha pago</th><th>Valor pagado</th><th>Estado</th></tr>
                </thead>
                <tbody>
                <c:forEach var="f" items="${datos}">
                    <tr>
                        <td>${f.numeroCuota}</td>
                        <td>${f.fechaVencimiento}</td>
                        <td>${f.fechaRealPago != null ? f.fechaRealPago : '—'}</td>
                        <td>${f.valorPagado > 0 ? '$ '.concat(f.valorPagado.toString()) : '—'}</td>
                        <td>
                            <c:choose>
                                <c:when test="${f.estadoPago == 'A tiempo'}"><span class="badge badge-tiempo">A tiempo</span></c:when>
                                <c:when test="${f.estadoPago == 'Pagado con mora'}"><span class="badge badge-mora">Pagado con mora</span></c:when>
                                <c:otherwise><span class="badge badge-pendiente">Pendiente</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
</body>
</html>
