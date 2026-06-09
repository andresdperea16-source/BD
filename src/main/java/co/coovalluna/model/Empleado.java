package co.coovalluna.model;

public class Empleado {
    private String cedula;
    private String nombre;
    private String apellido;
    private String cargo;
    private String fechaIngreso;
    private double salarioBase;
    private String correoCorporativo;
    private String estado;
    private String cedulaSupervisor;
    private int codigoAgencia;

    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }

    public String getFechaIngreso() { return fechaIngreso; }
    public void setFechaIngreso(String fechaIngreso) { this.fechaIngreso = fechaIngreso; }

    public double getSalarioBase() { return salarioBase; }
    public void setSalarioBase(double salarioBase) { this.salarioBase = salarioBase; }

    public String getCorreoCorporativo() { return correoCorporativo; }
    public void setCorreoCorporativo(String correoCorporativo) { this.correoCorporativo = correoCorporativo; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCedulaSupervisor() { return cedulaSupervisor; }
    public void setCedulaSupervisor(String cedulaSupervisor) { this.cedulaSupervisor = cedulaSupervisor; }

    public int getCodigoAgencia() { return codigoAgencia; }
    public void setCodigoAgencia(int codigoAgencia) { this.codigoAgencia = codigoAgencia; }
}
