package co.coovalluna.servlet;

import co.coovalluna.dao.AsociadoDAO;
import co.coovalluna.model.Asociado;
import co.coovalluna.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/asociados")
public class AsociadoServlet extends HttpServlet {

    private final AsociadoDAO dao = new AsociadoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!autorizado(req, resp)) return;

        String accion = req.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "nuevo":
                req.getRequestDispatcher("/jsp/asociados/form.jsp").forward(req, resp);
                break;
            case "editar":
                String cedula = req.getParameter("cedula");
                req.setAttribute("asociado", dao.buscarPorCedula(cedula));
                req.getRequestDispatcher("/jsp/asociados/form.jsp").forward(req, resp);
                break;
            default:
                String estado = req.getParameter("estado");
                String agencia = req.getParameter("agencia");
                req.setAttribute("asociados", dao.listarPorFiltros(estado, agencia));
                req.setAttribute("estadoFiltro", estado);
                req.setAttribute("agenciaFiltro", agencia);
                req.getRequestDispatcher("/jsp/asociados/lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!autorizado(req, resp)) return;

        String accion = req.getParameter("accion");
        Asociado a = new Asociado();
        a.setCedula(req.getParameter("cedula"));
        a.setNombre(req.getParameter("nombre"));
        a.setApellido(req.getParameter("apellido"));
        a.setFechaNacimiento(req.getParameter("fechaNacimiento"));
        a.setDireccion(req.getParameter("direccion"));
        a.setMunicipio(req.getParameter("municipio"));
        a.setTelefono(req.getParameter("telefono"));
        a.setCorreo(req.getParameter("correo"));
        a.setFechaAfiliacion(req.getParameter("fechaAfiliacion"));
        a.setTipoVinculacion(req.getParameter("tipoVinculacion"));
        a.setEstado(req.getParameter("estado"));

        boolean ok;
        if ("editar".equals(accion)) {
            ok = dao.actualizar(a);
        } else {
            ok = dao.insertar(a);
        }

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/asociados?msg=ok");
        } else {
            req.setAttribute("error", "Error al guardar el asociado");
            req.setAttribute("asociado", a);
            req.getRequestDispatcher("/jsp/asociados/form.jsp").forward(req, resp);
        }
    }

    private boolean autorizado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        Usuario u = (Usuario) session.getAttribute("usuario");
        if (u.getRol().equals("Asociado")) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
