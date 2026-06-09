package co.coovalluna.servlet;

import co.coovalluna.dao.AsociadoDAO;
import co.coovalluna.dao.CuentaAhorroDAO;
import co.coovalluna.dao.CreditoDAO;
import co.coovalluna.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/asociado/dashboard")
public class AsociadoDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Usuario u = (Usuario) session.getAttribute("usuario");
        if (!u.getRol().equals("Asociado")) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String cedula = u.getCedulaAsociado();
        req.setAttribute("asociado", new AsociadoDAO().buscarPorCedula(cedula));
        req.setAttribute("cuentas", new CuentaAhorroDAO().listarPorAsociado(cedula));
        req.setAttribute("creditos", new CreditoDAO().listarTodos());
        req.getRequestDispatcher("/jsp/asociado/dashboard.jsp").forward(req, resp);
    }
}
