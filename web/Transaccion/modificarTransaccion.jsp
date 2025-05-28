<%-- 
    Document   : modificarTransaccion
    Created on : 27-may-2025, 19:52:38
    Author     : teodo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Modificar Transacción</title>
    </head>
    <body>

    <s:actionerror />
    <s:fielderror />

    <h2>Modificar Transacción</h2>

    <s:form action="guardarModfTransaccion" method="post">

        <s:hidden name="idTransaccion" />

        <s:textfield name="fechaTransaccion"
                     label="Fecha de Transacción (dd/MM/yyyy)" />

        <s:textfield name="precio"
                     label="Precio (€)" />

        <s:select name="metodoPago"
                  label="Método de Pago"
                  list="{'Efectivo','Tarjeta','Bizum','Transferencia'}" />

        <s:select name="estado"
                  label="Estado"
                  list="{'Pendiente','Completado','Fallido'}" />

        <br/><br/>
        <s:submit value="Guardar Cambios" />

    </s:form>

    <br>
    <a href="<s:url action='indexTransaccion'/>">Volver al Listado</a>

</body>
</html>

