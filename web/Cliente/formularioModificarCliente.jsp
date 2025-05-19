<%-- 
    Document   : formularioModificarCliente
    Created on : 19-may-2025, 19:53:46
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modificar Cliente</title>
</head>
<body>
    <h2>Modificar Cliente</h2>
    <s:form action="modificar" method="post">
        <s:hidden name="dni" />
        <s:textfield name="nombre" label="Nombre" />
        <s:textfield name="apellidos" label="Apellidos" />
        <s:textfield name="email" label="Email" />
        <s:textfield name="telefono" label="Teléfono" />
        <s:textfield name="direccion" label="Dirección" />
        <s:submit value="Actualizar" />
    </s:form>
    <a href="listadoClientes.jsp">Volver</a>
</body>
</html>

