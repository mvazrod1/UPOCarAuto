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
            <br>
            <s:form action="/Reserva/indexReserva" method="get">
                <button type="submit">Volver a la lista</button>
            </s:form>
        </div>
    </body>
</html>

