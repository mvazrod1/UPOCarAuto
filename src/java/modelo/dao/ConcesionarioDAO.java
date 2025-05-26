/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.Concesionario;
import modelo.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Javier
 */
public class ConcesionarioDAO {

    private Session session;

    public ConcesionarioDAO() {
    }

    public void altaConcesionario(Concesionario c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(c);
        tx.commit();
    }

    public void bajaConcesionario(Integer id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query query = session.createQuery("delete from Concesionario where idConcesionario = :id");
        query.setParameter("id", id);
        query.executeUpdate();
        tx.commit();
    }

    public void modificarConcesionario(Concesionario c) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(c);
        tx.commit();
    }

    public Concesionario consultarConcesionario(Integer id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("from Concesionario where idConcesionario = :id");
        q.setParameter("id", id);
        Concesionario c = (Concesionario) q.uniqueResult();
        tx.commit();
        return c;
    }

    public List<Concesionario> listar() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Query q = session.createQuery("from Concesionario");
        List<Concesionario> lista = q.list();
        tx.commit();
        return lista;
    }
}
