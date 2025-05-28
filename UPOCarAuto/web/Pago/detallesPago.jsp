<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Detalles del Pago</title>
</head>
<body>

    <h2>Detalles del Pago</h2>

    <table border="1">
        <tr><th>ID del Pago:</th><td><s:property value="pago.idPago" /></td></tr>
        <tr><th>ID de Reserva:</th><td><s:property value="pago.reserva.idReserva" /></td></tr>
        <tr><th>Fecha de Pago:</th><td><s:property value="pago.fechaPago" /></td></tr>
        <tr><th>Precio Total:</th><td><s:property value="pago.precioTotal" /></td></tr>
        <tr><th>Método de Pago:</th><td><s:property value="pago.metodoPago" /></td></tr>
        <tr><th>Estado del Pago:</th><td><s:property value="pago.estadoPago" /></td></tr>
    </table>

    <br><br>

    <form action="indexPago.action" method="get">
        <input type="submit" value="Volver al Listado de Pagos" />
    </form>

</body>
</html>
