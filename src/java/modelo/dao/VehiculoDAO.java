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
        Query q = session.createQuery("select distinct v "
                + "from Vehiculo v left join fetch v.reservas");

        lista = q.list();
        tx.commit();
        return lista;
    }

    public Vehiculo buscarPorMatricula(String m) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Vehiculo v;
        Query q = session.createQuery("select distinct v "
                + "from Vehiculo v left join fetch v.reservas where v.matricula = '" + m + "'");

        v = (Vehiculo) q.uniqueResult();
        tx.commit();
        return v;
    }

    public void crear(Vehiculo v) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(v);
        tx.commit();

    }

    public void actualizar(Vehiculo v) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(v);
        tx.commit();
    }

    public void eliminarPorMatricula(String matricula) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        // Recupera directamente en esta sesión, SIN llamar a otro método que abra tx:
        Vehiculo v = (Vehiculo) session.get(Vehiculo.class, matricula.trim().toUpperCase());
        if (v != null) {
            session.delete(v);
        }
        tx.commit();
    }

    public List<Vehiculo> listarVehiculosDisponibles() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("FROM Vehiculo v WHERE v.disponibilidad = true");
        List<Vehiculo> listaVehiculos = q.list();
        tx.commit();
        return listaVehiculos;
    }
}
