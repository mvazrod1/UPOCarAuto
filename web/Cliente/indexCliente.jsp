<%-- 
    Document   : indexCliente
    Created on : 20-may-2025, 11:46:45
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Clientes</title>
        <script>
            function onClienteSeleccionado(dni) {
                document.getElementById("dniSeleccionado").value = dni;

                // Habilitar los botones
                document.getElementById("btnConsultar").disabled = false;
                document.getElementById("btnActualizar").disabled = false;
                document.getElementById("btnEliminar").disabled = false;
            }

            function enviarAccion(accion) {
                document.getElementById("clienteForm").action = accion;
                document.getElementById("clienteForm").submit();
            }
        </script>
    </head>
    <body>
        <h2>Clientes Registrados</h2>

        <s:form action="buscarCliente" method="post" theme="simple">
            <s:textfield name="dni"
                         placeholder="Introduzca dni"
                         size="15"/>
            <s:submit value="Buscar"/>
            <a href="<s:url action='indexCliente'/>">Mostrar todos</a>
        </s:form>

        <s:if test="hasActionMessages()">
            <div style="color: red; font-weight: bold;">
                <s:actionmessage />
            </div>
        </s:if>

        <br/>

        <s:form id="clienteForm" method="post">
            <input type="hidden" id="dniSeleccionado" name="dni" />

            <table border="1">
                <thead>
                    <tr>
                        <th>Seleccionar</th>
                        <th>Nombre</th>
                        <th>Apellidos</th>
                        <th>DNI</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="listaClientes" var="c">
                        <tr>
                            <td>
                                <input type="radio" name="clienteRadio" 
                                       onclick="onClienteSeleccionado(this.value)" 
                                       value="<s:property value="#c.dni" />" />
                            </td>
                            <td><s:property value="#c.nombre"/></td>
                            <td><s:property value="#c.apellidos"/></td>
                            <td><s:property value="#c.dni"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>

            <div id="botones" style="margin-top:15px;">
                <input type="button" id="btnConsultar" value="Consultar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/consultarCliente.action"/>')" disabled />
                <input type="button" id="btnActualizar" value="Actualizar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/editarCliente.action"/>')" disabled />
                <input type="button" id="btnEliminar" value="Eliminar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/eliminarCliente.action"/>')" disabled />
            </div>
        </s:form>

        <br/><br/>
        <s:form action="/Cliente/altaCliente" method="post"> 
            <s:submit value="Alta cliente" />
        </s:form>
        <br>
        <s:form action="/principal.jsp" method="post"> 
            <s:submit value="Volver a la página principal" />
        </s:form>
    </body>
</html>
