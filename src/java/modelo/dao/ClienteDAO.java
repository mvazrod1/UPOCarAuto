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

    public void bajaCliente(Cliente c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.delete(c);
        tx.commit();
    }

    public void actualizarCliente(Cliente c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(c);
        tx.commit();
    }

    public Cliente consultarCliente(String dni) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("FROM Cliente WHERE dni = :dni");
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
