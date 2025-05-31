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
        <meta charset="UTF-8">
        <title>Gestión de Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
        <script>
            function onClienteSeleccionado(dni) {
                document.getElementById("dniSeleccionado").value = dni;
                document.getElementById("btnConsultar").disabled = false;
                document.getElementById("btnActualizar").disabled = false;
                document.getElementById("btnEliminar").disabled = false;
            }

            function enviarAccion(accion, esEliminar = false) {
                if (esEliminar) {
                    var dni = document.getElementById("dniSeleccionado").value;
                    var confirmar = confirm("¿Seguro que quiere eliminar al cliente con DNI: " + dni + "?");
                    if (!confirmar)
                        return;
                }
                document.getElementById("clienteForm").action = accion;
                document.getElementById("clienteForm").submit();
            }
        </script>
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container my-5">
                <h2 class="mb-4">Clientes Registrados</h2>

                <!-- Formulario de búsqueda -->
                <s:form action="buscarCliente" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                    <s:textfield name="dni" placeholder="Introduzca DNI" cssClass="form-control w-25"/>
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                    <a href="<s:url action='indexCliente'/>" class="btn btn-outline-secondary">Mostrar todos</a>
                </s:form>

                <!-- Mensajes -->
                <s:if test="hasActionMessages()">
                    <div class="alert alert-danger">
                        <s:actionmessage />
                    </div>
                </s:if>

                <!-- Tabla de clientes -->
                <s:form id="clienteForm" method="post">
                    <input type="hidden" id="dniSeleccionado" name="dni" />

                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Seleccionar</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Apellidos</th>
                                <th scope="col">DNI</th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:iterator value="listaClientes" var="c">
                                <tr>
                                    <td>
                                        <input type="radio" name="clienteRadio"
                                               onclick="onClienteSeleccionado(this.value)"
                                               value="<s:property value="#c.dni"/>" />
                                    </td>
                                    <td><s:property value="#c.nombre" /></td>
                                    <td><s:property value="#c.apellidos" /></td>
                                    <td><s:property value="#c.dni" /></td>
                                </tr>
                            </s:iterator>
                            <s:if test="listaClientes == null || listaClientes.isEmpty()">
                                <tr>
                                    <td colspan="5" align="center">-- Sin resultados --</td>
                                </tr>
                            </s:if>
                        </tbody>
                    </table>

                    <!-- Botones de acción -->
                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <input type="button" id="btnConsultar" value="Consultar Cliente"
                               class="btn-rojo" onclick="enviarAccion('<s:url value="/Cliente/consultarCliente.action"/>')" disabled />

                        <input type="button" id="btnActualizar" value="Modificar Cliente"
                               class="btn-rojo" onclick="enviarAccion('<s:url value="/Cliente/editarCliente.action"/>')" disabled />

                        <input type="button" id="btnEliminar" value="Eliminar Cliente"
                               class="btn btn-danger" onclick="enviarAccion('<s:url value="/Cliente/eliminarCliente.action"/>', true)" disabled />

                    </div>
                </s:form>
                <div class="text-center mt-5">
                    <s:form action="/Cliente/altaCliente" method="post" theme="simple">
                        <s:submit value="Alta cliente" cssClass="btn-rojo me-2"/>
                    </s:form>
                    <br>
                    <s:form action="/principal.jsp" method="post" theme="simple">
                        <s:submit value="Volver a la página principal" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

