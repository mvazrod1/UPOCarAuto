<%-- 
    Document   : formAltaTransaccion
    Created on : 27-may-2025, 19:52:15
    Author     : teodo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>Alta de Transacción</title>
    </head>
    <body>

        <s:actionerror />
        <s:fielderror />

        <h2>Alta de Transacción</h2>

        <s:form action="guardarTransaccion" method="post">

            <s:textfield name="fechaTransaccion"
                         label="Fecha de Transacción (dd/MM/yyyy)" />

            <s:textfield name="precio"
                         label="Precio (€)" />

            <s:select name="metodoPago"
                      label="Método de Pago"
                      list="{'Tarjeta','Bizum','Transferencia'}" />
            
            <s:select name="estado"
                      label="Estado"
                      list="{'Pendiente','Completada','Cancelada'}" />


            <br/><br/>
            <s:submit value="Guardar" />

        </s:form>

        <br>
        <a href="<s:url action='indexTransaccion'/>">Volver al Listado</a>

    </body>
</html>
