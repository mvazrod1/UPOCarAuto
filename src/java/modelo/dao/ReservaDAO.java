/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.HibernateUtil;
import modelo.Reserva;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marin
 */
public class ReservaDAO {
    
    Session session = null;

    public ReservaDAO() {
    }
    
    public void altaReserva(Reserva r) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(r);
        tx.commit();
    }

    public void bajaReserva(int idReserva) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from Reserva where idReserva = :idReserva");
        query.setParameter("idReserva", idReserva);
        int result = query.executeUpdate();
        tx.commit();
    }

    public void actualizarReserva(Reserva r) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(r);
        tx.commit();
        System.out.println("Reserva actualizado correctamente");
    }

    public Reserva consultarReserva(int idReserva) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("SELECT r FROM Reserva r " +
                "LEFT JOIN FETCH r.cliente " +
                "LEFT JOIN FETCH r.vehiculo " +
                "LEFT JOIN FETCH r.pagos " +
                "WHERE r.idReserva = :idReserva");
        q.setParameter("idReserva", idReserva);
        Reserva c = (Reserva) q.uniqueResult();
        tx.commit();
        return c;
    }

    public List<Reserva> listarReservas() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("FROM Reserva");
        List<Reserva> listaReservas = q.list();
        tx.commit();
        return listaReservas;
    }
    
}
