<%-- 
    Document   : principal
    Created on : 20-may-2025, 19:29:08
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página principal</title>
    </head>
    <body>
        <h1>Página principal</h1>
        <h2>Elige la acción deseada<h2>
        <s:form action="/Cliente/indexCliente" method="post"> 
            <s:submit value="Gestión de clientes" />
        </s:form>
        <s:form action="/Vehiculo/indexVehiculo" method="post"> 
            <s:submit value="Gestión de vehículos" />
        </s:form>
    </body>
</html>
