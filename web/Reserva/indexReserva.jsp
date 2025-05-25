<%-- 
    Document   : indexReserva
    Created on : 22-may-2025, 17:51:01
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Reservas</title>
        <script>
            function onReservaSeleccionada(idReserva) {
                document.getElementById("idSeleccionado").value = idReserva;

                // Habilitar los botones
                document.getElementById("btnConsultar").disabled = false;
                document.getElementById("btnActualizar").disabled = false;
                document.getElementById("btnEliminar").disabled = false;
            }

            function enviarAccion(accion) {
                document.getElementById("reservaForm").action = accion;
                document.getElementById("reservaForm").submit();
            }
        </script>
    </head>
    <body>
        <h2>Reservas Registrados</h2>

        <s:form action="buscarReserva" method="post" theme="simple">
            <s:textfield name="idReserva"
                         placeholder="Introduzca id de Reserva"
                         size="15"/>
            <s:submit value="Buscar"/>
            <a href="<s:url action='indexReserva'/>">Mostrar todos</a>
        </s:form>

        <s:if test="hasActionMessages()">
            <div style="color: red; font-weight: bold;">
                <s:actionmessage />
            </div>
        </s:if>

        <br/>

        <s:form id="reservaForm" method="post">
            <input type="hidden" id="idSeleccionado" name="idReserva" />

            <table border="1">
                <thead>
                    <tr>
                        <th>Seleccionar</th>
                        <th>DNI Cliente</th>
                        <th>matricula</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="listaReservas" var="r">
                        <tr>
                            <td>
                                <input type="radio" name="reservaRadio" 
                                       onclick="onReservaSeleccionada(this.value)" 
                                       value="<s:property value="#r.idReserva" />" />
                            </td>
                            <td><s:property value="#r.cliente.dni"/></td>
                            <td><s:property value="#r.vehiculo.matricula"/></td>
                            <td><s:property value="#r.estado"/></td>
                        </tr>
                    </s:iterator>
                </tbody>
            </table>

            <div id="botones" style="margin-top:15px;">
                <input type="button" id="btnConsultar" value="Consultar Reserva"
                       onclick="enviarAccion('<s:url value="/Reserva/consultarReserva.action"/>')" disabled />
                <input type="button" id="btnActualizar" value="Actualizar Reserva"
                       onclick="enviarAccion('<s:url value="/Reserva/editarReserva.action"/>')" disabled />
                <input type="button" id="btnEliminar" value="Eliminar Reserva"
                       onclick="enviarAccion('<s:url value="/Reserva/eliminarReserva.action"/>')" disabled />
            </div>
        </s:form>

        <br/><br/>
        <s:form action="/Reserva/altaReserva" method="post"> 
            <s:submit value="Alta Reserva" />
        </s:form>
        <br>
        <s:form action="/principal.jsp" method="post"> 
            <s:submit value="Volver a la página principal" />
        </s:form>
    </body>
</html>
