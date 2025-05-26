<%-- 
    Document   : registro
    Created on : 26-may-2025, 13:13:50
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Registro de Empleado</title>
    </head>
    <body>

        <h2>Registro de nuevo empleado</h2>

        <s:form action="registrar" method="post">
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

            <div>
                <label for="puesto">Puesto:</label>
                <s:textfield name="puesto" id="puesto" theme="simple"/>
                <s:fielderror fieldName="puesto"/>
            </div>

            <div>
                <label for="idConcesionario">Concesionario:</label>
                <s:select name="idConcesionario"
                          id="idConcesionario"
                          list="listaConcesionarios"
                          listKey="idConcesionario"
                          listValue="nombre"
                          headerKey="" headerValue="-- Seleccione --" theme="simple"/>
                <s:fielderror fieldName="idConcesionario"/>
            </div>

            <div>
                <label for="contrasenya">Contraseña:</label>
                <s:password name="contrasenya" id="contrasenya" theme="simple"/>
                <s:fielderror fieldName="contrasenya"/>
            </div>

            <div style="margin-top:10px;">
                <s:submit value="Registrar Empleado"/>
                <s:reset value="Limpiar"/>
            </div>
        </s:form>

        <br/>

        <s:form action="volverInicio">
            <s:submit value="Volver al inicio"/>
        </s:form>

    </body>
</html>

