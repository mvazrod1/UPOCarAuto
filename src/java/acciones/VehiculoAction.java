/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package acciones;

import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import modelo.Vehiculo;
import modelo.dao.VehiculoDAO;

/**
 *
 * @author maria
 */
public class VehiculoAction extends ActionSupport {
    private VehiculoDAO dao = new VehiculoDAO();
    private List<Vehiculo> lista;
    
    public VehiculoAction() {
    }
    
    public String execute() throws Exception {
        lista = dao.listarTodos();
        
        return SUCCESS;
    }

    public List<Vehiculo> getLista() {
        return lista;
    }
    
}
