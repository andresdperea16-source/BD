package co.coovalluna.dao;

import co.coovalluna.db.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ReporteDAO {

    public List<Map<String, Object>> asociadosPorEstadoAgencia(String estado, String agencia) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT a.cedula, a.nombre, a.apellido, a.tipo_vinculacion, a.fecha_afiliacion, a.estado, " +
                     "COUNT(DISTINCT ca.numero_cuenta) AS num_cuentas, " +
                     "COUNT(DISTINCT c.numero_radicado) AS num_creditos " +
                     "FROM ASOCIADO a " +
                     "LEFT JOIN CUENTA_AHORRO ca ON a.cedula = ca.cedula_asociado " +
                     "LEFT JOIN CREDITO c ON a.cedula = c.cedula_asociado " +
                     "WHERE 1=1 ";
        if (estado != null && !estado.isEmpty()) sql += "AND a.estado = ? ";
        if (agencia != null && !agencia.isEmpty()) sql += "AND ca.codigo_agencia = ? ";
        sql += "GROUP BY a.cedula ORDER BY a.apellido";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (estado != null && !estado.isEmpty()) ps.setString(i++, estado);
            if (agencia != null && !agencia.isEmpty()) ps.setInt(i++, Integer.parseInt(agencia));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("cedula", rs.getString("cedula"));
                fila.put("nombre", rs.getString("nombre") + " " + rs.getString("apellido"));
                fila.put("tipoVinculacion", rs.getString("tipo_vinculacion"));
                fila.put("fechaAfiliacion", rs.getString("fecha_afiliacion"));
                fila.put("estado", rs.getString("estado"));
                fila.put("numCuentas", rs.getInt("num_cuentas"));
                fila.put("numCreditos", rs.getInt("num_creditos"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> extractoCuenta(String numeroCuenta, String fechaInicio, String fechaFin, String tipo, String canal) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT numero_transaccion, fecha_hora, tipo, valor, canal " +
                     "FROM MOVIMIENTO WHERE numero_cuenta = ? ";
        if (fechaInicio != null && !fechaInicio.isEmpty()) sql += "AND DATE(fecha_hora) >= ? ";
        if (fechaFin != null && !fechaFin.isEmpty()) sql += "AND DATE(fecha_hora) <= ? ";
        if (tipo != null && !tipo.isEmpty()) sql += "AND tipo = ? ";
        if (canal != null && !canal.isEmpty()) sql += "AND canal = ? ";
        sql += "ORDER BY fecha_hora";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            ps.setString(i++, numeroCuenta);
            if (fechaInicio != null && !fechaInicio.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaInicio));
            if (fechaFin != null && !fechaFin.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaFin));
            if (tipo != null && !tipo.isEmpty()) ps.setString(i++, tipo);
            if (canal != null && !canal.isEmpty()) ps.setString(i++, canal);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("transaccion", rs.getLong("numero_transaccion"));
                fila.put("fechaHora", rs.getString("fecha_hora"));
                fila.put("tipo", rs.getString("tipo"));
                fila.put("valor", rs.getDouble("valor"));
                fila.put("canal", rs.getString("canal"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> carteraPorLineaEstado(String agencia, String fechaInicio, String fechaFin) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT linea_credito, estado, COUNT(*) AS num_creditos, " +
                     "SUM(valor_aprobado) AS total_aprobado, " +
                     "ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS porcentaje " +
                     "FROM CREDITO WHERE 1=1 ";
        if (agencia != null && !agencia.isEmpty()) sql += "AND codigo_agencia = ? ";
        if (fechaInicio != null && !fechaInicio.isEmpty()) sql += "AND fecha_aprobacion >= ? ";
        if (fechaFin != null && !fechaFin.isEmpty()) sql += "AND fecha_aprobacion <= ? ";
        sql += "GROUP BY linea_credito, estado ORDER BY linea_credito";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (agencia != null && !agencia.isEmpty()) ps.setInt(i++, Integer.parseInt(agencia));
            if (fechaInicio != null && !fechaInicio.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaInicio));
            if (fechaFin != null && !fechaFin.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaFin));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("lineaCredito", rs.getString("linea_credito"));
                fila.put("estado", rs.getString("estado"));
                fila.put("numCreditos", rs.getInt("num_creditos"));
                fila.put("totalAprobado", rs.getDouble("total_aprobado"));
                fila.put("porcentaje", rs.getDouble("porcentaje"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> asociadosEnMora() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT a.nombre || ' ' || a.apellido AS asociado, " +
                     "c.numero_radicado, cu.numero_cuota, cu.fecha_vencimiento, " +
                     "CURRENT_DATE - cu.fecha_vencimiento AS dias_mora, " +
                     "e.nombre || ' ' || e.apellido AS asesor " +
                     "FROM CUOTA cu " +
                     "JOIN CREDITO c ON cu.numero_radicado = c.numero_radicado " +
                     "JOIN ASOCIADO a ON c.cedula_asociado = a.cedula " +
                     "JOIN EMPLEADO e ON c.codigo_agencia = e.codigo_agencia " +
                     "WHERE cu.estado_pago = 'Pendiente' " +
                     "AND cu.fecha_vencimiento < CURRENT_DATE " +
                     "ORDER BY dias_mora DESC";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("asociado", rs.getString("asociado"));
                fila.put("numeroRadicado", rs.getInt("numero_radicado"));
                fila.put("numeroCuota", rs.getInt("numero_cuota"));
                fila.put("fechaVencimiento", rs.getString("fecha_vencimiento"));
                fila.put("diasMora", rs.getInt("dias_mora"));
                fila.put("asesor", rs.getString("asesor"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> historialPagos(int numeroRadicado) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT numero_cuota, fecha_vencimiento, fecha_real_pago, " +
                     "valor_pagado, estado_pago " +
                     "FROM CUOTA WHERE numero_radicado = ? " +
                     "ORDER BY numero_cuota";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, numeroRadicado);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("numeroCuota", rs.getInt("numero_cuota"));
                fila.put("fechaVencimiento", rs.getString("fecha_vencimiento"));
                fila.put("fechaRealPago", rs.getString("fecha_real_pago"));
                fila.put("valorPagado", rs.getDouble("valor_pagado"));
                fila.put("estadoPago", rs.getString("estado_pago"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> productividadAsesores(String agencia, String fechaInicio, String fechaFin) {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT e.cedula, e.nombre || ' ' || e.apellido AS asesor, ag.nombre AS agencia, " +
                     "COUNT(DISTINCT c.cedula_asociado) AS asociados_atendidos, " +
                     "COUNT(DISTINCT cr.numero_radicado) AS creditos_radicados, " +
                     "COALESCE(SUM(cr.valor_aprobado), 0) AS total_aprobado, " +
                     "COUNT(DISTINCT ca.numero_cuenta) AS cuentas_abiertas " +
                     "FROM EMPLEADO e " +
                     "JOIN AGENCIA ag ON e.codigo_agencia = ag.codigo_agencia " +
                     "LEFT JOIN CREDITO cr ON e.codigo_agencia = cr.codigo_agencia " +
                     "LEFT JOIN ASOCIADO c ON cr.cedula_asociado = c.cedula " +
                     "LEFT JOIN CUENTA_AHORRO ca ON e.codigo_agencia = ca.codigo_agencia " +
                     "WHERE e.cargo LIKE '%Asesor%' OR e.cargo LIKE '%Cajero%' ";
        if (agencia != null && !agencia.isEmpty()) sql += "AND e.codigo_agencia = ? ";
        if (fechaInicio != null && !fechaInicio.isEmpty()) sql += "AND cr.fecha_solicitud >= ? ";
        if (fechaFin != null && !fechaFin.isEmpty()) sql += "AND cr.fecha_solicitud <= ? ";
        sql += "GROUP BY e.cedula, asesor, ag.nombre ORDER BY total_aprobado DESC";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (agencia != null && !agencia.isEmpty()) ps.setInt(i++, Integer.parseInt(agencia));
            if (fechaInicio != null && !fechaInicio.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaInicio));
            if (fechaFin != null && !fechaFin.isEmpty()) ps.setDate(i++, java.sql.Date.valueOf(fechaFin));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("asesor", rs.getString("asesor"));
                fila.put("agencia", rs.getString("agencia"));
                fila.put("asociadosAtendidos", rs.getInt("asociados_atendidos"));
                fila.put("creditosRadicados", rs.getInt("creditos_radicados"));
                fila.put("totalAprobado", rs.getDouble("total_aprobado"));
                fila.put("cuentasAbiertas", rs.getInt("cuentas_abiertas"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Map<String, Object>> codeudoriasActivas() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT c.numero_radicado, " +
                     "a1.nombre || ' ' || a1.apellido AS titular, " +
                     "a2.nombre || ' ' || a2.apellido AS codeudor, " +
                     "c.valor_aprobado, c.fecha_aprobacion, c.estado " +
                     "FROM CREDITO c " +
                     "JOIN ASOCIADO a1 ON c.cedula_asociado = a1.cedula " +
                     "JOIN ASOCIADO a2 ON c.cedula_codeudor = a2.cedula " +
                     "WHERE c.cedula_codeudor IS NOT NULL " +
                     "ORDER BY c.numero_radicado";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> fila = new LinkedHashMap<>();
                fila.put("numeroRadicado", rs.getInt("numero_radicado"));
                fila.put("titular", rs.getString("titular"));
                fila.put("codeudor", rs.getString("codeudor"));
                fila.put("valorAprobado", rs.getDouble("valor_aprobado"));
                fila.put("fechaAprobacion", rs.getString("fecha_aprobacion"));
                fila.put("estado", rs.getString("estado"));
                lista.add(fila);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
