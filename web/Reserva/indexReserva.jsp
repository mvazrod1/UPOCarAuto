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
        <meta charset="UTF-8">
        <title>Gestión de Reservas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">

        <script>
            function onReservaSeleccionada(idReserva) {
                document.getElementById("idSeleccionado").value = idReserva;
                document.getElementById("btnConsultar").disabled = false;
                document.getElementById("btnActualizar").disabled = false;
                document.getElementById("btnEliminar").disabled = false;
            }

            function enviarAccion(accion, esEliminar = false) {
                if (esEliminar) {
                    var id = document.getElementById("idSeleccionado").value;
                    if (!confirm("¿Seguro que quiere eliminar la reserva con ID: " + id + "?")) {
                        return;
                    }
                }
                document.getElementById("reservaForm").action = accion;
                document.getElementById("reservaForm").submit();
            }
        </script>
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />

        <div class="container my-5">
            <h2 class="mb-4">Reservas Registradas</h2>

            <!-- Formulario de búsqueda -->
            <s:form action="buscarReserva" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                <s:textfield name="idReserva" placeholder="ID de reserva" cssClass="form-control w-25"/>
                <s:submit value="Buscar" cssClass="btn-rojo"/>
                <a href="<s:url action='indexReserva'/>" class="btn btn-outline-secondary">Mostrar todos</a>
            </s:form>

            <!-- Mensajes -->
            <s:if test="hasActionMessages()">
                <div class="alert alert-danger">
                    <s:actionmessage />
                </div>
            </s:if>

            <!-- Tabla de reservas -->
            <s:form id="reservaForm" method="post">
                <input type="hidden" id="idSeleccionado" name="idReserva" />

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Seleccionar</th>
                                <th>DNI Cliente</th>
                                <th>Matrícula</th>
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
                </div>

                <!-- Botones de acción -->
                <div class="d-flex justify-content-center gap-3 mt-4">
                    <input type="button" id="btnConsultar" value="Consultar Reserva"
                           onclick="enviarAccion('<s:url value="/Reserva/consultarReserva.action"/>')"
                           class="btn-rojo" disabled />
                    <input type="button" id="btnActualizar" value="Modificar Reserva"
                           onclick="enviarAccion('<s:url value="/Reserva/editarReserva.action"/>')"
                           class="btn-rojo" disabled />
                    <input type="button" id="btnEliminar" value="Eliminar Reserva"
                           onclick="enviarAccion('<s:url value="/Reserva/eliminarReserva.action"/>', true)"
                           class="btn btn-danger" disabled />
                </div>
            </s:form>

            <!-- Botones adicionales -->
            <div class="text-center mt-5">
                <s:form action="/Reserva/altaReserva" method="post" theme="simple">
                    <s:submit value="Alta Reserva" cssClass="btn-rojo me-2"/>
                </s:form>
                <br>
                <s:form action="/principal.jsp" method="post" theme="simple">
                    <s:submit value="Volver a la página principal" cssClass="btn btn-outline-secondary"/>
                </s:form>
            </div>
        </div>

        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

