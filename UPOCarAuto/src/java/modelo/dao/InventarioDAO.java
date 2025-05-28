/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo.dao;

import java.util.List;
import modelo.Concesionario;
import modelo.Empleado;
import modelo.HibernateUtil;
import modelo.Inventario;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author maria
 */
public class InventarioDAO {

    Session session = null;

    /**
     * Recupera todos los inventarios, incluyendo datos de concesionario,
     * empleado y su colección de vehículos para evitar
     * LazyInitializationException.
     */
    public List<Inventario> listarTodos() {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        // HQL con fetch para traer relaciones en una sola consulta
        Query q = session.createQuery(
                "select distinct i "
                + "from Inventario i "
                + "  join fetch i.concesionario "
                + "  join fetch i.empleado "
                + "  left join fetch i.vehiculos"
        );

        List<Inventario> lista = q.list();

        tx.commit();
        return lista;
    }

    public Inventario buscarPorId(Integer id) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Query q = session.createQuery(
                "select distinct i "
                + "from Inventario i "
                + "     left join fetch i.vehiculos "
                + "where i.idInventario = :id"
        );
        q.setParameter("id", id);

        Inventario inv = (Inventario) q.uniqueResult();
        tx.commit();
        return inv;
    }

    public void crear(Inventario inv) {
        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        session.save(inv);
        tx.commit();

    }

    public void eliminarPorId(Integer idInventario) {
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        // Recupera en esta misma sesión (evitamos abrir otra transacción)
        Inventario inv = (Inventario) session.get(Inventario.class, idInventario);
        if (inv != null) {
            session.delete(inv);
        }

        tx.commit();
    }

    public void actualizar(Inventario inv) {

        session = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Concesionario c = (Concesionario) session.get(
                Concesionario.class,
                inv.getConcesionario().getIdConcesionario());

        Empleado e = (Empleado) session.get(
                Empleado.class,
                inv.getEmpleado().getDni());

        inv.setConcesionario(c);
        inv.setEmpleado(e);

        session.update(inv);
        tx.commit();
    }

    public boolean existeInventarioParaConcesionario(Integer idCon) {
        Session s = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = s.beginTransaction();
        Long n = (Long) s.createQuery(
                "select count(i) from Inventario i "
                + "where i.concesionario.idConcesionario = :id")
                .setParameter("id", idCon)
                .uniqueResult();
        tx.commit();
        return n != null && n > 0;
    }

}
