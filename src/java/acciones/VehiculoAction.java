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

/**
 *
 * @author maria
 */
public class VehiculoAction extends ActionSupport {

    private final VehiculoDAO dao = new VehiculoDAO();
    private List<Vehiculo> lista;
    private Vehiculo vehiculo;
    private String matricula;
    private static final Pattern MATRICULA_ES
            = Pattern.compile("^[0-9]{4}[A-HJ-NP-TV-Z]{3}$");
    ActionInvocation ai
            = ActionContext.getContext().getActionInvocation();
    String metodo = ai.getProxy().getMethod();

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

    @Override
    public void validate() {
        if ("buscar".equals(metodo)) {
            if (matricula == null || matricula.trim().isEmpty()) {
                addFieldError("matricula", "Debe introducir una matrícula");
            } else if (!MATRICULA_ES.matcher(matricula.trim().toUpperCase()).matches()) {
                addFieldError("matricula", "Formato de matrícula no válido (####ABC)");
            }
        }

        if ("consultar".equals(metodo)) {
            if (matricula == null || matricula.trim().isEmpty()) {
                addFieldError("matricula", "Debes seleccionar un vehículo");
            }
        }

    }

    public List<Vehiculo> getLista() {
        return lista;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public Vehiculo getVehiculo() {
        return vehiculo;
    }
    
    

}
