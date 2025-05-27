package modelo.dao;

import java.util.List;
import modelo.HibernateUtil;
import modelo.Pago;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class PagoDAO {

    Session session = null;

    public List<Pago> listarPagos() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        List<Pago> lista = session.createQuery("from Pago").list();
        tx.commit();
        return lista;
    }

    public Pago consultarPago(int idPago) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Pago pago = (Pago) session.get(Pago.class, idPago);
        tx.commit();
        return pago;
    }

    public void crearPago(Pago p) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(p);
        tx.commit();
    }

    public void actualizarPago(Pago p) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.update(p);
        tx.commit();
    }

    public void bajaPago(int idPago) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        Pago pago = (Pago) session.get(Pago.class, idPago);
        if (pago != null) {
            session.delete(pago);
        }
        tx.commit();
    }
}
