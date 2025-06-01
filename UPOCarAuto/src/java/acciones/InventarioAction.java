/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;
import modelo.Concesionario;
import modelo.Empleado;
import modelo.Inventario;
import modelo.dao.ConcesionarioDAO;
import modelo.dao.EmpleadoDAO;
import modelo.dao.InventarioDAO;

public class InventarioAction extends ActionSupport {

    private InventarioDAO dao = new InventarioDAO();
    private List<Inventario> lista;
    private Integer idInventario;
    private Inventario inventario;
    private Integer idConcesionario;
    private String dniEmpleado;
    private Integer totalVehiculos;
    private String ultimaActualizacionStr;
    ActionInvocation ai = ActionContext.getContext().getActionInvocation();
    String metodo = ai.getProxy().getMethod();
    private static final Pattern DNI_PATTERN
            = Pattern.compile("^[0-9]{8}[A-HJ-NP-TV-Z]$");
    private static final Pattern DATE_ISO_PATTERN
            = Pattern.compile("^\\d{4}-\\d{2}-\\d{2}$");

    @Override
    public String execute() throws Exception {
        lista = dao.listarTodos();
        return SUCCESS;
    }

    public String consultar() throws Exception {
        inventario = dao.buscarPorId(idInventario);
        return SUCCESS;
    }

    public String buscar() throws Exception {
        // Recupera el inventario
        Inventario inv = dao.buscarPorId(idInventario);
        lista = new ArrayList<>();
        if (inv != null) {
            lista.add(inv);
        }
        return SUCCESS;
    }

    public String guardarAlta() throws ParseException {
        ConcesionarioDAO cDAO = new ConcesionarioDAO();
        EmpleadoDAO eDAO = new EmpleadoDAO();

        // parseamos la fecha una sola vez
        Date fecha = new SimpleDateFormat("yyyy-MM-dd")
                .parse(ultimaActualizacionStr.trim());
        Concesionario c = cDAO.consultarConcesionario(idConcesionario);
        Empleado e = eDAO.consultarEmpleado(dniEmpleado.trim());
        // construimos Inventario con el constructor completo
        Inventario inv = new Inventario(c, e, 0, fecha);

        dao.crear(inv);
        return SUCCESS;
    }

    public String eliminar() {

        if (idInventario == null) {
            addActionError("Debes seleccionar un inventario para eliminar");
            return INPUT;
        }

        dao.eliminarPorId(idInventario);
        return SUCCESS;
    }

    public String modificar() throws Exception {

        inventario = dao.buscarPorId(idInventario);

        idConcesionario = inventario.getConcesionario().getIdConcesionario();
        dniEmpleado = inventario.getEmpleado().getDni();
        totalVehiculos = inventario.getTotalVehiculos();

        ultimaActualizacionStr = new java.text.SimpleDateFormat("yyyy-MM-dd")
                .format(inventario.getUltimaActualizacion());

        return SUCCESS;
    }

//    public String guardarModificacion() throws Exception {
//
//        Concesionario c = new Concesionario();
//        c.setIdConcesionario(idConcesionario);
//        Empleado e = new Empleado();
//        e.setDni(dniEmpleado);
//
//        java.util.Date fecha
//                = new java.text.SimpleDateFormat("yyyy-MM-dd")
//                        .parse(ultimaActualizacionStr.trim());
//
//        Inventario inv = new Inventario(c, e, totalVehiculos, fecha);
//        inv.setIdInventario(idInventario);
//
//        dao.actualizar(inv);
//
//        return SUCCESS;
//    }
//    public String guardarModificacion() throws Exception {
//
//        Inventario inventarioParaActualizar = dao.buscarPorId(this.idInventario);
//
//        ConcesionarioDAO concesionarioDAO = new ConcesionarioDAO(); // O inyectarlo
//        Concesionario concesionarioAsociado = concesionarioDAO.consultarConcesionario(this.idConcesionario);
//        if (concesionarioAsociado == null) {
//            addFieldError("idConcesionario", "El concesionario con ID " + this.idConcesionario + " no existe.");
//            return INPUT;
//        }
//
//        EmpleadoDAO empleadoDAO = new EmpleadoDAO();
//        Empleado empleadoAsociado = empleadoDAO.consultarEmpleado(this.dniEmpleado.trim());
//        if (empleadoAsociado == null) {
//            addFieldError("dniEmpleado", "El empleado con DNI " + this.dniEmpleado + " no existe.");
//            return INPUT;
//        }
//
//        Date fechaActualizacion;
//        fechaActualizacion = new SimpleDateFormat("yyyy-MM-dd").parse(this.ultimaActualizacionStr.trim());
//
//        inventarioParaActualizar.setConcesionario(concesionarioAsociado);
//        inventarioParaActualizar.setEmpleado(empleadoAsociado);
//        inventarioParaActualizar.setTotalVehiculos(this.totalVehiculos); // Java hará unboxing de Integer a int
//        inventarioParaActualizar.setUltimaActualizacion(fechaActualizacion);
//
//        try {
//            dao.actualizar(inventarioParaActualizar); // Pasas la entidad gestionada y modificada
//            addActionMessage("Inventario modificado exitosamente.");
//        } catch (Exception e) {
//            addActionError("Error al guardar las modificaciones del inventario: " + e.getMessage());
//            // e.printStackTrace(); // Para depuración
//            return INPUT;
//        }
//
//        return SUCCESS;
//    }
    public String guardarModificacion() throws Exception {
        Inventario inventarioParaActualizar = dao.buscarPorId(this.idInventario);
        if (inventarioParaActualizar == null) {
            addActionError("El inventario (ID: " + this.idInventario + ") no fue encontrado.");
            return INPUT;
        }

        ConcesionarioDAO concesionarioDAO = new ConcesionarioDAO();
        Concesionario concesionarioAsociado = concesionarioDAO.consultarConcesionario(this.idConcesionario);
        if (concesionarioAsociado == null) {
            addFieldError("idConcesionario", "El concesionario con ID " + this.idConcesionario + " no existe.");
            return INPUT;
        }

        EmpleadoDAO empleadoDAO = new EmpleadoDAO();
        Empleado empleadoAsociado = empleadoDAO.consultarEmpleado(this.dniEmpleado.trim());
        if (empleadoAsociado == null) {
            addFieldError("dniEmpleado", "El empleado con DNI " + this.dniEmpleado + " no existe.");
            return INPUT;
        }

        Date fechaActualizacion;
        try {
            fechaActualizacion = new SimpleDateFormat("yyyy-MM-dd").parse(this.ultimaActualizacionStr.trim());
        } catch (ParseException pe) {
            addFieldError("ultimaActualizacionStr", "Formato de fecha incorrecto. Use YYYY-MM-DD.");
            return INPUT;
        }

        inventarioParaActualizar.setConcesionario(concesionarioAsociado);
        inventarioParaActualizar.setEmpleado(empleadoAsociado);
        inventarioParaActualizar.setUltimaActualizacion(fechaActualizacion);

        try {
            dao.actualizar(inventarioParaActualizar);
            addActionMessage("Inventario modificado exitosamente.");
        } catch (Exception e) {
            addActionError("Error al guardar las modificaciones del inventario: " + e.getMessage());
            return INPUT;
        }
        return SUCCESS;
    }

    @Override
    public void validate() {
        String metodo = ActionContext.getContext()
                .getActionInvocation()
                .getProxy()
                .getMethod();

        if ("guardarAlta".equals(metodo)) {
            ConcesionarioDAO cDAO = new ConcesionarioDAO();
            Concesionario cons = cDAO.consultarConcesionario(idConcesionario);

            if (cons == null) {
                addFieldError("idConcesionario",
                        "El concesionario indicado no existe");
            }

            // 2. Solo puede haber un inventario por concesionario
            if (dao.existeInventarioParaConcesionario(idConcesionario)) {
                addFieldError("idConcesionario",
                        "Ese concesionario ya tiene un inventario registrado");
            }

            if (ultimaActualizacionStr == null || ultimaActualizacionStr.trim().isEmpty()) {
                addFieldError("ultimaActualizacionStr",
                        "Debes indicar la fecha de última actualización");
            } else if (!DATE_ISO_PATTERN.matcher(
                    ultimaActualizacionStr.trim()).matches()) {
                addFieldError("ultimaActualizacionStr",
                        "La fecha debe tener formato YYYY-MM-DD");
            }

            if (dniEmpleado == null) {
                addFieldError("dniEmpleado",
                        "El campo dni del empleado es obligatorio");
            }

        }
        if ("guardarModificacion".equals(metodo)) {

            if (dniEmpleado == null || "".equals(dniEmpleado)) {
                addFieldError("dniEmpleado",
                        "El campo dni del empleado es obligatorio");
            }

            Date fechaActualizacion;
            try {
                fechaActualizacion = new SimpleDateFormat("yyyy-MM-dd").parse(this.ultimaActualizacionStr.trim());
            } catch (ParseException pe) {
                addFieldError("ultimaActualizacionStr", "Formato de fecha incorrecto. Use YYYY-MM-DD.");
            }

        }
    }

    public List<Inventario> getLista() {
        return lista;
    }

    public Integer getIdInventario() {
        return idInventario;
    }

    public void setIdInventario(Integer idInventario) {
        this.idInventario = idInventario;
    }

    public Inventario getInventario() {
        return inventario;
    }

    public void setIdConcesionario(Integer idConcesionario) {
        this.idConcesionario = idConcesionario;
    }

    public void setDniEmpleado(String dniEmpleado) {
        this.dniEmpleado = dniEmpleado;
    }

    public void setUltimaActualizacionStr(String ultimaActualizacionStr) {
        this.ultimaActualizacionStr = ultimaActualizacionStr;
    }

}
