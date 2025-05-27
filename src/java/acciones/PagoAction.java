package acciones;

import com.opensymphony.xwork2.ActionSupport;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import modelo.Pago;
import modelo.Reserva;
import modelo.dao.PagoDAO;
import modelo.dao.ReservaDAO;

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
