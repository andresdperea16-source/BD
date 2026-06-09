<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>COOVALLUNA - Productividad Asesores</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .navbar { background: #1a3c5e; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { font-size: 18px; }
        .navbar a { color: white; text-decoration: none; font-size: 14px; margin-left: 15px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; margin-bottom: 20px; }
        .filtros { background: white; padding: 18px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap; }
        label { font-size: 13px; color: #555; display: block; margin-bottom: 5px; }
        input, select { padding: 8px; border: 1px solid #ccc; border-radius: 5px; font-size: 13px; }
        .btn { padding: 9px 18px; border-radius: 6px; border: none; cursor: pointer; font-size: 14px; background: #1a3c5e; color: white; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; font-size: 14px; }
        th { background: #1a3c5e; color: white; padding: 12px 15px; text-align: left; }
        td { padding: 11px 15px; border-bottom: 1px solid #eee; }
        tr:hover td { background: #f5f8fb; }
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
    <h2>👨‍💼 Reporte 6: Productividad de Asesores por Agencia</h2>
    <div class="filtros">
        <form method="get" action="${pageContext.request.contextPath}/reportes" style="display:flex;gap:15px;align-items:flex-end;flex-wrap:wrap">
            <input type="hidden" name="tipo" value="6">
            <div>
                <label>Agencia</label>
                <select name="agencia">
                    <option value="">Todas</option>
                    <option value="1" ${param.agencia=='1'?'selected':''}>Tuluá Centro</option>
                    <option value="2" ${param.agencia=='2'?'selected':''}>Riofrío</option>
                    <option value="3" ${param.agencia=='3'?'selected':''}>Trujillo</option>
                </select>
            </div>
            <div>
                <label>Fecha inicio</label>
                <input type="date" name="fechaInicio" value="${param.fechaInicio}">
            </div>
            <div>
                <label>Fecha fin</label>
                <input type="date" name="fechaFin" value="${param.fechaFin}">
            </div>
            <button type="submit" class="btn">Filtrar</button>
        </form>
    </div>
    <div class="card">
        <table>
            <thead>
                <tr><th>Asesor</th><th>Agencia</th><th>Asociados atendidos</th><th>Créditos radicados</th><th>Total aprobado</th><th>Cuentas abiertas</th></tr>
            </thead>
            <tbody>
            <c:forEach var="f" items="${datos}">
                <tr>
                    <td>${f.asesor}</td>
                    <td>${f.agencia}</td>
                    <td>${f.asociadosAtendidos}</td>
                    <td>${f.creditosRadicados}</td>
                    <td>$ ${f.totalAprobado}</td>
                    <td>${f.cuentasAbiertas}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
