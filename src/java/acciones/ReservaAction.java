/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import modelo.Cliente;
import modelo.Reserva;
import modelo.dao.ClienteDAO;
import modelo.dao.ReservaDAO;

/**
 *
 * @author marin
 */
public class ReservaAction extends ActionSupport {

    private Integer idReserva;
    private String dni_cliente;
    private String matricula;
    private String estado;
    private Date fecha_creacion;
    private Date fecha_recogida;

    private List<Reserva> listaReservas;
    private Reserva reserva;

    private ReservaDAO dao = new ReservaDAO();
    private ClienteDAO clienteDAO = new ClienteDAO();
    //private VehiculoDAO vehiculoDAO = new VehiculoDAO();

    @Override
    public String execute() {
        listaReservas = dao.listarReservas();
        return SUCCESS;
    }

    public String eliminarReserva() {
        dao.bajaReserva(idReserva);
        return SUCCESS;
    }

    public String buscar() throws Exception {
        reserva = dao.consultarReserva(idReserva);
        listaReservas = new ArrayList<>();

        if (reserva == null) {
            addActionMessage("La reserva con ID " + idReserva + " no existe.");
            return INPUT;
        }
        listaReservas.add(reserva);

        return SUCCESS;
    }

    public String consultarReserva() {
        reserva = dao.consultarReserva(idReserva);
        return SUCCESS;
    }

    public String mostrarAltaReservaForm() {
        return SUCCESS;
    }

    public String registrarReserva() {
        Cliente cliente = clienteDAO.consultarCliente(dni_cliente);
        //Vehiculo vehiculo = vehiculoDAO.buscarPorMatricula(matricula);
        /*
        if (cliente == null || vehiculo == null) {
            addActionError("Cliente o vehículo no encontrado.");
            return INPUT;
        }*/

        reserva = new Reserva();
        reserva.setCliente(cliente);
        //reserva.setVehiculo(vehiculo);
        reserva.setEstado(estado);
        reserva.setFechaCreacion(new Date());
        reserva.setFechaRecogida(fecha_recogida);

        dao.altaReserva(reserva);
        return SUCCESS;
    }

    public String mostrarModificarReservaForm() {
        reserva = dao.consultarReserva(idReserva);
        if (reserva != null) {
            dni_cliente = reserva.getCliente().getDni();
            matricula = reserva.getVehiculo().getMatricula();
            estado = reserva.getEstado();
            fecha_creacion = reserva.getFechaCreacion();
            fecha_recogida = reserva.getFechaRecogida();
        }
        return SUCCESS;
    }

    public String modificarReserva() {
        Cliente cliente = clienteDAO.consultarCliente(dni_cliente);
        //Vehiculo vehiculo = vehiculoDAO.buscarPorMatricula(matricula);
        /*
        if (cliente == null || vehiculo == null) {
            addActionError("Cliente o vehículo no encontrado.");
            return INPUT;
        }*/

        reserva = new Reserva();
        reserva.setIdReserva(idReserva);
        reserva.setCliente(cliente);
        //reserva.setVehiculo(vehiculo);
        reserva.setEstado(estado);
        reserva.setFechaCreacion(fecha_creacion != null ? fecha_creacion : new Date());
        reserva.setFechaRecogida(fecha_recogida);

        dao.actualizarReserva(reserva);
        return SUCCESS;
    }

    // Validación
    @Override
    public void validate() {
        String actionName = ActionContext.getContext().getName();

        if (actionName.equals("registrarReserva") || actionName.equals("modificarReserva")) {
            if (dni_cliente == null || dni_cliente.trim().isEmpty()) {
                addFieldError("dni_cliente", "Introduce el DNI del cliente");
            }
            if (matricula == null || matricula.trim().isEmpty()) {
                addFieldError("matricula", "Introduce la matrícula del vehículo");
            }
            if (estado == null || estado.trim().isEmpty()) {
                addFieldError("estado", "Introduce el estado de la reserva");
            }
            if (fecha_recogida == null) {
                addFieldError("fecha_recogida", "La fecha de recogida es obligatoria");
            }
        }
    }

    public Integer getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(Integer idReserva) {
        this.idReserva = idReserva;
    }

    public String getDni_cliente() {
        return dni_cliente;
    }

    public void setDni_cliente(String dni_cliente) {
        this.dni_cliente = dni_cliente;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha_creacion() {
        return fecha_creacion;
    }

    public void setFecha_creacion(Date fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }

    public Date getFecha_recogida() {
        return fecha_recogida;
    }

    public void setFecha_recogida(Date fecha_recogida) {
        this.fecha_recogida = fecha_recogida;
    }

    public List<Reserva> getListaReservas() {
        return listaReservas;
    }

    public void setListaReservas(List<Reserva> listaReservas) {
        this.listaReservas = listaReservas;
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public ReservaDAO getDao() {
        return dao;
    }

    public void setDao(ReservaDAO dao) {
        this.dao = dao;
    }

    public ClienteDAO getClienteDAO() {
        return clienteDAO;
    }

    public void setClienteDAO(ClienteDAO clienteDAO) {
        this.clienteDAO = clienteDAO;
    }
    /*
    public VehiculoDAO getVehiculoDAO() {
        return vehiculoDAO;
    }

    public void setVehiculoDAO(VehiculoDAO vehiculoDAO) {
        this.vehiculoDAO = vehiculoDAO;
    }*/

}
