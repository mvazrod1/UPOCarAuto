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

    public String guardarModificacion() throws Exception {

        /* 1) Reconstruimos las asociaciones a partir de los ids/dni recibidos   */
        Concesionario c = new Concesionario();
        c.setIdConcesionario(idConcesionario);
        Empleado e = new Empleado();
        e.setDni(dniEmpleado);

        /* 2) Parseamos la fecha que llega como texto */
        java.util.Date fecha
                = new java.text.SimpleDateFormat("yyyy-MM-dd")
                        .parse(ultimaActualizacionStr.trim());

        /* 3) Creamos un POJO “detached” con la clave + nuevos valores          */
        Inventario inv = new Inventario(c, e, totalVehiculos, fecha);
        inv.setIdInventario(idInventario);      // ¡clave primaria!

        /* 4) Delegamos en el DAO la actualización                             */
        dao.actualizar(inv);

        return SUCCESS;          // struts.xml → redirectAction indexInventario
    }

    @Override
    public void validate() {
        String metodo = ActionContext.getContext()
                .getActionInvocation()
                .getProxy()
                .getMethod();

        // Buscar
        if ("buscar".equals(metodo)) {
            if (idInventario == null) {
                addFieldError("idInventario", "Debe introducir el ID de inventario");
            }
        }

        // Consultar
        if ("consultar".equals(metodo)) {
            if (idInventario == null) {
                addFieldError("idInventario", "Debes seleccionar un inventario");
            }
        }

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
        }
        if ("guardarModificacion".equals(metodo)) {
            if (ultimaActualizacionStr == null || ultimaActualizacionStr.trim().isEmpty()) {
                addFieldError("ultimaActualizacionStr",
                        "Debes indicar la fecha de última actualización");
            } else if (!DATE_ISO_PATTERN.matcher(
                    ultimaActualizacionStr.trim()).matches()) {
                addFieldError("ultimaActualizacionStr",
                        "La fecha debe tener formato YYYY-MM-DD");
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
