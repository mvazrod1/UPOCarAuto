<%-- 
    Document   : indexVehiculo
    Created on : 22-may-2025, 20:12:10
    Author     : maria
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1" cellpadding="5">
            <tr>
                <th>Matrícula</th>
                <th>Inventario&nbsp;(ID)</th>
                <th>Marca</th>
                <th>Modelo</th>
                <th>Año</th>
                <th>Precio&nbsp;€</th>
                <th>Estado</th>
                <th>Disponible</th>
                <th>Reservas&nbsp;(nº)</th>
            </tr>

            <!-- var SIN #  -->
            <s:iterator value="lista" var="vehiculo">
                <tr>
                    <td><s:property value="#vehiculo.matricula"/></td>

                    <td>
                        <s:property value="#vehiculo.inventario.idInventario"/>
                    </td>
                    <td><s:property value="#vehiculo.marca"/></td>
                    <td><s:property value="#vehiculo.modelo"/></td>
                    <td><s:property value="#vehiculo.anio"/></td>
                    <td><s:property value="#vehiculo.precio"/></td>
                    <td><s:property value="#vehiculo.estado"/></td>
                    <td><s:property value="#vehiculo.disponibilidad ? 'Sí' : 'No'"/></td>
                    <td><s:property value="#vehiculo.reservas != null ?
                                #vehiculo.reservas.size : 0"/></td>
                </tr>
            </s:iterator>
        </table>
    </body>
</html>
