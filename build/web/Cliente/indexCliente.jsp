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
                document.getElementById("botones").style.display = 'block';
            }

            function enviarAccion(accion) {
                document.getElementById("clienteForm").action = accion;
                document.getElementById("clienteForm").submit();
            }
        </script>
    </head>
    <body>
        <h2>Clientes Registrados</h2>

        <s:form id="clienteForm" method="post">
            <input type="hidden" id="dniSeleccionado" name="dni" />

            <s:iterator value="listaClientes" var="c">
                <label>
                    <input type="radio" name="clienteRadio" onclick="onClienteSeleccionado(this.value)" value="<s:property value="#c.dni" />" />
                    <s:property value="#c.nombre"/> <s:property value="#c.apellidos"/>
                </label><br/>
            </s:iterator>

            <div id="botones" style="display:none; margin-top:15px;">
                <input type="button" value="Consultar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/consultarCliente.action"/>')" />
                <input type="button" value="Actualizar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/editarCliente.action"/>')" />
                <input type="button" value="Eliminar Cliente"
                       onclick="enviarAccion('<s:url value="/Cliente/eliminarCliente.action"/>')" />
            </div>
        </s:form>

        <br/><br/>
        <s:form action="/Cliente/altaCliente" method="post"> 
            <s:submit value="Alta cliente" />
        </s:form>
    </body>
</html>
