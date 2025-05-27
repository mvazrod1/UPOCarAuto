package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import modelo.Concesionario;
import modelo.dao.ConcesionarioDAO;

public class ConcesionarioAction extends ActionSupport {

    private Integer idConcesionario;
    private String  nombre;
    private String  direccion;
    private String  telefono;
    private String  correo;

    private List<Concesionario> listaConcesionarios;
    private Concesionario       concesionario;

    private final ConcesionarioDAO dao = new ConcesionarioDAO();

    @Override
    public String execute() {
        try {
            listaConcesionarios = dao.listar();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al cargar lista de concesionarios: " + e.getMessage());
            return ERROR;
        }
    }

    public String mostrarAltaConcesionarioForm() {
        return SUCCESS;
    }

    public String registrarConcesionario() {
        try {
            Concesionario c = new Concesionario();
            c.setNombre(nombre);
            c.setDireccion(direccion);
            c.setTelefono(telefono);
            c.setCorreo(correo);
            dao.altaConcesionario(c);
            addActionMessage("Concesionario registrado correctamente");
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al registrar concesionario: " + e.getMessage());
            return INPUT;
        }
    }

    public String consultarConcesionario() {
        try {
            concesionario = dao.consultarConcesionario(idConcesionario);
            if (concesionario == null) {
                addActionError("No existe el concesionario con ID: " + idConcesionario);
                return ERROR;
            }
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al consultar concesionario: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String buscar() throws Exception {
        concesionario = dao.consultarConcesionario(idConcesionario);
        listaConcesionarios = new ArrayList<>();
        listaConcesionarios.add(concesionario);

        return SUCCESS;
    }

    public String mostrarModificarConcesionarioForm() {
        try {
            concesionario = dao.consultarConcesionario(idConcesionario);
            if (concesionario == null) {
                addActionError("No existe el concesionario con ID: " + idConcesionario);
                return ERROR;
            }
            nombre     = concesionario.getNombre();
            direccion  = concesionario.getDireccion();
            telefono   = concesionario.getTelefono();
            correo     = concesionario.getCorreo();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al cargar formulario de edición: " + e.getMessage());
            return ERROR;
        }
    }

    public String modificarConcesionario() {
        try {
            Concesionario c = dao.consultarConcesionario(idConcesionario);
            if (c == null) {
                addActionError("No existe el concesionario con ID: " + idConcesionario);
                return INPUT;
            }
            c.setNombre(nombre);
            c.setDireccion(direccion);
            c.setTelefono(telefono);
            c.setCorreo(correo);
            dao.modificarConcesionario(c);
            addActionMessage("Concesionario modificado correctamente");
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al modificar concesionario: " + e.getMessage());
            return INPUT;
        }
    }

    public String eliminarConcesionario() {
        try {
            dao.bajaConcesionario(idConcesionario);
            addActionMessage("Concesionario eliminado correctamente");
            listaConcesionarios = dao.listar();
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Error al eliminar concesionario: " + e.getMessage());
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
        String actionName = ActionContext.getContext().getName();

        if ("registrarConcesionario".equals(actionName) || "modificarConcesionario".equals(actionName)) {
            if (nombre == null || nombre.trim().isEmpty()) {
                addFieldError("nombre", "El nombre es obligatorio");
            } else if (nombre.length() < 2) {
                addFieldError("nombre", "Debe tener al menos 2 caracteres");
            }
            if (direccion == null || direccion.trim().isEmpty()) {
                addFieldError("direccion", "La dirección es obligatoria");
            } else if (direccion.length() < 5) {
                addFieldError("direccion", "Debe tener al menos 5 caracteres");
            }
            if (telefono == null || telefono.trim().isEmpty()) {
                addFieldError("telefono", "El teléfono es obligatorio");
            } else if (!telefono.matches("^[0-9]{9}$")) {
                addFieldError("telefono", "Formato de teléfono inválido (9 dígitos)");
            }
            if (correo == null || correo.trim().isEmpty()) {
                addFieldError("correo", "El correo es obligatorio");
            } else if (!correo.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
                addFieldError("correo", "Formato de correo inválido");
            }
        }
    }

    public Integer getIdConcesionario() { return idConcesionario; }
    public void setIdConcesionario(Integer idConcesionario) { this.idConcesionario = idConcesionario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public List<Concesionario> getListaConcesionarios() { return listaConcesionarios; }
    public Concesionario getConcesionario() { return concesionario; }
}
