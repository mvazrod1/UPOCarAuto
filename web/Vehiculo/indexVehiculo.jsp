<%-- 
    Document   : indexVehiculo
    Created on : 22-may-2025, 20:12:10
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Listado de Vehículos</title>
    </head>
    <body>

        <s:actionerror/><br/>

        <!-- Buscador -->
        <s:form action="buscarVehiculo" method="post" theme="simple">
            <s:textfield name="matricula"
                         placeholder="Introduzca matrícula"
                         size="15"/>
            <s:submit value="Buscar"/>
            <a href="<s:url action='indexVehiculo'/>">Mostrar todos</a>
        </s:form>

        <br/>

        <!-- Tabla simplificada: solo los campos clave -->
        <table border="1" cellpadding="5">
            <tr>
                <th>Seleccionar</th>
                <th>Matrícula</th>
                <th>Marca</th>
                <th>Modelo</th>
                <th>Año</th>
            </tr>
            <s:iterator value="lista" var="vehiculo">
                <tr>
                    <td>
                        <input type="radio"
                               name="selectedMatricula"
                               class="selectVehiculo"
                               value="<s:property value='#vehiculo.matricula'/>"/>
                    </td>
                    <td><s:property value="#vehiculo.matricula"/></td>
                    <td><s:property value="#vehiculo.marca"/></td>
                    <td><s:property value="#vehiculo.modelo"/></td>
                    <td><s:property value="#vehiculo.anio"/></td>
                </tr>
            </s:iterator>
            <s:if test="lista == null || lista.isEmpty()">
                <tr>
                    <td colspan="5" align="center">-- Sin resultados --</td>
                </tr>
            </s:if>
        </table>

        <br/>

        <!-- Formularios de acción (mantener iguales) -->
        <s:form id="formConsultar"
                action="consultarVehiculo"
                method="post"
                theme="simple">
            <s:hidden name="matricula" id="hcConsultar"/>
            <s:submit id="btnConsultar"
                      value="Consultar"
                      disabled="true"/>
        </s:form>

        <s:form id="formEditar"
                action="editarVehiculo"
                method="post"
                theme="simple">
            <s:hidden name="matricula" id="hcEditar"/>
            <s:submit id="btnEditar"
                      value="Modificar"
                      disabled="true"/>
        </s:form>

        <s:form id="formEliminar"
                action="eliminarVehiculo"
                method="post"
                theme="simple">
            <s:hidden name="matricula" id="hcEliminar"/>
            <s:submit id="btnEliminar"
                      value="Eliminar"
                      disabled="true"
                      onclick="return confirm('¿Eliminar este vehículo?');"/>
        </s:form>

        <s:form action="altaVehiculo"
                method="get"
                theme="simple">
            <s:submit value="Nuevo Vehículo"/>
        </s:form>

        <script>
            const radios = document.querySelectorAll('.selectVehiculo');
            const btns = {
                consultar: document.getElementById('btnConsultar'),
                editar: document.getElementById('btnEditar'),
                eliminar: document.getElementById('btnEliminar')
            };
            const hides = {
                consultar: document.getElementById('hcConsultar'),
                editar: document.getElementById('hcEditar'),
                eliminar: document.getElementById('hcEliminar')
            };

            radios.forEach(radio => {
                radio.addEventListener('change', () => {
                    const val = radio.value;
                    const enabled = !!document.querySelector('.selectVehiculo:checked');
                    btns.consultar.disabled = !enabled;
                    btns.editar.disabled = !enabled;
                    btns.eliminar.disabled = !enabled;
                    hides.consultar.value = val;
                    hides.editar.value = val;
                    hides.eliminar.value = val;
                });
            });
        </script>

    </body>
</html>


