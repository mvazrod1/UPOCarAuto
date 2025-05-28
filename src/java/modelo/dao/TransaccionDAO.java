/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;
import java.util.List;
import modelo.HibernateUtil;
import modelo.Transaccion;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class TransaccionDAO {

    private Session session = null;   

  
    public List<Transaccion> listarTodas() {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        
        Query q = session.createQuery(
                "select distinct t "
                + "from Transaccion t "
                + "left join fetch t.pagos");
        List<Transaccion> lista = q.list();

        tx.commit();
        return lista;
    }

    public Transaccion buscarPorId(Integer id) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Transaccion t = (Transaccion) session.get(Transaccion.class, id);

        tx.commit();
        return t;
    }

    public void crear(Transaccion t) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        session.save(t);      // idTransaccion autogenerado
        tx.commit();
    }

    public void actualizar(Transaccion t) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        session.update(t);    // t debe tener idTransaccion no-nulo
        tx.commit();
    }

    public void eliminarPorId(Integer id) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Transaccion t = (Transaccion) session.get(Transaccion.class, id);
        if (t != null) {
            session.delete(t);
        }
        tx.commit();
    }

    public List<Transaccion> listarPendientes() {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Query q = session.createQuery(
                "from Transaccion t where t.estado = 'Pendiente'");
        List<Transaccion> lista = q.list();

        tx.commit();
        return lista;
    }
}
