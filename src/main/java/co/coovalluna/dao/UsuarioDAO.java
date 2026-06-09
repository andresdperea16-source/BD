package co.coovalluna.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import co.coovalluna.db.Conexion;
import co.coovalluna.model.Usuario;

public class UsuarioDAO {
    public Usuario login(String nombreUsuario, String contrasena) {
        String sql = "SELECT * FROM usuario WHERE nombre_usuario = ? AND contrasena = ? AND estado = 'Activo'";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombreUsuario);
            ps.setString(2, contrasena);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setCedulaAsociado(rs.getString("cedula_asociado"));
                u.setCedulaEmpleado(rs.getString("cedula_empleado"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}