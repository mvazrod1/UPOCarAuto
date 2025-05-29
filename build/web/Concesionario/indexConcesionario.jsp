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

        <div class="container mt-5">

            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Concesionarios Registrados</h2>

            <!-- ===== BUSCADOR ===== -->
            <s:form namespace="/Concesionario" action="buscar" method="post" cssClass="row g-3 mb-4">
                <div class="col-auto">
                    <s:textfield name="idConcesionario" placeholder="Buscar por ID" required="true"
                                 cssClass="form-control"/>
                </div>
                <div class="col-auto">
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                </div>

                <s:if test="idConcesionario != null">
                    <div class="col-auto">
                        <s:url var="todosUrl" namespace="/Concesionario" action="indexConcesionario"/>
                        <input type="button" value="Ver todos" class="btn btn-outline-secondary"
                               onclick="location.href = '${todosUrl}'"/>
                    </div>
                </s:if>
            </s:form>
            <!-- ==================== -->

            <s:actionerror cssClass="alert alert-danger"/>
            <s:actionmessage cssClass="alert alert-success"/>

            <!-- ===== TABLA ===== -->
            <s:form id="concesionarioForm" namespace="/Concesionario" method="post">
                <input type="hidden" id="idSeleccionado" name="idConcesionario"/>

                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead class="table-light">
                            <tr>
                                <th></th>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Correo</th>
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
                        </tbody>
                    </table>
                </div>

                <!-- ===== BOTONES DE ACCIÓN ===== -->
                <div class="d-flex justify-content-center gap-2 my-3">
                    <input type="button" id="btnConsultar" value="Consultar"
                           class="btn-rojo" disabled
                           onclick="enviarAccion('<s:url value="consultarConcesionario.action"/>')"/>

                    <input type="button" id="btnActualizar" value="Actualizar"
                           class="btn-rojo" disabled
                           onclick="enviarAccion('<s:url value="editarConcesionario.action"/>')"/>

                    <input type="button" id="btnEliminar" value="Eliminar"
                           class="btn btn-danger" disabled
                           onclick="confirmarEliminacion('<s:url value="eliminarConcesionario.action"/>')"/>
                </div>
            </s:form>
            <!-- ============================ -->

            <!-- ===== BOTONES SECUNDARIOS ===== -->
            <div class="d-flex justify-content-between mt-4">
                <s:form namespace="/Concesionario" action="altaConcesionario" method="get" cssClass="m-0">
                    <s:submit value="Nuevo Concesionario" cssClass="btn-rojo"/>
                </s:form>

                <s:url var="principalUrl" value="/principal.jsp"/>
                <input type="button" value="Volver a la página principal"
                       class="btn btn-outline-secondary"
                       onclick="location.href = '${principalUrl}'"/>
            </div>
            <!-- =============================== -->

        </div>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
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
                               if (confirm("¿Estás seguro de que quieres eliminar este cliente?")) {
                                   enviarAccion(url);
                               }
                           }
        </script>
    </body>
</html>
