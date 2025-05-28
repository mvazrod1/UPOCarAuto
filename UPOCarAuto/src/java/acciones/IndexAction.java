/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import static com.opensymphony.xwork2.Action.ERROR;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import java.util.Map;
import modelo.Concesionario;
import modelo.Empleado;
import modelo.dao.ConcesionarioDAO;
import modelo.dao.EmpleadoDAO;

/**
 *
 * @author marin
 */
public class IndexAction extends ActionSupport {

    private String dni;
    private String contrasenya;
    private String nombre;
    private String apellidos;
    private String email;
    private String telefono;
    private String direccion;
    private String puesto;
    private Integer idConcesionario;
    private List<Concesionario> listaConcesionarios;

    private ConcesionarioDAO concesionarioDAO = new ConcesionarioDAO();
    private EmpleadoDAO daoE = new EmpleadoDAO();

    public IndexAction() {
    }

    @Override
    public String execute() throws Exception {
        Map<String, Object> session = ActionContext.getContext().getSession();

        Empleado e = new Empleado();
        EmpleadoDAO daoE = new EmpleadoDAO();
        e = daoE.loginEmpleado(this.getDni(), this.getContrasenya());

        if (e != null) {
            session.put("empleado", e);
            return "empleado";
        } else {
            addActionError("Dni o contraseña incorrectos.");
            return ERROR;
        }
    }

    public String registrarEmpleado() {
        try {
            Empleado e = new Empleado();
            e.setDni(this.dni);
            e.setNombre(this.nombre);
            e.setApellidos(this.apellidos);
            e.setEmail(this.email);
            e.setTelefono(this.telefono);
            e.setDireccion(this.direccion);
            e.setPuesto(this.puesto);
            e.setContrasenya(this.contrasenya);

            Concesionario c = new Concesionario();
            c.setIdConcesionario(this.idConcesionario);
            e.setConcesionario(c);

            daoE.altaEmpleado(e);
            addActionMessage("Empleado registrado correctamente.");
            return SUCCESS;
        } catch (Exception ex) {
            addActionError("Error al registrar empleado: " + ex.getMessage());
            try {
                listaConcesionarios = concesionarioDAO.listar();
            } catch (Exception e) {
            }
            return ERROR;
        }
    }

    public String mostrarRegistroForm() {
        try {
            listaConcesionarios = concesionarioDAO.listar();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al cargar la lista de concesionarios: " + e.getMessage());
            return ERROR;
        }
    }

    public void validate() {
        String actionName = ActionContext.getContext().getName();

        if (actionName.equals("login")) {

            if (this.getDni().equals("")) {
                addFieldError("dni", "Introduce el dni");
            }else if (!this.getDni().matches("^[0-9]{8}[A-Za-z]$")) {
                addFieldError("dni", "El DNI debe tener 8 números seguidos de una letra");
            }

            if (this.getContrasenya().equals("")) {
                addFieldError("contrasenya", "Introduce la contraseña");
            }
        }
        if (actionName.equals("registrar")) {
            if (dni == null || dni.trim().isEmpty()) {
                addFieldError("dni", "El DNI es obligatorio");
            } else if (!dni.matches("^[0-9]{8}[A-Za-z]$")) {
                addFieldError("dni", "Formato de DNI inválido");
            }

            if (nombre == null || nombre.trim().isEmpty()) {
                addFieldError("nombre", "El nombre es obligatorio");
            }

            if (apellidos == null || apellidos.trim().isEmpty()) {
                addFieldError("apellidos", "Los apellidos son obligatorios");
            }

            if (email == null || email.trim().isEmpty()) {
                addFieldError("email", "El email es obligatorio");
            }

            if (telefono == null || telefono.trim().isEmpty()) {
                addFieldError("telefono", "El teléfono es obligatorio");
            }

            if (direccion == null || direccion.trim().isEmpty()) {
                addFieldError("direccion", "La dirección es obligatoria");
            }

            if (puesto == null || puesto.trim().isEmpty()) {
                addFieldError("puesto", "El puesto es obligatorio");
            }

            if (contrasenya == null || contrasenya.trim().isEmpty()) {
                addFieldError("contrasenya", "La contraseña es obligatoria");
            }

            if (idConcesionario == null) {
                addFieldError("idConcesionario", "Debe seleccionar un concesionario");
            }
        }
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getContrasenya() {
        return contrasenya;
    }

    public void setContrasenya(String contrasenya) {
        this.contrasenya = contrasenya;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public Integer getIdConcesionario() {
        return idConcesionario;
    }

    public void setIdConcesionario(Integer idConcesionario) {
        this.idConcesionario = idConcesionario;
    }

    public List<Concesionario> getListaConcesionarios() {
        return listaConcesionarios;
    }

    public void setListaConcesionarios(List<Concesionario> listaConcesionarios) {
        this.listaConcesionarios = listaConcesionarios;
    }

    public ConcesionarioDAO getConcesionarioDAO() {
        return concesionarioDAO;
    }

    public void setConcesionarioDAO(ConcesionarioDAO concesionarioDAO) {
        this.concesionarioDAO = concesionarioDAO;
    }

    public EmpleadoDAO getDaoE() {
        return daoE;
    }

    public void setDaoE(EmpleadoDAO daoE) {
        this.daoE = daoE;
    }

}
