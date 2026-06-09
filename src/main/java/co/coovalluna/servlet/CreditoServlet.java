package co.coovalluna.servlet;

import co.coovalluna.dao.CreditoDAO;
import co.coovalluna.dao.AsociadoDAO;
import co.coovalluna.model.Credito;
import co.coovalluna.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/creditos")
public class CreditoServlet extends HttpServlet {

    private final CreditoDAO dao = new CreditoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!autorizado(req, resp)) return;

        String accion = req.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "nuevo":
                req.setAttribute("asociados", new AsociadoDAO().listarTodos());
                req.getRequestDispatcher("/jsp/creditos/form.jsp").forward(req, resp);
                break;
            case "ver":
                int radicado = Integer.parseInt(req.getParameter("radicado"));
                req.setAttribute("credito", dao.buscarPorRadicado(radicado));
                req.getRequestDispatcher("/jsp/creditos/detalle.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("creditos", dao.listarTodos());
                req.getRequestDispatcher("/jsp/creditos/lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!autorizado(req, resp)) return;

        String accion = req.getParameter("accion");
        boolean ok = false;

        if ("nuevo".equals(accion)) {
            Credito c = new Credito();
            c.setNumeroRadicado(Integer.parseInt(req.getParameter("numeroRadicado")));
            c.setValorSolicitado(Double.parseDouble(req.getParameter("valorSolicitado")));
            c.setPlazoMeses(Integer.parseInt(req.getParameter("plazoMeses")));
            c.setLineaCredito(req.getParameter("lineaCredito"));
            c.setFechaSolicitud(req.getParameter("fechaSolicitud"));
            c.setFechaAprobacion(req.getParameter("fechaAprobacion"));
            String valorAprobadoStr = req.getParameter("valorAprobado");
            c.setValorAprobado(valorAprobadoStr != null && !valorAprobadoStr.isEmpty() ? Double.parseDouble(valorAprobadoStr) : 0);
            c.setEstado(req.getParameter("estado"));
            c.setCedulaAsociado(req.getParameter("cedulaAsociado"));
            c.setCedulaCodeudor(req.getParameter("cedulaCodeudor"));
            c.setCodigoAgencia(Integer.parseInt(req.getParameter("codigoAgencia")));
            ok = dao.insertar(c);
        } else if ("aprobar".equals(accion)) {
            int radicado = Integer.parseInt(req.getParameter("radicado"));
            String estado = req.getParameter("estado");
            String fechaAprobacion = req.getParameter("fechaAprobacion");
            double valorAprobado = Double.parseDouble(req.getParameter("valorAprobado"));
            ok = dao.actualizarEstado(radicado, estado, fechaAprobacion, valorAprobado);
        }

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/creditos?msg=ok");
        } else {
            req.setAttribute("error", "Error al procesar el crédito");
            req.setAttribute("asociados", new AsociadoDAO().listarTodos());
            req.getRequestDispatcher("/jsp/creditos/form.jsp").forward(req, resp);
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
