<%-- 
    Document   : modificarCliente
    Created on : 20-may-2025, 22:28:14
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Cliente</title>
    </head>
    <body>
        <h1>Modificar Cliente</h1>
        <s:form action="guardarModfCliente" method="post">
            <table>
                <tr>
                    <td><label for="dni">DNI:</label></td>
                    <td>
                        <s:textfield name="dni" id="dni" value="%{cliente.dni}" readonly="true" />
                    </td>
                </tr>
                <tr>
                    <td><label for="nombre">Nombre:</label></td>
                    <td><s:textfield name="nombre" id="nombre" value="%{cliente.nombre}" /></td>
                </tr>
                <tr>
                    <td><label for="apellidos">Apellidos:</label></td>
                    <td><s:textfield name="apellidos" id="apellidos" value="%{cliente.apellidos}" /></td>
                </tr>
                <tr>
                    <td><label for="email">Email:</label></td>
                    <td><s:textfield name="email" id="email" value="%{cliente.email}" /></td>
                </tr>
                <tr>
                    <td><label for="telefono">Teléfono:</label></td>
                    <td><s:textfield name="telefono" id="telefono" value="%{cliente.telefono}" /></td>
                </tr>
                <tr>
                    <td><label for="direccion">Dirección:</label></td>
                    <td><s:textfield name="direccion" id="direccion" value="%{cliente.direccion}" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <s:submit value="Guardar Cambios" />
                        <input type="button" value="Cancelar" onclick="window.location.href = '<s:url action='indexCliente'/>'" />
                    </td>
                </tr>
            </table>
            <s:actionerror />
            <s:fielderror />
        </s:form>
    </body>
</html>
