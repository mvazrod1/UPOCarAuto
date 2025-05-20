<%-- 
    Document   : consultarCliente
    Created on : 20-may-2025, 12:08:24
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detllas Cliente</title>
    </head>
    <body>
        <div class="detalle-cliente">
            <h2>Detalles del Cliente</h2>

            <div>
                <label>DNI:</label>
                <span><s:property value="cliente.dni"/></span>
            </div>
            <div>
                <label>Nombre:</label>
                <span><s:property value="cliente.nombre"/></span>
            </div>
            <div>
                <label>Apellidos:</label>
                <span><s:property value="cliente.apellidos"/></span>
            </div>
            <div>
                <label>Email:</label>
                <span><s:property value="cliente.email"/></span>
            </div>
            <div>
                <label>Teléfono:</label>
                <span><s:property value="cliente.telefono"/></span>
            </div>
            <div>
                <label>Dirección:</label>
                <span><s:property value="cliente.direccion"/></span>
            </div>

            <s:form action="/Cliente/indexCliente" method="get">
                <button type="submit">Volver a la lista</button>
            </s:form>
        </div>
    </body>
</html>
