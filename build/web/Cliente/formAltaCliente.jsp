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
            <div>
                <label for="dni">DNI:</label>
                <s:textfield name="dni" id="dni" theme="simple"/>
                <s:fielderror fieldName="dni"/>
            </div>
            <div>
                <label for="nombre">Nombre:</label>
                <s:textfield name="nombre" id="nombre" theme="simple"/>
                <s:fielderror fieldName="nombre"/>
            </div>
            <div>
                <label for="apellidos">Apellidos:</label>
                <s:textfield name="apellidos" id="apellidos" theme="simple"/>
                <s:fielderror fieldName="apellidos"/>
            </div>
            <div>
                <label for="email">Email:</label>
                <s:textfield name="email" id="email" theme="simple"/>
                <s:fielderror fieldName="email"/>
            </div>
            <div>
                <label for="telefono">Teléfono:</label>
                <s:textfield name="telefono" id="telefono" theme="simple"/>
                <s:fielderror fieldName="telefono"/>
            </div>
            <div>
                <label for="direccion">Dirección:</label>
                <s:textfield name="direccion" id="direccion" theme="simple"/>
                <s:fielderror fieldName="direccion"/>
            </div>

            <br/>
            <div>
                <s:submit value="Registrar Cliente"/>
                <s:reset value="Limpiar"/>
            </div>
        </s:form>



        <br/>
        <s:form action="/Cliente/indexCliente" method="get">
            <button type="submit">Volver a la lista</button>
        </s:form>
    </body>
</html>

