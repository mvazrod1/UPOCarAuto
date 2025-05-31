package servicios;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

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
            // Simulación de notificación ficticia

            System.out.println("[SIMULACIÓN] Enviando notificación al EMPLEADO:");
            System.out.println("Para: " + correoEmpleado);
            System.out.println("Asunto: Nueva reserva");
            System.out.println("Mensaje: Hola " + nombreEmpleado + ", nueva reserva de " + nombreCliente);
            System.out.println("Detalle: " + detalle);
            System.out.println("--------------------------------------------------");

            System.out.println("[SIMULACIÓN] Enviando notificación al CLIENTE:");
            System.out.println("Para: " + correoCliente);
            System.out.println("Asunto: Confirmación de reserva");
            System.out.println("Mensaje: Hola " + nombreCliente + ", tu reserva fue confirmada.");
            System.out.println("Detalle: " + detalle);
            System.out.println("==================================================");

            return "Notificaciones simuladas correctamente.";

        } catch (Exception e) {
            return "Error en simulación de notificaciones: " + e.getMessage();
        }
    }
}
