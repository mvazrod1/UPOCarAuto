<%-- 
    Document   : indexInventario
    Created on : 26-may-2025
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de Inventarios</title>
    </head>
    <body>
        
        <h2>Inventarios Registrados</h2>
        <s:actionerror/><br/>

        <!-- Buscador por ID de Inventario -->
        <s:form action="buscarInventario" method="post" theme="simple">
            <s:textfield name="idInventario"
                         placeholder="Introduzca ID Inventario"
                         size="15"/>
            <s:submit value="Buscar"/>
            <a href="<s:url action='indexInventario'/>">Mostrar todos</a>
        </s:form>

        <br/>

        <!-- Tabla de inventarios con selector -->
        <table border="1" cellpadding="5">
            <tr>
                <th>Seleccionar</th>
                <th>ID Inventario</th>
                <th>Concesionario (ID)</th>
                <th>Empleado (DNI)</th>
                <th>Total Vehículos</th>
            </tr>
            <s:iterator value="lista" var="inventario">
                <tr>
                    <td>
                        <input type="radio"
                               name="idInventario"
                               class="selectInventario"
                               value="<s:property value='#inventario.idInventario'/>"/>
                    </td>
                    <td><s:property value="#inventario.idInventario"/></td>
                    <td><s:property value="#inventario.concesionario.idConcesionario"/></td>
                    <td><s:property value="#inventario.empleado.dni"/></td>
                    <td><s:property value="#inventario.totalVehiculos"/></td>
                </tr>
            </s:iterator>
            <s:if test="lista == null || lista.isEmpty()">
                <tr>
                    <td colspan="5" align="center">-- Sin resultados --</td>
                </tr>
            </s:if>
        </table>

        <br/>

        <!-- Formularios de acción -->
        <s:form id="formConsultar" action="consultarInventario" method="post">
            <s:hidden name="idInventario" id="hcConsultar"/>
            <s:submit id="btnConsultar"
                      value="Consultar"
                      disabled="true"/>
        </s:form>

        <s:form id="formEditar"
                action="editarInventario"
                method="post">
            <s:hidden name="idInventario" id="hcEditar"/>
            <s:submit id="btnEditar"
                      value="Modificar"
                      disabled="true"/>
        </s:form>

        <s:form id="formEliminar"
                action="eliminarInventario"
                method="post">
            <s:hidden name="idInventario" id="hcEliminar"/>
            <s:submit id="btnEliminar"
                      value="Eliminar"
                      disabled="true"
                      onclick="return confirm('¿Eliminar este inventario?');"/>
        </s:form>

        <s:form action="altaInventario"
                method="get">
            <s:submit value="Nuevo Inventario"/>
        </s:form>
        <br>
        <s:form action="/principal.jsp" method="post"> 
            <s:submit value="Volver a la página principal" />
        </s:form>

        <script>
            const radios = document.querySelectorAll('.selectInventario');
            const btns = {
                consultar: document.getElementById('btnConsultar'),
                editar:    document.getElementById('btnEditar'),
                eliminar:  document.getElementById('btnEliminar')
            };
            const hides = {
                consultar: document.getElementById('hcConsultar'),
                editar:    document.getElementById('hcEditar'),
                eliminar:  document.getElementById('hcEliminar')
            };

            radios.forEach(radio => {
                radio.addEventListener('change', () => {
                    const val = radio.value;
                    const enabled = !!document.querySelector('.selectInventario:checked');
                    btns.consultar.disabled = !enabled;
                    btns.editar.disabled    = !enabled;
                    btns.eliminar.disabled  = !enabled;
                    hides.consultar.value   = val;
                    hides.editar.value      = val;
                    hides.eliminar.value    = val;
                });
            });
        </script>

    </body>
</html>
