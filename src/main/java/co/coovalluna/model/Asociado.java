package co.coovalluna.model;

public class Asociado {
    private String cedula;
    private String nombre;
    private String apellido;
    private String fechaNacimiento;
    private String direccion;
    private String municipio;
    private String telefono;
    private String correo;
    private String fechaAfiliacion;
    private String tipoVinculacion;
    private String estado;

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(String fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getMunicipio() { return municipio; }
    public void setMunicipio(String municipio) { this.municipio = municipio; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getFechaAfiliacion() { return fechaAfiliacion; }
    public void setFechaAfiliacion(String fechaAfiliacion) { this.fechaAfiliacion = fechaAfiliacion; }

    public String getTipoVinculacion() { return tipoVinculacion; }
    public void setTipoVinculacion(String tipoVinculacion) { this.tipoVinculacion = tipoVinculacion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
