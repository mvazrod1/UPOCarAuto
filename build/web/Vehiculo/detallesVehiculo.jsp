<%-- 
    Document   : detallesVehiculo
    Created on : 23-may-2025, 17:55:12
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de Vehículo</title>
    </head>
    <body>

        <s:actionerror/><br/>

        <s:if test="vehiculo != null">
            <table border="1" cellpadding="5">
                <tr>
                    <th>Matrícula</th>
                    <th>Inventario (ID)</th>
                    <th>Marca</th>
                    <th>Modelo</th>
                    <th>Año</th>
                    <th>Precio (€)</th>
                    <th>Estado</th>
                    <th>Disponible</th>
                    <th>Reservas (nº)</th>
                </tr>
                <tr>
                    <td><s:property value="vehiculo.matricula"/></td>
                    <td><s:property value="vehiculo.inventario.idInventario"/></td>
                    <td><s:property value="vehiculo.marca"/></td>
                    <td><s:property value="vehiculo.modelo"/></td>
                    <td><s:property value="vehiculo.anio"/></td>
                    <td><s:property value="vehiculo.precio"/></td>
                    <td><s:property value="vehiculo.estado"/></td>
                    <td><s:property value="vehiculo.disponibilidad ? 'Sí' : 'No'"/></td>
                    <td>
                        <s:property value="
                                    vehiculo.reservas != null 
                                    ? vehiculo.reservas.size 
                                    : 0"/>
                    </td>
                </tr>
            </table>
        </s:if>

        <br/>
        <!-- Botón para volver al listado -->
        <a href="<s:url action='indexVehiculo'/>">← Volver al listado</a>

    </body>
</html>

