package co.coovalluna.servlet;

import co.coovalluna.dao.UsuarioDAO;
import co.coovalluna.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String nombreUsuario = req.getParameter("nombreUsuario");
        String contrasena = req.getParameter("contrasena");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(nombreUsuario, contrasena);

        if (usuario != null) {
            HttpSession session = req.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("rol", usuario.getRol());

            switch (usuario.getRol()) {
                case "Administrador":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    break;
                case "Asesor/Cajero":
                    resp.sendRedirect(req.getContextPath() + "/asesor/dashboard");
                    break;
                case "Asociado":
                    resp.sendRedirect(req.getContextPath() + "/asociado/dashboard");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/login");
            }
        } else {
            req.setAttribute("error", "Usuario o contraseña incorrectos");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
        }
    }
}
