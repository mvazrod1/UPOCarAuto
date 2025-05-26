/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import javax.validation.ConstraintViolationException;
import modelo.Cliente;
import modelo.Reserva;
import modelo.Vehiculo;
import modelo.dao.ClienteDAO;
import modelo.dao.ReservaDAO;
import modelo.dao.VehiculoDAO;

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
    private String fecha_recogida;
    private String fechaCreacionFormateada;

    private List<Cliente> listaDnis;
    private List<Vehiculo> listaMatriculas;

    private List<Reserva> listaReservas;
    private Reserva reserva;

    private ReservaDAO dao = new ReservaDAO();
    private ClienteDAO clienteDAO = new ClienteDAO();
    private VehiculoDAO vehiculoDAO = new VehiculoDAO();

    @Override
    public String execute() {
        listaReservas = dao.listarReservas();
        return SUCCESS;
    }

    public String eliminarReserva() throws Exception {

        try {
            Reserva reserva = dao.consultarReserva(idReserva);
            if (reserva == null) {
                addActionError("La reserva no existe.");
                return INPUT;
            }

            Vehiculo vehiculo = reserva.getVehiculo();

            dao.bajaReserva(idReserva);

            vehiculo.setDisponibilidad(true);
            vehiculoDAO.actualizar(vehiculo);

            return SUCCESS;

        } catch (Exception e) {
            addActionError(e.getMessage());
            return ERROR;
        }

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
        listaDnis = clienteDAO.listarClientes();
        listaMatriculas = vehiculoDAO.listarVehiculosDisponibles();
        return SUCCESS;
    }

    public String registrarReserva() {
        try {

            reserva = new Reserva();
            reserva.setCliente(clienteDAO.consultarCliente(dni_cliente));
            reserva.setVehiculo(vehiculoDAO.buscarPorMatricula(matricula));
            reserva.setEstado(estado);
            reserva.setFechaCreacion(new Date());

            if (fecha_recogida != null && !fecha_recogida.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fechaRecogidaDate = sdf.parse(fecha_recogida);
                reserva.setFechaRecogida(fechaRecogidaDate);
            } else {
                reserva.setFechaRecogida(null);
            }

            dao.altaReserva(reserva);

            Vehiculo vehiculo = reserva.getVehiculo();
            vehiculo.setDisponibilidad(false);
            vehiculoDAO.actualizar(vehiculo);

        } catch (Exception e) {
            addActionError("Formato de fecha incorrecto.");
            listaDnis = clienteDAO.listarClientes();
            listaMatriculas = vehiculoDAO.listarVehiculosDisponibles();
            return INPUT;
        }
        return SUCCESS;
    }

    public String mostrarModificarReservaForm() {
        reserva = dao.consultarReserva(idReserva);
        if (reserva != null) {
            dni_cliente = reserva.getCliente().getDni();
            matricula = reserva.getVehiculo().getMatricula();
            estado = reserva.getEstado();
            fecha_creacion = reserva.getFechaCreacion();

            if (fecha_creacion != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                fechaCreacionFormateada = sdf.format(fecha_creacion);
            }

            Date fechaRecogidaDate = reserva.getFechaRecogida();
            if (fechaRecogidaDate != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                fecha_recogida = sdf.format(fechaRecogidaDate);
            } else {
                fecha_recogida = null;
            }
        }
        return SUCCESS;
    }

    public String modificarReserva() {
        try {
            Cliente cliente = clienteDAO.consultarCliente(dni_cliente);
            Vehiculo vehiculo = vehiculoDAO.buscarPorMatricula(matricula);

            if (cliente == null || vehiculo == null) {
                addActionError("Cliente o vehículo no encontrado.");
                return INPUT;
            }

            Date fechaRecogidaDate = null;
            if (fecha_recogida != null && !fecha_recogida.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                fechaRecogidaDate = sdf.parse(fecha_recogida);
            }

            Reserva reservaOriginal = dao.consultarReserva(idReserva);
            if (reservaOriginal == null) {
                addActionError("La reserva no existe.");
                return INPUT;
            }

            reserva = new Reserva();
            reserva.setIdReserva(idReserva);
            reserva.setCliente(cliente);
            reserva.setVehiculo(vehiculo);
            reserva.setEstado(estado);
            reserva.setFechaCreacion(reservaOriginal.getFechaCreacion());
            reserva.setFechaRecogida(fechaRecogidaDate);

            if ("Rechazada".equalsIgnoreCase(estado)) {
                vehiculo.setDisponibilidad(true);
                vehiculoDAO.actualizar(vehiculo);
            } else {
                vehiculo.setDisponibilidad(false);
                vehiculoDAO.actualizar(vehiculo);
            }

            dao.actualizarReserva(reserva);

        } catch (Exception e) {
            addActionError("Error al modificar la reserva: formato de fecha incorrecto.");
            return INPUT;
        }
        return SUCCESS;
    }

    // Validación
    @Override
    public void validate() {
        String actionName = ActionContext.getContext().getName();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);

        if (actionName.equals("registrarReserva")) {
            if (dni_cliente == null || dni_cliente.trim().isEmpty()) {
                addFieldError("dni_cliente", "Introduce el DNI del cliente");
            }
            if (matricula == null || matricula.trim().isEmpty()) {
                addFieldError("matricula", "Introduce la matrícula del vehículo");
            }

            if (estado == null || estado.trim().isEmpty()) {
                addFieldError("estado", "Introduce el estado de la reserva");
            }
            if (fecha_recogida != null && !fecha_recogida.trim().isEmpty()) {
                try {
                    Date fechaRecogidaDate = sdf.parse(fecha_recogida);
                    Date hoy = sdf.parse(sdf.format(new Date()));

                    if (fechaRecogidaDate.before(hoy)) {
                        addFieldError("fecha_recogida", "La fecha de recogida no puede ser anterior a la fecha actual.");
                    }
                } catch (Exception e) {
                    addFieldError("fecha_recogida", "Formato de fecha inválido. Usa yyyy-MM-dd.");
                }
            }
            listaDnis = clienteDAO.listarClientes();
            listaMatriculas = vehiculoDAO.listarVehiculosDisponibles();
        }

        if (actionName.equals("guardarModfReserva")) {
            try {
                Date fechaRecogidaDate = sdf.parse(fecha_recogida);
                Date hoy = sdf.parse(sdf.format(new Date()));

                if (fechaRecogidaDate.before(hoy)) {
                    addFieldError("fecha_recogida", "La fecha de recogida no puede ser anterior a la fecha actual.");
                }

                if (fecha_creacion == null) {
                    addFieldError("fecha_recogida", "La fecha de creación no está definida.");
                } else {
                    Date fechaCreacionDate = sdf.parse(sdf.format(fecha_creacion));
                    if (fechaRecogidaDate.before(fechaCreacionDate)) {
                        addFieldError("fecha_recogida", "La fecha de recogida no puede ser anterior a la fecha de creación.");
                    }
                }

            } catch (Exception e) {
                addFieldError("fecha_recogida", "Formato de fecha inválido. Usa yyyy-MM-dd.");
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

    public String getFechaCreacionFormateada() {
        return fechaCreacionFormateada;
    }

    public void setFechaCreacionFormateada(String fechaCreacionFormateada) {
        this.fechaCreacionFormateada = fechaCreacionFormateada;
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

    public void setFecha_creacion(String fecha_creacion) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            this.fecha_creacion = sdf.parse(fecha_creacion);
        } catch (ParseException e) {
            this.fecha_creacion = null;
        }
    }

    public String getFecha_recogida() {
        return fecha_recogida;
    }

    public void setFecha_recogida(String fecha_recogida) {
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

    public VehiculoDAO getVehiculoDAO() {
        return vehiculoDAO;
    }

    public void setVehiculoDAO(VehiculoDAO vehiculoDAO) {
        this.vehiculoDAO = vehiculoDAO;
    }

    public List<Cliente> getListaDnis() {
        return listaDnis;
    }

    public void setListaDnis(List<Cliente> listaDnis) {
        this.listaDnis = listaDnis;
    }

    public List<Vehiculo> getListaMatriculas() {
        return listaMatriculas;
    }

    public void setListaMatriculas(List<Vehiculo> listaMatriculas) {
        this.listaMatriculas = listaMatriculas;
    }

}
