package co.coovalluna.servlet;

import co.coovalluna.dao.ReporteDAO;
import co.coovalluna.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/reportes")
public class ReporteServlet extends HttpServlet {

    private final ReporteDAO dao = new ReporteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!autorizado(req, resp)) return;

        String tipo = req.getParameter("tipo");
        if (tipo == null) {
            req.getRequestDispatcher("/jsp/reportes/menu.jsp").forward(req, resp);
            return;
        }

        switch (tipo) {
            case "1":
                String estado = req.getParameter("estado");
                String agencia = req.getParameter("agencia");
                req.setAttribute("datos", dao.asociadosPorEstadoAgencia(estado, agencia));
                req.setAttribute("titulo", "Listado de Asociados por Estado y Agencia");
                req.getRequestDispatcher("/jsp/reportes/reporte1.jsp").forward(req, resp);
                break;
            case "2":
                String cuenta = req.getParameter("cuenta");
                String fechaInicio = req.getParameter("fechaInicio");
                String fechaFin = req.getParameter("fechaFin");
                String tipoMov = req.getParameter("tipoMov");
                String canal = req.getParameter("canal");
                req.setAttribute("datos", dao.extractoCuenta(cuenta, fechaInicio, fechaFin, tipoMov, canal));
                req.setAttribute("cuenta", cuenta);
                req.setAttribute("titulo", "Extracto de Cuenta de Ahorro");
                req.getRequestDispatcher("/jsp/reportes/reporte2.jsp").forward(req, resp);
                break;
            case "3":
                req.setAttribute("datos", dao.carteraPorLineaEstado(
                    req.getParameter("agencia"),
                    req.getParameter("fechaInicio"),
                    req.getParameter("fechaFin")));
                req.setAttribute("titulo", "Estado de Cartera por Línea y Estado");
                req.getRequestDispatcher("/jsp/reportes/reporte3.jsp").forward(req, resp);
                break;
            case "4":
                req.setAttribute("datos", dao.asociadosEnMora());
                req.setAttribute("titulo", "Asociados en Mora");
                req.getRequestDispatcher("/jsp/reportes/reporte4.jsp").forward(req, resp);
                break;
            case "5":
                String radicado = req.getParameter("radicado");
                if (radicado != null && !radicado.isEmpty()) {
                    req.setAttribute("datos", dao.historialPagos(Integer.parseInt(radicado)));
                    req.setAttribute("radicado", radicado);
                }
                req.setAttribute("titulo", "Historial de Pagos de Crédito");
                req.getRequestDispatcher("/jsp/reportes/reporte5.jsp").forward(req, resp);
                break;
            case "6":
                req.setAttribute("datos", dao.productividadAsesores(
                    req.getParameter("agencia"),
                    req.getParameter("fechaInicio"),
                    req.getParameter("fechaFin")));
                req.setAttribute("titulo", "Productividad de Asesores por Agencia");
                req.getRequestDispatcher("/jsp/reportes/reporte6.jsp").forward(req, resp);
                break;
            case "7":
                req.setAttribute("datos", dao.codeudoriasActivas());
                req.setAttribute("titulo", "Asociados con Codeudoría Activa");
                req.getRequestDispatcher("/jsp/reportes/reporte7.jsp").forward(req, resp);
                break;
            default:
                req.getRequestDispatcher("/jsp/reportes/menu.jsp").forward(req, resp);
        }
    }

    private boolean autorizado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
