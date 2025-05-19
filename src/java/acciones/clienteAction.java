/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Date;
import java.util.List;
import java.util.Map;
import modelo.Cliente;
import modelo.dao.ClienteDAO;

/**
 *
 * @author marin
 */
public class clienteAction extends ActionSupport{
    
    private String dni;
    private String nombre;
    private String apellidos;
    private String email;
    private String telefono;
    private String direccion;
    private int idCliente;
    
    public clienteAction() {
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

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
    
    //Alta cliente
    public String execute() throws Exception {
        ClienteDAO cdao = new ClienteDAO();
        Date fecha = new Date();

        Cliente c = new Cliente(this.dni, this.nombre, this.apellidos, this.email, this.telefono, this.direccion, fecha);

        cdao.altaCliente(c);
        return SUCCESS;
    }
    
    public String formModificarCliente() {
        Map<String, Object> session = ActionContext.getContext().getSession();
        ClienteDAO cdao = new ClienteDAO();
        Cliente c = cdao.consultarCliente(this.idCliente);
        session.put("clienteModificar", c);
        return SUCCESS;
    }
    
    // Modificar cliente
    public String modificarCliente() throws Exception {
        Map<String, Object> session = ActionContext.getContext().getSession();
        ClienteDAO cdao = new ClienteDAO();
        Cliente c = (Cliente) session.get("clienteModificar");

        c.setDni(this.dni);
        c.setNombre(this.nombre);
        c.setApellidos(this.apellidos);
        c.setEmail(this.email);
        c.setTelefono(this.telefono);
        c.setDireccion(this.direccion);

        cdao.actualizarCliente(c);
        return SUCCESS;
    }
    
    public String eliminarCliente() {
        ClienteDAO cdao = new ClienteDAO();
        Cliente c = cdao.consultarCliente(this.idCliente);
        cdao.bajaCliente(c);
        return SUCCESS;
    }
    
    public String buscarCliente() {
        ClienteDAO cdao = new ClienteDAO();
        List<Cliente> resultados = cdao.buscarCliente(this.dni);
        Map<String, Object> session = ActionContext.getContext().getSession();
        session.put("clientesEncontrados", resultados);
        return SUCCESS;
    }
    
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
    
}
