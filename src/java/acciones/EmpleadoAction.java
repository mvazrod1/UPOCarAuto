package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import modelo.Concesionario;
import modelo.Empleado;
import modelo.dao.ConcesionarioDAO;
import modelo.dao.EmpleadoDAO;

public class EmpleadoAction extends ActionSupport {

    private String dni;
    private String nombre;
    private String apellidos;
    private String email;
    private String telefono;
    private String direccion;
    private String puesto;
    private String contrasenya;
    private Integer idConcesionario;

    private List<Empleado> listaEmpleados;
    private List<Concesionario> listaConcesionarios;
    private Empleado empleado;

    private EmpleadoDAO dao = new EmpleadoDAO();
    private ConcesionarioDAO concesionarioDAO = new ConcesionarioDAO();

    @Override
    public String execute() {
        try {
            listaEmpleados = dao.listarEmpleados();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al cargar la lista de empleados: " + e.getMessage());
            e.printStackTrace();
            return ERROR;
        }
    }

    // ----- MÉTODOS PARA ALTA -----
    public String mostrarAltaEmpleadoForm() {
        try {
            listaConcesionarios = concesionarioDAO.listar();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al cargar lista de concesionarios: " + e.getMessage());
            e.printStackTrace();
            return ERROR;
        }
    }

    public String registrarEmpleado() {
        try {
            empleado = new Empleado();
            empleado.setDni(dni);
            empleado.setNombre(nombre);
            empleado.setApellidos(apellidos);
            empleado.setEmail(email);
            empleado.setTelefono(telefono);
            empleado.setDireccion(direccion);
            empleado.setPuesto(puesto);
            empleado.setContrasenya(contrasenya);

            Concesionario c = new Concesionario();
            c.setIdConcesionario(idConcesionario);
            empleado.setConcesionario(c);

            dao.altaEmpleado(empleado);
            addActionMessage("Empleado registrado correctamente");
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al registrar empleado: " + e.getMessage());
            e.printStackTrace();
            listaConcesionarios = concesionarioDAO.listar();
            return INPUT;
        }
    }

    // ----- MÉTODO PARA CONSULTA -----
    public String consultarEmpleado() {
        try {
            empleado = dao.consultarEmpleado(dni);
            if (empleado != null) {
                return SUCCESS;
            } else {
                addActionError("No se encontró el empleado con DNI: " + dni);
                return ERROR;
            }
        } catch (Exception e) {
            addActionError("Error al consultar empleado: " + e.getMessage());
            e.printStackTrace();
            return ERROR;
        }
    }
    public String buscar() throws Exception {
        empleado = dao.consultarEmpleado(dni);
        listaEmpleados = new ArrayList<>();
        listaEmpleados.add(empleado);

        return SUCCESS;
    }
    // ----- MÉTODOS PARA EDICIÓN -----
    public String mostrarModificarEmpleadoForm() {
        try {
            empleado = dao.consultarEmpleado(dni);
            if (empleado != null) {
                this.nombre = empleado.getNombre();
                this.apellidos = empleado.getApellidos();
                this.email = empleado.getEmail();
                this.telefono = empleado.getTelefono();
                this.direccion = empleado.getDireccion();
                this.puesto = empleado.getPuesto();
                this.contrasenya = empleado.getContrasenya();
                this.idConcesionario = empleado.getConcesionario() != null
                        ? empleado.getConcesionario().getIdConcesionario()
                        : null;
                listaConcesionarios = concesionarioDAO.listar();
                return SUCCESS;
            } else {
                addActionError("No se encontró el empleado con DNI: " + dni);
                return ERROR;
            }
        } catch (Exception e) {
            addActionError("Error al cargar empleado para edición: " + e.getMessage());
            e.printStackTrace();
            return ERROR;
        }
    }

    public String modificarEmpleado() {
        try {
            Empleado empExistente = dao.consultarEmpleado(dni);
            if (empExistente != null) {
                empExistente.setNombre(nombre);
                empExistente.setApellidos(apellidos);
                empExistente.setEmail(email);
                empExistente.setTelefono(telefono);
                empExistente.setDireccion(direccion);
                empExistente.setPuesto(puesto);
                empExistente.setContrasenya(contrasenya);

                Concesionario c = new Concesionario();
                c.setIdConcesionario(idConcesionario);
                empExistente.setConcesionario(c);

                dao.modificarEmpleado(empExistente);
                addActionMessage("Empleado modificado correctamente");
                return SUCCESS;
            } else {
                addActionError("No se encontró el empleado con DNI: " + dni);
                return INPUT;
            }
        } catch (Exception e) {
            addActionError("Error al modificar empleado: " + e.getMessage());
            e.printStackTrace();
            listaConcesionarios = concesionarioDAO.listar();
            return INPUT;
        }
    }

    // ----- MÉTODO PARA ELIMINAR (REINSERTADO) -----
    public String eliminarEmpleado() {
        try {
            dao.bajaEmpleado(dni);
            addActionMessage("Empleado eliminado correctamente");
            // recarga la lista para que, al volver al index, esté actualizada
            listaEmpleados = dao.listarEmpleados();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al eliminar empleado: " + e.getMessage());
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String logout() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        session.clear();
        return SUCCESS;
    }

    @Override
    public void validate() {
        listaConcesionarios = concesionarioDAO.listar();
        String actionName = com.opensymphony.xwork2.ActionContext.getContext().getName();

        // Sólo validamos en registrarEmpleado y modificarEmpleado
        if ("registrarEmpleado".equals(actionName) || "modificarEmpleado".equals(actionName)) {

            // DNI: obligatorio, 8 dígitos + letra
            if (dni == null || dni.trim().isEmpty()) {
                addFieldError("dni", "El DNI es obligatorio");
            } else if (!dni.matches("^[0-9]{8}[A-Za-z]$")) {
                addFieldError("dni", "Formato de DNI inválido (8 números + letra)");
            }

            // Nombre: obligatorio, al menos 2 caracteres
            if (nombre == null || nombre.trim().isEmpty()) {
                addFieldError("nombre", "El nombre es obligatorio");
            } else if (nombre.length() < 2) {
                addFieldError("nombre", "El nombre debe tener al menos 2 caracteres");
            }

            // Apellidos: obligatorio, al menos 2 caracteres
            if (apellidos == null || apellidos.trim().isEmpty()) {
                addFieldError("apellidos", "Los apellidos son obligatorios");
            } else if (apellidos.length() < 2) {
                addFieldError("apellidos", "Los apellidos deben tener al menos 2 caracteres");
            }

            // Email: obligatorio, patrón básico
            if (email == null || email.trim().isEmpty()) {
                addFieldError("email", "El email es obligatorio");
            } else if (!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
                addFieldError("email", "Formato de email inválido");
            }

            // Teléfono: obligatorio, 9 dígitos
            if (telefono == null || telefono.trim().isEmpty()) {
                addFieldError("telefono", "El teléfono es obligatorio");
            } else if (!telefono.matches("^[0-9]{9}$")) {
                addFieldError("telefono", "El teléfono debe tener 9 dígitos");
            }

            // Dirección: obligatorio, al menos 5 caracteres
            if (direccion == null || direccion.trim().isEmpty()) {
                addFieldError("direccion", "La dirección es obligatoria");
            } else if (direccion.length() < 5) {
                addFieldError("direccion", "La dirección debe tener al menos 5 caracteres");
            }

            // Puesto: obligatorio, al menos 3 caracteres
            if (puesto == null || puesto.trim().isEmpty()) {
                addFieldError("puesto", "El puesto es obligatorio");
            } else if (puesto.length() < 3) {
                addFieldError("puesto", "El puesto debe tener al menos 3 caracteres");
            }

            // Contraseña: obligatorio, entre 6 y 20 caracteres
            if (contrasenya == null || contrasenya.trim().isEmpty()) {
                addFieldError("contrasenya", "La contraseña es obligatoria");
            } else if (contrasenya.length() < 6 || contrasenya.length() > 20) {
                addFieldError("contrasenya", "La contraseña debe tener entre 6 y 20 caracteres");
            }

            // Concesionario: obligatorio (debe seleccionar uno)
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

    public String getContrasenya() {
        return contrasenya;
    }

    public void setContrasenya(String contrasenya) {
        this.contrasenya = contrasenya;
    }

    public Integer getIdConcesionario() {
        return idConcesionario;
    }

    public void setIdConcesionario(Integer idConcesionario) {
        this.idConcesionario = idConcesionario;
    }

    public List<Empleado> getListaEmpleados() {
        return listaEmpleados;
    }

    public void setListaEmpleados(List<Empleado> listaEmpleados) {
        this.listaEmpleados = listaEmpleados;
    }

    public List<Concesionario> getListaConcesionarios() {
        return listaConcesionarios;
    }

    public void setListaConcesionarios(List<Concesionario> listaConcesionarios) {
        this.listaConcesionarios = listaConcesionarios;
    }

    public Empleado getEmpleado() {
        return empleado;
    }

    public void setEmpleado(Empleado empleado) {
        this.empleado = empleado;
    }

    public ConcesionarioDAO getConcesionarioDAO() {
        return concesionarioDAO;
    }

    public void setConcesionarioDAO(ConcesionarioDAO concesionarioDAO) {
        this.concesionarioDAO = concesionarioDAO;
    }

}
