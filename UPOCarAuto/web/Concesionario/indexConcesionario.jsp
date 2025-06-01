<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Listado de Concesionarios</title>

        <!-- Bootstrap + estilos globales -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>
        <main class="flex-grow-1">
            <div class="container mt-5">

                <h2 class="mb-4">Concesionarios Registrados</h2>

                <!-- ===== BUSCADOR ===== -->
                <s:form namespace="/Concesionario" action="buscar" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                    <s:textfield name="idConcesionario" placeholder="Buscar por ID" required="true"
                                 cssClass="form-control w-25"/>
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                    <a href="<s:url action='indexConcesionario'/>" class="btn btn-outline-secondary">Mostrar todos</a>
                </s:form>
                <!-- ==================== -->

                <s:actionerror cssClass="alert alert-danger"/>
                <s:actionmessage cssClass="alert alert-success"/>

                <!-- ===== TABLA ===== -->
                <s:form id="concesionarioForm" namespace="/Concesionario" method="post">
                    <input type="hidden" id="idSeleccionado" name="idConcesionario"/>

                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Seleccionar</th>
                                <th scope="col">ID</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Dirección</th>
                                <th scope="col">Teléfono</th>
                                <th scope="col">Correo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:iterator value="listaConcesionarios" var="c">
                                <tr>
                                    <td>
                                        <input type="radio" name="concesionarioRadio"
                                               value="<s:property value='#c.idConcesionario'/>"
                                               onclick="onConcesionarioSeleccionado(this.value)"/>
                                    </td>
                                    <td><s:property value="#c.idConcesionario"/></td>
                                    <td><s:property value="#c.nombre"/></td>
                                    <td><s:property value="#c.direccion"/></td>
                                    <td><s:property value="#c.telefono"/></td>
                                    <td><s:property value="#c.correo"/></td>
                                </tr>
                            </s:iterator>
                            <s:if test="listaConcesionarios == null || listaConcesionarios.isEmpty()">
                                <tr>
                                    <td colspan="6" class="text-center">-- Sin resultados --</td>
                                </tr>
                            </s:if>
                        </tbody>
                    </table>

                    <!-- ===== BOTONES DE ACCIÓN ===== -->
                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <input type="button" id="btnConsultar" value="Consultar Concesionario"
                               class="btn-rojo" disabled
                               onclick="enviarAccion('<s:url value="consultarConcesionario.action"/>')"/>

                        <input type="button" id="btnActualizar" value="Modificar Concesionario"
                               class="btn-rojo" disabled
                               onclick="enviarAccion('<s:url value="editarConcesionario.action"/>')"/>

                        <input type="button" id="btnEliminar" value="Eliminar Concesionario"
                               class="btn btn-danger" disabled
                               onclick="enviarAccion('<s:url value="eliminarConcesionario.action"/>')"/>
                    </div>
                </s:form>
                <!-- ============================ -->

                <!-- ===== BOTONES SECUNDARIOS ===== -->
                <div class="text-center mt-5">
                    <s:form namespace="/Concesionario" action="altaConcesionario" method="get" theme="simple">
                        <s:submit value="Nuevo Concesionario" cssClass="btn-rojo me-2"/>
                    </s:form>
                    <br>
                    <s:url var="principalUrl" value="/principal.jsp"/>
                    <input type="button" value="Volver a la página principal"
                           class="btn btn-outline-secondary"
                           onclick="location.href = '${principalUrl}'"/>
                </div>
                <!-- =============================== -->

            </div>
        </main>
        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script type="text/javascript">
                               function onConcesionarioSeleccionado(id) {
                                   document.getElementById("idSeleccionado").value = id;
                                   document.getElementById("btnConsultar").disabled = false;
                                   document.getElementById("btnActualizar").disabled = false;
                                   document.getElementById("btnEliminar").disabled = false;
                               }
                               function enviarAccion(url) {
                                   var form = document.getElementById("concesionarioForm");
                                   form.action = url;
                                   form.submit();
                               }
                               function confirmarEliminacion(url) {
                                   if (confirm("¿Estás seguro de que quieres eliminar este concesionario?")) {
                                       enviarAccion(url);
                                   }
                               }
        </script>
    </body>
</html>

