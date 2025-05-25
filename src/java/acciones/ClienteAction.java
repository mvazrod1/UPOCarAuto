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
import java.util.List;
import modelo.Cliente;
import modelo.dao.ClienteDAO;

/**
 *
 * @author marin
 */
public class ClienteAction extends ActionSupport {

    private String dni;
    private String matricula;
    private String nombre;
    private String apellidos;
    private String email;
    private String telefono;
    private String direccion;

    private List<Cliente> listaClientes;
    private Cliente cliente;

    private ClienteDAO dao = new ClienteDAO();

    @Override
    public String execute() {
        listaClientes = dao.listarClientes();
        return SUCCESS;
    }

    public String eliminarCliente() {
        dao.bajaCliente(dni);
        return SUCCESS;
    }
    
    public String buscar() throws Exception {
        cliente = dao.consultarCliente(dni);
        listaClientes = new ArrayList<>();
        
        if (cliente == null) {
            addActionMessage("El clienre con dni " + dni + " no existe.");
            return INPUT;
        }
        
        listaClientes.add(cliente);

        return SUCCESS;
    }

    public String consultarCliente() {
        cliente = dao.consultarCliente(dni);
        return SUCCESS;
    }

    public String mostrarAltaClienteForm() {
        return SUCCESS;
    }

    public String registrarCliente() {
        cliente = new Cliente(dni, nombre, apellidos, email, telefono, direccion, new java.util.Date());
        dao.altaCliente(cliente);
        return SUCCESS;
    }

    public String mostrarModificarClienteForm() {
        cliente = dao.consultarCliente(dni);
        return SUCCESS;
    }

    public String modificarCliente() {
        Cliente c = new Cliente(dni, nombre, apellidos, email, telefono, direccion, new java.util.Date());
        dao.actualizarCliente(c);
        return SUCCESS;
    }

    @Override
    public void validate() {
        String actionName = ActionContext.getContext().getName();

        if (actionName.equals("registrarCliente") || actionName.equals("modificarCliente")) {

            // DNI
            if (this.dni == null || this.dni.trim().isEmpty()) {
                addFieldError("dni", "Introduce el DNI");
            } else if (!this.dni.matches("^[0-9]{8}[A-Za-z]$")) {
                addFieldError("dni", "El DNI debe tener 8 números seguidos de una letra");
            }

            // Nombre
            if (this.nombre == null || this.nombre.trim().isEmpty()) {
                addFieldError("nombre", "Introduce el nombre");
            }

            // Apellidos
            if (this.apellidos == null || this.apellidos.trim().isEmpty()) {
                addFieldError("apellidos", "Introduce los apellidos");
            }

            // Email
            if (this.email == null || this.email.trim().isEmpty()) {
                addFieldError("email", "Introduce el email");
            } else if (!this.email.matches("^[\\w\\.-]+@[\\w\\.-]+\\.[a-zA-Z]{2,6}$")) {
                addFieldError("email", "Introduce un email válido");
            }

            // Teléfono
            if (this.telefono == null || this.telefono.trim().isEmpty()) {
                addFieldError("telefono", "Introduce el teléfono");
            } else if (!this.telefono.matches("^[0-9]{9}$")) {
                addFieldError("telefono", "El teléfono debe tener exactamente 9 dígitos");
            }

            // Dirección
            if (this.direccion == null || this.direccion.trim().isEmpty()) {
                addFieldError("direccion", "Introduce la dirección");
            }
        }
    }

    // Getters y Setters necesarios para que funcione con Struts2
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

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
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

    public List<Cliente> getListaClientes() {
        return listaClientes;
    }

    public void setListaClientes(List<Cliente> listaClientes) {
        this.listaClientes = listaClientes;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

}
