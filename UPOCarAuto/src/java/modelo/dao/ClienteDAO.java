/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.Cliente;
import modelo.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author marin
 */
public class ClienteDAO {

    Session session = null;

    public ClienteDAO() {
    }

    public void altaCliente(Cliente c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(c);
        tx.commit();
    }

    public void bajaCliente(String dni) throws Exception {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            Long reservasRelacionadas = (Long) session.createQuery(
                    "select count(r) from Reserva r where r.cliente.dni = :dni")
                    .setParameter("dni", dni)
                    .uniqueResult();

            if (reservasRelacionadas != null && reservasRelacionadas > 0) {
                throw new Exception("No es posible borrar el cliente porque tiene reservas relacionadas.");
            }

            // Si no tiene reservas, borrar el cliente
            Query query = session.createQuery("delete from Cliente where dni = :dni");
            query.setParameter("dni", dni);
            query.executeUpdate();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public void actualizarCliente(Cliente c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(c);
        tx.commit();
        System.out.println("Cliente actualizado correctamente");
    }

    public Cliente consultarCliente(String dni) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery(
                "SELECT DISTINCT c FROM Cliente c "
                + "LEFT JOIN FETCH c.reservas r "
                + "LEFT JOIN FETCH r.vehiculo "
                + "WHERE c.dni = :dni"
        );
        q.setParameter("dni", dni);
        Cliente c = (Cliente) q.uniqueResult();
        tx.commit();
        return c;
    }

    public List<Cliente> listarClientes() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("FROM Cliente");
        List<Cliente> lista = q.list();
        tx.commit();
        return lista;
    }

}
