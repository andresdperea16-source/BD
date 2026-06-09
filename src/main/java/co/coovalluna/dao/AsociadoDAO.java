package co.coovalluna.dao;

import co.coovalluna.db.Conexion;
import co.coovalluna.model.Asociado;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AsociadoDAO {

    public List<Asociado> listarTodos() {
        List<Asociado> lista = new ArrayList<>();
        String sql = "SELECT * FROM ASOCIADO ORDER BY apellido";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Asociado> listarPorFiltros(String estado, String agencia) {
        List<Asociado> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT a.* FROM ASOCIADO a " +
                     "LEFT JOIN CUENTA_AHORRO ca ON a.cedula = ca.cedula_asociado " +
                     "WHERE 1=1 ";
        if (estado != null && !estado.isEmpty()) sql += "AND a.estado = ? ";
        if (agencia != null && !agencia.isEmpty()) sql += "AND ca.codigo_agencia = ? ";
        sql += "ORDER BY a.apellido";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int i = 1;
            if (estado != null && !estado.isEmpty()) ps.setString(i++, estado);
            if (agencia != null && !agencia.isEmpty()) ps.setInt(i++, Integer.parseInt(agencia));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Asociado buscarPorCedula(String cedula) {
        String sql = "SELECT * FROM ASOCIADO WHERE cedula = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertar(Asociado a) {
        String sql = "INSERT INTO ASOCIADO VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getCedula());
            ps.setString(2, a.getNombre());
            ps.setString(3, a.getApellido());
            ps.setDate(4, java.sql.Date.valueOf(a.getFechaNacimiento()));
            ps.setString(5, a.getDireccion());
            ps.setString(6, a.getMunicipio());
            ps.setString(7, a.getTelefono());
            ps.setString(8, a.getCorreo());
            ps.setDate(9, java.sql.Date.valueOf(a.getFechaAfiliacion()));
            ps.setString(10, a.getTipoVinculacion());
            ps.setString(11, a.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean actualizar(Asociado a) {
        String sql = "UPDATE ASOCIADO SET nombre=?, apellido=?, fecha_nacimiento=?, " +
                     "direccion=?, municipio=?, telefono=?, correo=?, " +
                     "tipo_vinculacion=?, estado=? WHERE cedula=?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getApellido());
            ps.setDate(3, java.sql.Date.valueOf(a.getFechaNacimiento()));
            ps.setString(4, a.getDireccion());
            ps.setString(5, a.getMunicipio());
            ps.setString(6, a.getTelefono());
            ps.setString(7, a.getCorreo());
            ps.setString(8, a.getTipoVinculacion());
            ps.setString(9, a.getEstado());
            ps.setString(10, a.getCedula());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Asociado mapear(ResultSet rs) throws SQLException {
        Asociado a = new Asociado();
        a.setCedula(rs.getString("cedula"));
        a.setNombre(rs.getString("nombre"));
        a.setApellido(rs.getString("apellido"));
        a.setFechaNacimiento(rs.getString("fecha_nacimiento"));
        a.setDireccion(rs.getString("direccion"));
        a.setMunicipio(rs.getString("municipio"));
        a.setTelefono(rs.getString("telefono"));
        a.setCorreo(rs.getString("correo"));
        a.setFechaAfiliacion(rs.getString("fecha_afiliacion"));
        a.setTipoVinculacion(rs.getString("tipo_vinculacion"));
        a.setEstado(rs.getString("estado"));
        return a;
    }
}
