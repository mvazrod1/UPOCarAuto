<%-- 
    Document   : formAltaReserva
    Created on : 24-may-2025, 2:39:01
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de Alta de Reserva</title>
    </head>
    <body>
        <h2>Formulario de Alta de Reserva</h2>

        <s:form action="registrarReserva" namespace="/Reserva" method="post">
            <div>
                <label for="dni_cliente">DNI del Cliente:</label>
                <s:select name="dni_cliente" id="dni_cliente"
                          list="listaDnis" listKey="dni" listValue="dni"
                          headerKey="" headerValue="-- Selecciona un cliente --" theme="simple"/>
                <s:fielderror fieldName="dni_cliente"/>
            </div>
            <div>
                <label for="matricula">Matrícula del Vehículo:</label>
                <s:select name="matricula" id="matricula"
                          list="listaMatriculas" listKey="matricula" listValue="matricula"
                          headerKey="" headerValue="-- Selecciona un vehículo --" theme="simple"/>
                <s:fielderror fieldName="matricula"/>
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

            <br/>
            <div>
                <s:submit value="Registrar Reserva"/>
            </div>
        </s:form>
        <s:form action="altaReserva" namespace="/Reserva" method="get">
            <button type="submit">Limpiar</button>
        </s:form>
        <br/>
        <s:form action="indexReserva" namespace="/Reserva" method="get">
            <button type="submit">Volver a la lista</button>
        </s:form>
    </body>
</html>


