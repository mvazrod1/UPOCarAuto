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
        <div>
            <label for="dni">DNI:</label>
            <s:textfield name="dni" id="dni" value="%{cliente.dni}" readonly="true" theme="simple"/>
            <s:fielderror fieldName="dni"/>
        </div>
        <div>
            <label for="nombre">Nombre:</label>
            <s:textfield name="nombre" id="nombre" value="%{cliente.nombre}" theme="simple"/>
            <s:fielderror fieldName="nombre"/>
        </div>
        <div>
            <label for="apellidos">Apellidos:</label>
            <s:textfield name="apellidos" id="apellidos" value="%{cliente.apellidos}" theme="simple"/>
            <s:fielderror fieldName="apellidos"/>
        </div>
        <div>
            <label for="email">Email:</label>
            <s:textfield name="email" id="email" value="%{cliente.email}" theme="simple"/>
            <s:fielderror fieldName="email"/>
        </div>
        <div>
            <label for="telefono">Teléfono:</label>
            <s:textfield name="telefono" id="telefono" value="%{cliente.telefono}" theme="simple"/>
            <s:fielderror fieldName="telefono"/>
        </div>
        <div>
            <label for="direccion">Dirección:</label>
            <s:textfield name="direccion" id="direccion" value="%{cliente.direccion}" theme="simple"/>
            <s:fielderror fieldName="direccion"/>
        </div>
        <div>
            <s:submit value="Guardar Cambios"/>
            <br>
            <input type="button" value="Cancelar" onclick="window.location.href = '<s:url action='indexCliente'/>'"/>
        </div>

        <s:actionerror/>
    </s:form>
</body>
</html>


