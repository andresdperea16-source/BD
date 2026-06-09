package co.coovalluna.model;

public class Credito {
    private int numeroRadicado;
    private double valorSolicitado;
    private int plazoMeses;
    private String lineaCredito;
    private String fechaSolicitud;
    private String fechaAprobacion;
    private double valorAprobado;
    private String estado;
    private String cedulaAsociado;
    private String cedulaCodeudor;
    private int codigoAgencia;

    public int getNumeroRadicado() { return numeroRadicado; }
    public void setNumeroRadicado(int numeroRadicado) { this.numeroRadicado = numeroRadicado; }

    public double getValorSolicitado() { return valorSolicitado; }
    public void setValorSolicitado(double valorSolicitado) { this.valorSolicitado = valorSolicitado; }

    public int getPlazoMeses() { return plazoMeses; }
    public void setPlazoMeses(int plazoMeses) { this.plazoMeses = plazoMeses; }

    public String getLineaCredito() { return lineaCredito; }
    public void setLineaCredito(String lineaCredito) { this.lineaCredito = lineaCredito; }

    public String getFechaSolicitud() { return fechaSolicitud; }
    public void setFechaSolicitud(String fechaSolicitud) { this.fechaSolicitud = fechaSolicitud; }

    public String getFechaAprobacion() { return fechaAprobacion; }
    public void setFechaAprobacion(String fechaAprobacion) { this.fechaAprobacion = fechaAprobacion; }

    public double getValorAprobado() { return valorAprobado; }
    public void setValorAprobado(double valorAprobado) { this.valorAprobado = valorAprobado; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCedulaAsociado() { return cedulaAsociado; }
    public void setCedulaAsociado(String cedulaAsociado) { this.cedulaAsociado = cedulaAsociado; }

    public String getCedulaCodeudor() { return cedulaCodeudor; }
    public void setCedulaCodeudor(String cedulaCodeudor) { this.cedulaCodeudor = cedulaCodeudor; }

    public int getCodigoAgencia() { return codigoAgencia; }
    public void setCodigoAgencia(int codigoAgencia) { this.codigoAgencia = codigoAgencia; }
}
