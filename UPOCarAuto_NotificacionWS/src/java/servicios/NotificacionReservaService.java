package servicios;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import modelo.Cliente;
import modelo.Empleado;
import util.EmailSender;

@WebService(serviceName = "NotificacionReservaService")
public class NotificacionReservaService {

    @WebMethod(operationName = "notificarReserva")
    public String notificarReserva(
        @WebParam(name = "nombreCliente") String nombreCliente,
        @WebParam(name = "correoCliente") String correoCliente,
        @WebParam(name = "nombreEmpleado") String nombreEmpleado,
        @WebParam(name = "correoEmpleado") String correoEmpleado,
        @WebParam(name = "detalle") String detalle
    ) {
        try {
            // Usa directamente las clases de tu modelo
            Cliente cliente = new Cliente();
            cliente.setNombre(nombreCliente);
            cliente.setEmail(correoCliente);

            Empleado empleado = new Empleado();
            empleado.setNombre(nombreEmpleado);
            empleado.setEmail(correoEmpleado);

            // Correo al empleado
            String mensajeEmp = "Hola " + empleado.getNombre() + ", nueva reserva de " + cliente.getNombre()
                              + "\nDetalle: " + detalle;
            EmailSender.enviarCorreo(empleado.getEmail(), "Nueva reserva", mensajeEmp);

            // Correo al cliente
            String mensajeCli = "Hola " + cliente.getNombre() + ", tu reserva ha sido confirmada.\nDetalle: " + detalle;
            EmailSender.enviarCorreo(cliente.getEmail(), "Confirmación de reserva", mensajeCli);

            return "Notificaciones enviadas.";

        } catch (Exception e) {
            return "Error al enviar notificaciones: " + e.getMessage();
        }
    }
}
