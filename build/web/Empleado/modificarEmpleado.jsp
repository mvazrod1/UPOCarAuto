<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modificar Empleado</title>
</head>
<body>
    <h1>Modificar Empleado</h1>

    <!-- Generar URL para volver al listado -->
    <s:url var="urlIndex" namespace="/Empleado" action="indexEmpleado"/>

    <s:form namespace="/Empleado"
            action="guardarModfEmpleado"
            method="post">
        <!-- DNI (no modificable) -->
        <div>
            <label for="dni">DNI:</label>
            <s:textfield name="dni"
                         id="dni"
                         value="%{empleado.dni}"
                         readonly="true"
                         theme="simple"/>
            <s:fielderror fieldName="dni"/>
        </div>

        <!-- Nombre -->
        <div>
            <label for="nombre">Nombre:</label>
            <s:textfield name="nombre"
                         id="nombre"
                         value="%{empleado.nombre}"
                         theme="simple"/>
            <s:fielderror fieldName="nombre"/>
        </div>

        <!-- Apellidos -->
        <div>
            <label for="apellidos">Apellidos:</label>
            <s:textfield name="apellidos"
                         id="apellidos"
                         value="%{empleado.apellidos}"
                         theme="simple"/>
            <s:fielderror fieldName="apellidos"/>
        </div>

        <!-- Email -->
        <div>
            <label for="email">Email:</label>
            <s:textfield name="email"
                         id="email"
                         value="%{empleado.email}"
                         theme="simple"/>
            <s:fielderror fieldName="email"/>
        </div>

        <!-- Teléfono -->
        <div>
            <label for="telefono">Teléfono:</label>
            <s:textfield name="telefono"
                         id="telefono"
                         value="%{empleado.telefono}"
                         theme="simple"/>
            <s:fielderror fieldName="telefono"/>
        </div>

        <!-- Dirección -->
        <div>
            <label for="direccion">Dirección:</label>
            <s:textfield name="direccion"
                         id="direccion"
                         value="%{empleado.direccion}"
                         theme="simple"/>
            <s:fielderror fieldName="direccion"/>
        </div>

        <!-- Puesto -->
        <div>
            <label for="puesto">Puesto:</label>
            <s:textfield name="puesto"
                         id="puesto"
                         value="%{empleado.puesto}"
                         theme="simple"/>
            <s:fielderror fieldName="puesto"/>
        </div>

        <!-- Contraseña -->
        <div>
            <label for="contrasenya">Contraseña:</label>
            <s:password name="contrasenya"
                        id="contrasenya"
                        value="%{empleado.contrasenya}"
                        theme="simple"/>
            <s:fielderror fieldName="contrasenya"/>
        </div>

        <!-- Concesionario -->
        <div>
            <label for="idConcesionario">Concesionario:</label>
            <s:select name="idConcesionario"
                      id="idConcesionario"
                      list="listaConcesionarios"
                      listKey="idConcesionario"
                      listValue="nombre"
                      headerKey=""
                      headerValue="-- Seleccione --"
                      value="%{empleado.concesionario.idConcesionario}"
                      theme="simple"/>
            <s:fielderror fieldName="idConcesionario"/>
        </div>

        <!-- Botones -->
        <div style="margin-top:10px;">
            <s:submit value="Guardar Cambios"/>
            <input type="button"
                   value="Cancelar"
                   onclick="window.location.href='<s:property value="%{urlIndex}\">'"/>
        </div>

        <!-- Mostrar errores globales -->
        <s:actionerror/>
    </s:form>
</body>
</html>
