package co.coovalluna.model;

public class CuentaAhorro {
    private String numeroCuenta;
    private String fechaApertura;
    private String estado;
    private String cedulaAsociado;
    private int codigoAgencia;
    private double saldo;

    public String getNumeroCuenta() { return numeroCuenta; }
    public void setNumeroCuenta(String numeroCuenta) { this.numeroCuenta = numeroCuenta; }

    public String getFechaApertura() { return fechaApertura; }
    public void setFechaApertura(String fechaApertura) { this.fechaApertura = fechaApertura; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCedulaAsociado() { return cedulaAsociado; }
    public void setCedulaAsociado(String cedulaAsociado) { this.cedulaAsociado = cedulaAsociado; }

    public int getCodigoAgencia() { return codigoAgencia; }
    public void setCodigoAgencia(int codigoAgencia) { this.codigoAgencia = codigoAgencia; }

    public double getSaldo() { return saldo; }
    public void setSaldo(double saldo) { this.saldo = saldo; }
}
