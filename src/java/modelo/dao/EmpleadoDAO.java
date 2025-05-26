/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.Empleado;
import modelo.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Javier
 */
public class EmpleadoDAO {

    Session session = null;

    public EmpleadoDAO() {
    }

    public void altaEmpleado(Empleado e) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(e);
        tx.commit();
    }

    public void bajaEmpleado(String dni) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from Empleado where dni = :dni");
        query.setParameter("dni", dni);
        int result = query.executeUpdate();
        tx.commit();
    }

    public void modificarEmpleado(Empleado e) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(e);
        tx.commit();
        System.out.println("Empleado actualizado correctamente");
    }

    public Empleado consultarEmpleado(String dni) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery(
                "select e from Empleado e "
                + " left join fetch e.concesionario "
                + " where e.dni = :dni"
        );
        q.setParameter("dni", dni);
        Empleado emp = (Empleado) q.uniqueResult();
        tx.commit();
        return emp;
    }

    public Empleado buscarPorDni(String dni) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Empleado e;
        Query q = session.createQuery("select distinct e "
                + "from Empleado e left join fetch e.inventarios where e.dni = '" + dni + "'");

        e = (Empleado) q.uniqueResult();
        tx.commit();
        return e;
    }

    public List<Empleado> listarEmpleados() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("FROM Empleado");
        List<Empleado> lista = q.list();
        tx.commit();
        return lista;
    }
}
