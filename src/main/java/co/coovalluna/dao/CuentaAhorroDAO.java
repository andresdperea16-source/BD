package co.coovalluna.dao;

import co.coovalluna.db.Conexion;
import co.coovalluna.model.CuentaAhorro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CuentaAhorroDAO {

    public List<CuentaAhorro> listarPorAsociado(String cedula) {
        List<CuentaAhorro> lista = new ArrayList<>();
        String sql = "SELECT ca.*, " +
                     "COALESCE(SUM(CASE WHEN m.tipo IN ('Deposito','Transferencia entrante') THEN m.valor ELSE 0 END), 0) - " +
                     "COALESCE(SUM(CASE WHEN m.tipo IN ('Retiro','Transferencia saliente') THEN m.valor ELSE 0 END), 0) AS saldo " +
                     "FROM CUENTA_AHORRO ca " +
                     "LEFT JOIN MOVIMIENTO m ON ca.numero_cuenta = m.numero_cuenta " +
                     "WHERE ca.cedula_asociado = ? " +
                     "GROUP BY ca.numero_cuenta, ca.fecha_apertura, ca.estado, ca.cedula_asociado, ca.codigo_agencia";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<CuentaAhorro> listarTodas() {
        List<CuentaAhorro> lista = new ArrayList<>();
        String sql = "SELECT ca.*, " +
                     "COALESCE(SUM(CASE WHEN m.tipo IN ('Deposito','Transferencia entrante') THEN m.valor ELSE 0 END), 0) - " +
                     "COALESCE(SUM(CASE WHEN m.tipo IN ('Retiro','Transferencia saliente') THEN m.valor ELSE 0 END), 0) AS saldo " +
                     "FROM CUENTA_AHORRO ca " +
                     "LEFT JOIN MOVIMIENTO m ON ca.numero_cuenta = m.numero_cuenta " +
                     "GROUP BY ca.numero_cuenta, ca.fecha_apertura, ca.estado, ca.cedula_asociado, ca.codigo_agencia";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean insertar(CuentaAhorro c) {
        String sql = "INSERT INTO CUENTA_AHORRO VALUES (?,?,?,?,?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNumeroCuenta());
            ps.setDate(2, java.sql.Date.valueOf(c.getFechaApertura()));
            ps.setString(3, c.getEstado());
            ps.setString(4, c.getCedulaAsociado());
            ps.setInt(5, c.getCodigoAgencia());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private CuentaAhorro mapear(ResultSet rs) throws SQLException {
        CuentaAhorro c = new CuentaAhorro();
        c.setNumeroCuenta(rs.getString("numero_cuenta"));
        c.setFechaApertura(rs.getString("fecha_apertura"));
        c.setEstado(rs.getString("estado"));
        c.setCedulaAsociado(rs.getString("cedula_asociado"));
        c.setCodigoAgencia(rs.getInt("codigo_agencia"));
        c.setSaldo(rs.getDouble("saldo"));
        return c;
    }
}
