<%-- 
    Document   : detallesTransaccion
    Created on : 27-may-2025, 20:39:27
    Author     : teodo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de la Transacción</title>
    </head>
    <body>

        <h2>Detalles de la Transacción</h2>

        <table border="1">
            <tr><th>ID Transacción:</th> <td><s:property value="transaccion.idTransaccion"/></td></tr>
            <tr><th>Fecha:</th>          <td><s:date name="transaccion.fechaTransaccion" format="yyyy-MM-dd"/></td></tr>
            <tr><th>Precio (€):</th>     <td><s:property value="transaccion.precio"/></td></tr>
            <tr><th>Método de Pago:</th> <td><s:property value="transaccion.metodoPago"/></td></tr>
            <tr><th>Estado:</th>         <td><s:property value="transaccion.estado"/></td></tr>
        </table>

        <br/><br/>

        <form action="indexTransaccion.action" method="get">
            <input type="submit" value="Volver al Listado de Transacciones"/>
        </form>

    </body>
</html>