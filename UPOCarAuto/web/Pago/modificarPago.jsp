<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Modificar Pago</title>
    </head>
    <body>

        <h2>Modificar Pago</h2>

        <s:form action="guardarModfPago" method="post">

            <s:hidden name="idPago" />

            <s:textfield name="idReserva"
                         label="ID Reserva"
                         value="%{idReserva}" />

            <s:textfield name="fechaPago"
                         label="Fecha de Pago"
                         value="%{fechaPago}" />

            <s:textfield name="precioTotal"
                         label="Precio Total (€)"
                         value="%{precioTotal}" />

            <s:select name="metodoPago"
                      label="Método de Pago"
                      list="{'Efectivo','Tarjeta','Bizum'}"
                      value="%{metodoPago}" />

            <s:select name="estadoPago"
                      label="Estado"
                      list="{'Pendiente','Pagado','Cancelado'}"
                      value="%{estadoPago}" />

            <br/><br/>
            <s:submit value="Guardar cambios" />
        </s:form>

        <a href="<s:url action='indexPago'/>">Volver</a>

    </body>
</html>
