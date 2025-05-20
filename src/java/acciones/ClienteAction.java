/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;
import modelo.Cliente;
import modelo.dao.ClienteDAO;

/**
 *
 * @author marin
 */
public class ClienteAction extends ActionSupport {

    private String dni;
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

    public String modificarCliente() {
        cliente = dao.consultarCliente(dni);
        if (cliente != null) {
            cliente.setNombre(nombre);
            cliente.setApellidos(apellidos);
            cliente.setEmail(email);
            cliente.setTelefono(telefono);
            cliente.setDireccion(direccion);
            dao.actualizarCliente(cliente);
        }
        return SUCCESS;
    }

    // Validación
    @Override
    public void validate() {
        String actionName = ActionContext.getContext().getName();

        if (actionName.equals("registrarCliente") || actionName.equals("modificarCliente")) {
            if (this.dni == null || this.dni.trim().isEmpty()) {
                addFieldError("dni", "Introduce el DNI");
            }
            if (this.nombre == null || this.nombre.trim().isEmpty()) {
                addFieldError("nombre", "Introduce el nombre");
            }
            if (this.apellidos == null || this.apellidos.trim().isEmpty()) {
                addFieldError("apellidos", "Introduce los apellidos");
            }
            if (this.email == null || this.email.trim().isEmpty()) {
                addFieldError("email", "Introduce el email");
            }
            if (this.telefono == null || this.telefono.trim().isEmpty()) {
                addFieldError("telefono", "Introduce el teléfono");
            }
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
