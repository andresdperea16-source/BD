package co.coovalluna.dao;

import co.coovalluna.db.Conexion;
import co.coovalluna.model.Credito;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CreditoDAO {

    public List<Credito> listarTodos() {
        List<Credito> lista = new ArrayList<>();
        String sql = "SELECT * FROM CREDITO ORDER BY fecha_solicitud DESC";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Credito buscarPorRadicado(int radicado) {
        String sql = "SELECT * FROM CREDITO WHERE numero_radicado = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, radicado);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertar(Credito c) {
        String sql = "INSERT INTO CREDITO VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getNumeroRadicado());
            ps.setDouble(2, c.getValorSolicitado());
            ps.setInt(3, c.getPlazoMeses());
            ps.setString(4, c.getLineaCredito());
            ps.setDate(5, java.sql.Date.valueOf(c.getFechaSolicitud()));
            ps.setObject(6, c.getFechaAprobacion() != null && !c.getFechaAprobacion().isEmpty() ? java.sql.Date.valueOf(c.getFechaAprobacion()) : null);
            ps.setObject(7, c.getValorAprobado() > 0 ? c.getValorAprobado() : null);
            ps.setString(8, c.getEstado());
            ps.setString(9, c.getCedulaAsociado());
            ps.setObject(10, c.getCedulaCodeudor() != null && !c.getCedulaCodeudor().isEmpty() ? c.getCedulaCodeudor() : null);
            ps.setInt(11, c.getCodigoAgencia());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean actualizarEstado(int radicado, String estado, String fechaAprobacion, double valorAprobado) {
        String sql = "UPDATE CREDITO SET estado=?, fecha_aprobacion=?, valor_aprobado=? WHERE numero_radicado=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setObject(2, fechaAprobacion != null && !fechaAprobacion.isEmpty() ? java.sql.Date.valueOf(fechaAprobacion) : null);
            ps.setObject(3, valorAprobado > 0 ? valorAprobado : null);
            ps.setInt(4, radicado);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Credito mapear(ResultSet rs) throws SQLException {
        Credito c = new Credito();
        c.setNumeroRadicado(rs.getInt("numero_radicado"));
        c.setValorSolicitado(rs.getDouble("valor_solicitado"));
        c.setPlazoMeses(rs.getInt("plazo_meses"));
        c.setLineaCredito(rs.getString("linea_credito"));
        c.setFechaSolicitud(rs.getString("fecha_solicitud"));
        c.setFechaAprobacion(rs.getString("fecha_aprobacion"));
        c.setValorAprobado(rs.getDouble("valor_aprobado"));
        c.setEstado(rs.getString("estado"));
        c.setCedulaAsociado(rs.getString("cedula_asociado"));
        c.setCedulaCodeudor(rs.getString("cedula_codeudor"));
        c.setCodigoAgencia(rs.getInt("codigo_agencia"));
        return c;
    }
}
