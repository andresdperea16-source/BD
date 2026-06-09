<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>COOVALLUNA - Iniciar Sesión</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #1a3c5e; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .card { background: white; padding: 40px; border-radius: 10px; width: 380px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo h1 { color: #1a3c5e; font-size: 26px; }
        .logo p { color: #666; font-size: 13px; margin-top: 5px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #333; font-size: 14px; font-weight: bold; }
        input { width: 100%; padding: 10px 14px; border: 1px solid #ccc; border-radius: 6px; font-size: 14px; }
        input:focus { outline: none; border-color: #1a3c5e; }
        button { width: 100%; padding: 12px; background: #1a3c5e; color: white; border: none; border-radius: 6px; font-size: 15px; cursor: pointer; font-weight: bold; }
        button:hover { background: #2a5c8e; }
        .error { background: #ffe0e0; color: #c00; padding: 10px; border-radius: 6px; margin-bottom: 16px; font-size: 13px; text-align: center; }
    </style>
</head>
<body>
<div class="card">
    <div class="logo">
        <h1>COOVALLUNA</h1>
        <p>Cooperativa de Ahorro y Crédito Ltda.</p>
    </div>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error">${error}</div>
    <% } %>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
            <label>Usuario</label>
            <input type="text" name="nombreUsuario" placeholder="Ingrese su usuario" required autofocus>
        </div>
        <div class="form-group">
            <label>Contraseña</label>
            <input type="password" name="contrasena" placeholder="Ingrese su contraseña" required>
        </div>
        <button type="submit">Ingresar</button>
    </form>
</div>
</body>
</html>
