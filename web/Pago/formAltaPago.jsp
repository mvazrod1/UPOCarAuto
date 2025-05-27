<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Nuevo Pago</title>
    </head>
    <body>

        <s:actionerror />

        <h2>Alta de Pago</h2>

        <s:form action="guardarPago" method="post">
            

            <s:textfield name="idReserva"
                         label="ID Reserva" />

            <s:textfield name="fechaPago"
                         label="Fecha de Pago (dd/MM/yyyy)" />

            <s:textfield name="precioTotal"
                         label="Precio Total (€)" />

            <s:select name="metodoPago"
                      label="Método de Pago"
                      list="{'Efectivo','Tarjeta','Bizum'}" />

            <s:select name="estadoPago"
                      label="Estado del Pago"
                      list="{'Pendiente','Pagado','Cancelado'}" />

            <br/><br/>
            <s:submit value="Guardar" />

        </s:form>

        <a href="<s:url action='indexPago'/>">Volver</a>

    </body>
</html>
