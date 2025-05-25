<%-- 
    Document   : formAltaEmpleado
    Created on : 25-may-2025, 13:12:41
    Author     : Javier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<s:form namespace="/Empleado" action="registrarEmpleado" method="post">
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
    <!-- Nuevo select para lista de concesionarios -->
    <div>
        <label for="idConcesionario">Concesionario:</label>
        <s:select name="idConcesionario"
                  id="idConcesionario"
                  list="listaConcesionarios"
                  listKey="idConcesionario"
                  listValue="nombre"
                  headerKey="" headerValue="-- Seleccione --"/>
        <s:fielderror fieldName="idConcesionario"/>
    </div>
    <!-- Contraseña -->
    <div>
        <label for="contrasenya">Contraseña:</label>
        <s:password name="contrasenya" id="contrasenya" theme="simple"/>
        <s:fielderror fieldName="contrasenya"/>
    </div>
    <div style="margin-top:10px;">
        <s:submit value="Registrar Empleado"/>
        <s:reset  value="Limpiar"/>
    </div>
</s:form>

<br/>
<s:form namespace="/Empleado" action="indexEmpleado" method="get">
    <s:submit value="Volver a la lista"/>
</s:form>
</body>