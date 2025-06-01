package acciones;

import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import modelo.Pago;
import modelo.Reserva;
import modelo.dao.PagoDAO;
import modelo.dao.ReservaDAO;
import servicios2.Informe;
import servicios2.InformeService;

public class PagoAction extends ActionSupport {

    private final PagoDAO dao = new PagoDAO();
    private final ReservaDAO reservaDAO = new ReservaDAO();

    private List<Pago> lista;
    private Pago pago;
    private Integer idPago;
    private Integer idReserva;
    private Date fechaPago;
    private BigDecimal precioTotal;
    private String metodoPago;
    private String estadoPago;

    public String execute() {
        lista = dao.listarPagos();
        return SUCCESS;
    }

    public String consultarPago() {
        pago = dao.consultarPago(idPago);
        if (pago != null) {
            idReserva = pago.getReserva().getIdReserva();
            fechaPago = pago.getFechaPago();
            precioTotal = pago.getPrecioTotal();
            metodoPago = pago.getMetodoPago();
            estadoPago = pago.getEstadoPago();
        }
        return SUCCESS;
    }

    public String modificarPago() {
        Reserva reserva = reservaDAO.consultarReserva(idReserva);
        Pago p = new Pago();
        p.setIdPago(idPago);
        p.setReserva(reserva);
        p.setFechaPago(fechaPago);
        p.setPrecioTotal(precioTotal);
        p.setMetodoPago(metodoPago);
        p.setEstadoPago(estadoPago);
        dao.actualizarPago(p);
        return SUCCESS;
    }

    public String guardarAlta() {

        Reserva res = reservaDAO.consultarReserva(idReserva);
        if (res == null) {
            addActionError("La reserva " + idReserva + " no existe.");
            return INPUT;
        }

        pago = new Pago(res, fechaPago, precioTotal, metodoPago, estadoPago);

        try {
            dao.crearPago(pago);

            // ===== Llamar al Web Service para generar informe PDF =====
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                InformeService servicio = new InformeService();  // cliente generado
                Informe port = servicio.getInformePort();

                String respuesta = port.generarInformePago(
                        pago.getIdPago(),
                        pago.getReserva().getIdReserva(),
                        sdf.format(pago.getFechaPago()),
                        pago.getPrecioTotal().toPlainString(),
                        pago.getMetodoPago(),
                        pago.getEstadoPago()
                );

                System.out.println("Informe generado: " + respuesta);

            } catch (Exception e) {
                System.err.println("Error al llamar al Web Service de informe: " + e.getMessage());
            }
            // ============================================================

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            addActionError("Error al guardar: " + e.getMessage());
            return INPUT;
        }
    }

    public String eliminarPago() {

        if (idPago == null) {
            addActionError("No se indicó el ID del pago a eliminar.");
            return ERROR;
        }

        try {
            dao.bajaPago(idPago);
            return SUCCESS;
        } catch (Exception e) {
            // registra el error y devuelve a la vista con mensaje
            e.printStackTrace();
            addActionError("No se pudo eliminar el pago: " + e.getMessage());
            return ERROR;
        }
    }

    @Override
    public void validate() {
        String actionName = com.opensymphony.xwork2.ActionContext.getContext().getName();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        if ("guardarPago".equals(actionName) || "modificarPago".equals(actionName)) {

            // Validar idReserva
            if (idReserva == null) {
                addFieldError("idReserva", "Debes seleccionar una reserva.");
            } else if (reservaDAO.consultarReserva(idReserva) == null) {
                addFieldError("idReserva", "La reserva seleccionada no existe.");
            }

            // Validar fecha de pago
            if (fechaPago == null) {
                addFieldError("fechaPago", "La fecha de pago es obligatoria.");
            } else {
                try {
                    Date hoy = sdf.parse(sdf.format(new Date()));
                    Date fecha = sdf.parse(sdf.format(fechaPago));

                    if (fecha.after(hoy)) {
                        addFieldError("fechaPago", "La fecha no puede ser futura.");
                    }
                } catch (Exception e) {
                    addFieldError("fechaPago", "Formato de fecha inválido. Usa yyyy-MM-dd.");
                }
            }

            // Validar precio total
            if (precioTotal == null) {
                addFieldError("precioTotal", "El precio total es obligatorio.");
            } else if (precioTotal.compareTo(BigDecimal.ZERO) <= 0) {
                addFieldError("precioTotal", "El precio debe ser mayor que cero.");
            }

            // Validar método de pago
            if (metodoPago == null || metodoPago.trim().isEmpty()) {
                addFieldError("metodoPago", "El método de pago es obligatorio.");
            } else if (!metodoPago.matches("(?i)^(Efectivo|Tarjeta|Bizum|Transferencia)$")) {
                addFieldError("metodoPago", "Método de pago no válido.");
            }

            // Validar estado del pago
            if (estadoPago == null || estadoPago.trim().isEmpty()) {
                addFieldError("estadoPago", "El estado del pago es obligatorio.");
            } else if (!estadoPago.matches("(?i)^(Pendiente|Completado|Fallido|Cancelado)$")) {
                addFieldError("estadoPago", "Estado del pago no válido.");
            }
        }
    }

    // Getters y setters
    public List<Pago> getLista() {
        return lista;
    }

    public Pago getPago() {
        return pago;
    }

    public void setIdPago(Integer idPago) {
        this.idPago = idPago;
    }

    public Integer getIdPago() {
        return idPago;
    }

    public void setIdReserva(Integer idReserva) {
        this.idReserva = idReserva;
    }

    public Integer getIdReserva() {
        return idReserva;
    }

    public Date getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Date fechaPago) {
        this.fechaPago = fechaPago;
    }

    public BigDecimal getPrecioTotal() {
        return precioTotal;
    }

    public void setPrecioTotal(BigDecimal precioTotal) {
        this.precioTotal = precioTotal;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }
}
