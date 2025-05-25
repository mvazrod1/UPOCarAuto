<%-- 
    Document   : modificarReserva
    Created on : 25-may-2025, 11:38:52
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Reserva</title>
    </head>
    <body>
        <h1>Modificar Reserva</h1>

        <s:form action="guardarModfReserva" method="post">
            <div>
                <label for="ID">ID:</label>
                <s:textfield name="idReserva" id="idReserva" value="%{reserva.idReserva}" readonly="true" theme="simple"/>
            </div>
            <div>
                <label for="dni_cliente">DNI del Cliente:</label>
                <s:textfield name="dni_cliente" id="dni_cliente" value="%{reserva.cliente.dni}" readonly="true" theme="simple"/>
            </div>
            <div>
                <label for="matricula">Matrícula del Vehículo:</label>
                <s:textfield name="matricula" id="matricula" value="%{reserva.vehiculo.matricula}" readonly="true" theme="simple"/>
            </div>
            <div>
                <s:select name="estado"
                          label="Estado de la Reserva"
                          list="{'Pendiente','Confirmada','Rechazada'}"/>
                <s:fielderror fieldName="estado"/>
            </div>
            <div>
                <label for="fecha_recogida">Fecha de recogida:</label>
                <s:textfield name="fecha_recogida" id="fecha_recogida" type="date" theme="simple"/>
                <s:fielderror fieldName="fecha_recogida"/>
            </div>
            <div>
                <s:submit value="Guardar Cambios"/>
                <br>
            </div>

            <s:actionerror/>
        </s:form>
        <input type="button" value="Cancelar" onclick="window.location.href = '<s:url action='indexReserva'/>'"/>
    </body>
</html>
