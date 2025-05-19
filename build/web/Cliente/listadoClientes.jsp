<%-- 
    Document   : listadoClientes
    Created on : 19-may-2025, 19:53:15
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html>
<html>
<head>
    <title>Listado de Clientes</title>
</head>
<body>
    <h2>Clientes</h2>

    <s:form action="buscarCliente" method="post">
        <s:textfield name="terminoBusqueda" label="Buscar por DNI" />
        <s:submit value="Buscar" />
    </s:form>

    <table border="1">
        <tr>
            <th>DNI</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Email</th>
            <th>Teléfono</th>
            <th>Dirección</th>
            <th>Fecha Registro</th>
            <th>Acciones</th>
        </tr>
        <s:iterator value="#session.listaClientes" var="cliente">
            <tr>
                <td><s:property value="#cliente.dni" /></td>
                <td><s:property value="#cliente.nombre" /></td>
                <td><s:property value="#cliente.apellidos" /></td>
                <td><s:property value="#cliente.email" /></td>
                <td><s:property value="#cliente.telefono" /></td>
                <td><s:property value="#cliente.direccion" /></td>
                <td><s:date name="#cliente.fechaRegistro" format="yyyy-MM-dd" /></td>
                <td>
                    <s:url id="modUrl" action="formModificar">
                        <s:param name="dni" value="#cliente.dni" />
                    </s:url>
                    <s:a href="%{modUrl}">Modificar</s:a>

                    <s:url id="delUrl" action="eliminar">
                        <s:param name="dni" value="#cliente.dni" />
                    </s:url>
                    <s:a href="%{delUrl}">Eliminar</s:a>
                </td>
            </tr>
        </s:iterator>
    </table>

    <a href="formularioCliente.jsp">Registrar nuevo cliente</a>
</body>
</html>

