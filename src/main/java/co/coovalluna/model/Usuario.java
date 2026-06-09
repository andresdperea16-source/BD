package co.coovalluna.model;

public class Usuario {
    private int idUsuario;
    private String nombreUsuario;
    private String contrasena;
    private String estado;
    private String rol;
    private String cedulaAsociado;
    private String cedulaEmpleado;

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }

    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public String getCedulaAsociado() { return cedulaAsociado; }
    public void setCedulaAsociado(String cedulaAsociado) { this.cedulaAsociado = cedulaAsociado; }

    public String getCedulaEmpleado() { return cedulaEmpleado; }
    public void setCedulaEmpleado(String cedulaEmpleado) { this.cedulaEmpleado = cedulaEmpleado; }
}
