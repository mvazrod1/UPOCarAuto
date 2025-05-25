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

        <s:form action="/Reserva/registrarReserva" method="post">
            <div>
                <label for="dni_cliente">DNI del Cliente:</label>
                <s:textfield name="dni_cliente" id="dni_cliente" theme="simple"/>
                <s:fielderror fieldName="dni_cliente"/>
            </div>
            <div>
                <label for="matricula">Matricula del vehículo:</label>
                <s:textfield name="matricula" id="matricula" theme="simple"/>
                <s:fielderror fieldName="matricula"/>
            </div>
            <div>
                <label for="estado">Estado de la reserva:</label>
                <s:textfield name="estado" id="estado" theme="simple"/>
                <s:fielderror fieldName="estado"/>
            </div>
            <div>
                <label for="fechaRecogida">Fecha de recogida:</label>
                <s:textfield name="fechaRecogida" id="fechaRecogida" />
                <small>Formato: yyyy-MM-dd</small>
            </div>

            <br/>
            <div>
                <s:submit value="Registrar Reserva"/>
                <s:reset value="Limpiar"/>
            </div>
        </s:form>



        <br/>
        <s:form action="/Reserva/indexReserva" method="get">
            <button type="submit">Volver a la lista</button>
        </s:form>
    </body>
</html>


