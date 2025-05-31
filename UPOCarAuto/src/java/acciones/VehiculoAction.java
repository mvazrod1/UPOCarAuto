/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import modelo.Vehiculo;
import modelo.dao.VehiculoDAO;
import java.math.BigDecimal;
import modelo.Inventario;
import modelo.dao.InventarioDAO;

/**
 *
 * @author maria
 */
public class VehiculoAction extends ActionSupport {

    private final VehiculoDAO dao = new VehiculoDAO();
    private List<Vehiculo> lista;
    private Vehiculo vehiculo;
    private String matricula;
    private Integer idInventario;
    private String marca;
    private String modelo;
    private Integer anio;
    private BigDecimal precio;
    private String estado;
    private boolean disponibilidad;
    

    public VehiculoAction() {
    }

    public String execute() throws Exception {
        lista = dao.listarTodos();

        return SUCCESS;
    }

    public String buscar() throws Exception {
        vehiculo = dao.buscarPorMatricula(matricula);
        lista = new ArrayList<>();
        lista.add(vehiculo);

        return SUCCESS;
    }

    public String consultar() {
        vehiculo = dao.buscarPorMatricula(matricula);

        return SUCCESS;
    }

    public String guardarAlta() {
        vehiculo = new Vehiculo();
        Inventario inv = new Inventario();
        inv.setIdInventario(idInventario);

        vehiculo = new Vehiculo(matricula.trim().toUpperCase(), inv, marca.trim(), modelo.trim(), anio, precio, estado, disponibilidad);
        dao.crear(vehiculo);

        return SUCCESS;
    }

    public String modificar() {
        vehiculo = dao.buscarPorMatricula(matricula);
        idInventario = vehiculo.getInventario().getIdInventario();
        marca = vehiculo.getMarca();
        modelo = vehiculo.getModelo();
        anio = vehiculo.getAnio();
        precio = vehiculo.getPrecio();
        estado = vehiculo.getEstado();
        disponibilidad = vehiculo.isDisponibilidad();
        return SUCCESS;
    }


    public String guardarModificacion() {
        Inventario inv = new Inventario();
        inv.setIdInventario(idInventario);
        Vehiculo v = new Vehiculo(
                matricula.trim().toUpperCase(),
                inv,
                marca.trim(),
                modelo.trim(),
                anio,
                precio,
                estado,
                disponibilidad
        );
        dao.actualizar(v);
        return SUCCESS;
    }


    public String eliminar() {
        if (matricula == null || matricula.trim().isEmpty()) {
            addActionError("Debes seleccionar un vehículo para eliminar");
            return INPUT;
        }
        dao.eliminarPorMatricula(matricula.trim().toUpperCase());
        return SUCCESS;
    }

    @Override
    public void validate() {
        ActionInvocation ai = ActionContext.getContext().getActionInvocation();
        String metodo = ai.getProxy().getMethod();

        if ("guardarAlta".equals(metodo) || "guardarModificacion".equals(metodo)) {

            if (matricula == null || matricula.trim().isEmpty()) {
                addFieldError("matricula", "Matrícula es obligatoria");
            }

            if (idInventario == null ) {
                addFieldError("idInventario", "El id del inventario es obligatorio");
            }
            
            if (marca == null || marca.trim().isEmpty()) {
                addFieldError("marca", "Marca es obligatoria");
            }
            if (modelo == null || modelo.trim().isEmpty()) {
                addFieldError("modelo", "Modelo es obligatorio");
            }

            if (anio == null) {
                addFieldError("anio", "Año es obligatorio");
            } else if (anio < 1900) {
                addFieldError("anio", "Año debe ser ≥ 1900");
            }

            if (precio == null) {
                addFieldError("precio", "Precio es obligatorio");
            } else if (precio.compareTo(BigDecimal.ZERO) <= 0) {
                addFieldError("precio", "Precio debe ser positivo");
            }

            if (estado == null || estado.trim().isEmpty()) {
                addFieldError("estado", "Debes seleccionar un estado");
            }
        }
    }

    public List<Vehiculo> getLista() {
        return lista;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public void setLista(List<Vehiculo> lista) {
        this.lista = lista;
    }

    public void setIdInventario(Integer idInventario) {
        this.idInventario = idInventario;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setDisponibilidad(boolean disponibilidad) {
        this.disponibilidad = disponibilidad;
    }


    public Vehiculo getVehiculo() {
        return vehiculo;
    }    
    

    
    

}
