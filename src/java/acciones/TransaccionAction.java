/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import modelo.Transaccion;
import modelo.dao.TransaccionDAO;

/**
 *
 * @author teodo
 */
public class TransaccionAction extends ActionSupport {

    private final TransaccionDAO dao = new TransaccionDAO();

    private List<Transaccion> lista;
    private Transaccion transaccion;

    private Integer idTransaccion;
    private Date fechaTransaccion;
    private BigDecimal precio;
    private String metodoPago;
    private String estado;

    public TransaccionAction() {
    }

    public String execute() throws Exception {
        lista = dao.listarTodas();
        return SUCCESS;
    }

    public String buscar() throws Exception {
        transaccion = dao.buscarPorId(idTransaccion);
        lista = new ArrayList<>();
        lista.add(transaccion);

        return SUCCESS;
    }

    public String consultarTransaccion() {
        transaccion = dao.buscarPorId(idTransaccion);
        return SUCCESS;
    }

    public String guardarAlta() {
        transaccion = new Transaccion(
                fechaTransaccion,
                precio,
                metodoPago,
                estado);

        dao.crear(transaccion);
        return SUCCESS;
    }

    public String modificar() {
        transaccion = dao.buscarPorId(idTransaccion);

        fechaTransaccion = transaccion.getFechaTransaccion();
        precio = transaccion.getPrecio();
        metodoPago = transaccion.getMetodoPago();
        estado = transaccion.getEstado();

        return SUCCESS;
    }

    public String guardarModificacion() {
        Transaccion t = new Transaccion(
                fechaTransaccion,
                precio,
                metodoPago,
                estado);
        t.setIdTransaccion(idTransaccion);   // identifica la fila
        dao.actualizar(t);
        return SUCCESS;
    }

    public String eliminar() {
        if (idTransaccion == null) {
            addActionError("Debes seleccionar una transacción para eliminar.");
            return INPUT;
        }
        dao.eliminarPorId(idTransaccion);
        return SUCCESS;
    }

    @Override
    public void validate() {
        String actionName = com.opensymphony.xwork2.ActionContext.getContext().getName();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        if ("guardarTransaccion".equals(actionName) || "guardarModfTransaccion".equals(actionName)) {

            // Validar fecha de transacción
            if (fechaTransaccion == null) {
                addFieldError("fechaTransaccion", "La fecha de transacción es obligatoria.");
            } else {
                try {
                    // Validar que no sea futura
                    Date hoy = sdf.parse(sdf.format(new Date()));
                    Date fecha = sdf.parse(sdf.format(fechaTransaccion));

                    if (fecha.after(hoy)) {
                        addFieldError("fechaTransaccion", "La fecha no puede ser futura.");
                    }
                } catch (Exception e) {
                    addFieldError("fechaTransaccion", "Formato de fecha inválido. Usa yyyy-MM-dd.");
                }
            }

            // Validar precio
            if (precio == null) {
                addFieldError("precio", "El precio es obligatorio.");
            } else if (precio.compareTo(BigDecimal.ZERO) <= 0) {
                addFieldError("precio", "El precio debe ser mayor que cero.");
            }

            // Validar método de pago
            if (metodoPago == null || metodoPago.trim().isEmpty()) {
                addFieldError("metodoPago", "El método de pago es obligatorio.");
            } else if (!metodoPago.matches("(?i)^(Tarjeta|Bizum|Transferencia)$")) {
                addFieldError("metodoPago", "Método de pago no válido.");
            }

            // Validar estado
            if (estado == null || estado.trim().isEmpty()) {
                addFieldError("estado", "El estado es obligatorio.");
            } else if (!estado.matches("(?i)^(Pendiente|Completada|Cancelada)$")) {
                addFieldError("estado", "Estado no válido.");
            }

        }
    }

    public List<Transaccion> getLista() {
        return lista;
    }

    public void setLista(List<Transaccion> lista) {
        this.lista = lista;
    }

    public Transaccion getTransaccion() {
        return transaccion;
    }

    public void setTransaccion(Transaccion transaccion) {
        this.transaccion = transaccion;
    }

    public Integer getIdTransaccion() {
        return idTransaccion;
    }

    public void setIdTransaccion(Integer idTransaccion) {
        this.idTransaccion = idTransaccion;
    }

    public Date getFechaTransaccion() {
        return fechaTransaccion;
    }

    public void setFechaTransaccion(Date fechaTransaccion) {
        this.fechaTransaccion = fechaTransaccion;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

}
