<%-- 
    Document   : formAltaCliente
    Created on : 20-may-2025, 19:34:24
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de Alta de Cliente</title>
    </head>
    <body>
        <h2>Formulario de Alta de Cliente</h2>

        <s:form action="/Cliente/registrarCliente" method="post">
            <table>
                <tr>
                    <td>DNI:</td>
                    <td><s:textfield name="dni" /></td>
                    <td><s:fielderror fieldName="dni" /></td>
                </tr>
                <tr>
                    <td>Nombre:</td>
                    <td><s:textfield name="nombre" /></td>
                    <td><s:fielderror fieldName="nombre" /></td>
                </tr>
                <tr>
                    <td>Apellidos:</td>
                    <td><s:textfield name="apellidos" /></td>
                    <td><s:fielderror fieldName="apellidos" /></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><s:textfield name="email" /></td>
                    <td><s:fielderror fieldName="email" /></td>
                </tr>
                <tr>
                    <td>Teléfono:</td>
                    <td><s:textfield name="telefono" /></td>
                    <td><s:fielderror fieldName="telefono" /></td>
                </tr>
                <tr>
                    <td>Dirección:</td>
                    <td><s:textfield name="direccion" /></td>
                    <td><s:fielderror fieldName="direccion" /></td>
                </tr>
            </table>
            <br>
            <s:submit value="Registrar Cliente" />
            <s:reset value="Limpiar" />
        </s:form>

        <br/>
        <s:form action="/Cliente/indexCliente" method="get">
            <button type="submit">Volver a la lista</button>
        </s:form>
    </body>
</html>
