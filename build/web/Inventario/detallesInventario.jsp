<%-- 
    Document   : detallesInventario
    Created on : 26-may-2025, 19:17:18
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de Inventario</title>
    </head>
    <body>

        <s:actionerror/><br/>

        <s:if test="inventario != null">
            <table border="1" cellpadding="5">
                <tr>
                    <th>ID Inventario</th>
                    <th>ID Concesionario</th>
                    <th>DNI Empleado</th>
                    <th>Total Vehículos</th>
                    <th>Última Actualización</th>
                </tr>
                <tr>
                    <td><s:property value="inventario.idInventario"/></td>
                    <td><s:property value="inventario.concesionario.idConcesionario"/></td>
                    <td><s:property value="inventario.empleado.dni"/></td>
                    <td><s:property value="inventario.totalVehiculos"/></td>
                    <td><s:property value="inventario.ultimaActualizacion"/></td>
                </tr>
            </table>
        </s:if>

        <br/>
        <!-- Botón para volver al listado de inventarios -->
        <a href="<s:url action='indexInventario' namespace='/Inventario'/>">Volver</a>

    </body>
</html>

