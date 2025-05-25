<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles del Empleado</title>
    </head>
    <body>
        <h2>Detalles del Empleado</h2>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>DNI</th>
                <td><s:property value="empleado.dni"/></td>
            </tr>
            <tr>
                <th>Nombre</th>
                <td><s:property value="empleado.nombre"/></td>
            </tr>
            <tr>
                <th>Apellidos</th>
                <td><s:property value="empleado.apellidos"/></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><s:property value="empleado.email"/></td>
            </tr>
            <tr>
                <th>Teléfono</th>
                <td><s:property value="empleado.telefono"/></td>
            </tr>
            <tr>
                <th>Dirección</th>
                <td><s:property value="empleado.direccion"/></td>
            </tr>
            <tr>
                <th>Puesto</th>
                <td><s:property value="empleado.puesto"/></td>
            </tr>
            <tr>
                <th>Contraseña</th>
                <td><s:property value="empleado.contrasenya"/></td>
            </tr>
            <tr>
                <th colspan="2">Concesionario Asociado</th>
            </tr>
            <s:if test="empleado.concesionario != null">
                <tr>
                    <th>ID Concesionario</th>
                    <td><s:property value="empleado.concesionario.idConcesionario"/></td>
                </tr>
                <tr>
                    <th>Nombre Concesionario</th>
                    <td><s:property value="empleado.concesionario.nombre"/></td>
                </tr>
                <tr>
                    <th>Dirección Concesionario</th>
                    <td><s:property value="empleado.concesionario.direccion"/></td>
                </tr>
                <tr>
                    <th>Teléfono Concesionario</th>
                    <td><s:property value="empleado.concesionario.telefono"/></td>
                </tr>
                <tr>
                    <th>Correo Concesionario</th>
                    <td><s:property value="empleado.concesionario.correo"/></td>
                </tr>
            </s:if>
            <s:else>
                <tr>
                    <td colspan="2" style="text-align:center;">
                        Este empleado no está asociado a ningún concesionario.
                    </td>
                </tr>
            </s:else>
        </table>

        <br/>

        <s:form namespace="/Empleado" action="indexEmpleado" method="get">
            <s:submit value="Volver a la lista"/>
        </s:form>
    </body>
</html>
