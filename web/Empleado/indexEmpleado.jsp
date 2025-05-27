<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Listado de Empleados</title>
        <script type="text/javascript">
            // Habilita los botones cuando un empleado es seleccionado
            function onEmpleadoSeleccionado(dni) {
                document.getElementById("dniSeleccionado").value = dni;
                document.getElementById("btnConsultar").disabled = false;
                document.getElementById("btnActualizar").disabled = false;
                document.getElementById("btnEliminar").disabled = false;
            }

            // Cambia el action del form principal y lo envía
            function enviarAccion(url) {
                var form = document.getElementById("empleadoForm");
                form.action = url;
                form.submit();
            }
        </script>
    </head>
    <body>
        <h2>Empleados Registrados</h2>


        <s:form namespace="/Empleado" action="buscar" method="post" cssStyle="margin-bottom:15px;">
            <s:textfield name="dni" label="Buscar por DNI" required="true"/>
            <s:submit value="Buscar"/>

            <!-- Solo se renderiza cuando dni ≠ null/ vacío (es decir, tras buscar) -->
            <s:if test="dni != null && !dni.trim().isEmpty()">
                <s:url var="todosUrl" namespace="/Empleado" action="indexEmpleado"/>
                <input type="button" value="Ver todos" onclick="location.href = '${todosUrl}'"/>
            </s:if>
        </s:form>


        <s:actionerror/>
        <s:actionmessage/>

        <s:form id="empleadoForm" namespace="/Empleado" method="post">
            <input type="hidden" id="dniSeleccionado" name="dni"/>

            <table border="1" cellpadding="5" cellspacing="0">
                <thead>
                    <tr>
                        <th>Seleccionar</th>
                        <th>DNI</th>
                        <th>Nombre</th>
                        <th>Apellidos</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Dirección</th>
                        <th>Puesto</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="listaEmpleados" var="e">
                        <tr>
                            <td>
                                <input type="radio"
                                       name="empleadoRadio"
                                       value="<s:property value='#e.dni'/>"
                                       onclick="onEmpleadoSeleccionado(this.value)"/>
                            </td>
                            <td><s:property value="#e.dni"/></td>
                            <td><s:property value="#e.nombre"/></td>
                            <td><s:property value="#e.apellidos"/></td>
                            <td><s:property value="#e.email"/></td>
                            <td><s:property value="#e.telefono"/></td>
                            <td><s:property value="#e.direccion"/></td>
                            <td><s:property value="#e.puesto"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>

            <div id="botones" style="margin-top:15px;">
                <input type="button" id="btnConsultar" value="Consultar Empleado"
                       onclick="enviarAccion('<s:url value="consultarEmpleado.action"/>')" disabled/>
                <input type="button" id="btnActualizar" value="Actualizar Empleado"
                       onclick="enviarAccion('<s:url value="editarEmpleado.action"/>')" disabled/>
                <input type="button" id="btnEliminar" value="Eliminar Empleado"
                       onclick="enviarAccion('<s:url value="eliminarEmpleado.action"/>')" disabled/>
            </div>
        </s:form>

        <br/>

        <s:form namespace="/Empleado" action="altaEmpleado" method="get">
            <s:submit value="Nuevo Empleado"/>
        </s:form>
    </body>
</html>
