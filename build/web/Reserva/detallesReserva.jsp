<%-- 
    Document   : detallesReserva
    Created on : 24-may-2025, 2:21:10
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles Reserva</title>
    </head>
    <body>
        <div class="detalle-reserva">
            <h2>Detalles del Reserva</h2>

            <div>
                <label>ID Reserva:</label>
                <span><s:property value="reserva.idReserva"/></span>
            </div>
            <div>
                <label>DNI Cliente:</label>
                <span><s:property value="reserva.cliente.dni"/></span>
            </div>
            <div>
                <label>Matricula:</label>
                <span><s:property value="reserva.vehiculo.matricula"/></span>
            </div>
            <div>
                <label>Estado:</label>
                <span><s:property value="reserva.estado"/></span>
            </div>
            <div>
                <label>Fecha Creación:</label>
                <span><s:property value="reserva.fechaCreacion"/></span>
            </div>
            <div>
                <label>Fecha Recogida:</label>
                <span><s:property value="reserva.fechaRecogida"/></span>
            </div>
        </div>

        <div>
            <h3>Pagos</h3>
            <s:if test="!reserva.pagos.isEmpty()">
                <table border="1">
                    <tr>
                        <th>ID Pago</th>
                        <th>Precio</th>
                        <th>Fecha de Pago</th>
                        <th>Método de Pago</th>
                        <th>Estado de Pago</th>
                    </tr>
                    <s:iterator value="reserva.pagos" var="pago">
                        <tr>
                            <td><s:property value="#pago.idPago" /></td>
                            <td><s:property value="#pago.precioTotal" /></td>
                            <td><s:property value="#pago.fechaPago" /></td>
                            <td><s:property value="#pago.metodoPago" /></td>
                            <td><s:property value="#pago.estadoPago" /></td>
                        </tr>
                    </s:iterator>
                </table>
            </s:if>
            <s:else>
                <p>No hay pagos registrados para esta reserva.</p>
            </s:else>
        </div>
        <br>
        <s:form action="/Reserva/indexReserva" method="get">
            <button type="submit">Volver a la lista</button>
        </s:form>
    </body>
</html>

