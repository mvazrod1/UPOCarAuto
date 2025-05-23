/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.HibernateUtil;
import modelo.Vehiculo;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author maria
 */
public class VehiculoDAO {

    Session session = null;


    public List<Vehiculo> listarTodos() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        List<Vehiculo> lista;
        Query q = session.createQuery("select distinct v " +
            "from Vehiculo v left join fetch v.reservas");
        
        lista = q.list();
        tx.commit();
        return lista;
    }
    
    public Vehiculo buscarPorMatricula(String m) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Vehiculo v;
        Query q = session.createQuery("select distinct v " +
                "from Vehiculo v left join fetch v.reservas where v.matricula = '" + m +"'");
        
        v = (Vehiculo) q.uniqueResult();
        tx.commit();
        return v;
    }


}
