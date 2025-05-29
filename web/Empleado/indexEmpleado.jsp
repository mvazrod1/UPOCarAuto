<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Listado de Empleados</title>

        <!-- Bootstrap + estilos globales -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>

        <div class="container mt-5">

            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Empleados Registrados</h2>

            <!-- ===== BUSCADOR ===== -->
            <s:form namespace="/Empleado" action="buscar" method="post" cssClass="row g-3 mb-4">
                <div class="col-auto">
                    <s:textfield name="dni" placeholder="Buscar por DNI" required="true"
                                 cssClass="form-control"/>
                </div>
                <div class="col-auto">
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                </div>

                <!-- botón Ver todos, sólo tras buscar -->
                <s:if test="dni != null && !dni.trim().isEmpty()">
                    <div class="col-auto">
                        <s:url var="todosUrl" namespace="/Empleado" action="indexEmpleado"/>
                        <input type="button" value="Ver todos" class="btn btn-outline-secondary"
                               onclick="location.href = '${todosUrl}'"/>
                    </div>
                </s:if>
            </s:form>
            <!-- ==================== -->

            <s:actionerror cssClass="alert alert-danger"/>
            <s:actionmessage cssClass="alert alert-success"/>

            <!-- ===== TABLA ===== -->
            <s:form id="empleadoForm" namespace="/Empleado" method="post">
                <input type="hidden" id="dniSeleccionado" name="dni"/>

                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead class="table-light">
                            <tr>
                                <th></th>
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
                                        <input type="radio" name="empleadoRadio"
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
                </div>

                <!-- ===== BOTONES DE ACCIÓN ===== -->
                <div class="d-flex justify-content-center gap-2 my-3">
                    <input type="button" id="btnConsultar" value="Consultar"
                           class="btn-rojo" disabled
                           onclick="enviarAccion('<s:url value="consultarEmpleado.action"/>')"/>

                    <input type="button" id="btnActualizar" value="Actualizar"
                           class="btn-rojo" disabled
                           onclick="enviarAccion('<s:url value="editarEmpleado.action"/>')"/>

                    <input type="button" id="btnEliminar" value="Eliminar"
                           class="btn btn-danger" disabled
                           onclick="confirmarEliminacion('<s:url value="eliminarEmpleado.action"/>')"/>
                </div>
            </s:form>
            <!-- ============================ -->

            <!-- ===== BOTONES SECUNDARIOS ===== -->
            <div class="d-flex justify-content-between mt-4">
                <s:form namespace="/Empleado" action="altaEmpleado" method="get" cssClass="m-0">
                    <s:submit value="Nuevo Empleado" cssClass="btn-rojo"/>
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

        <!-- scripts existentes -->
        <script type="text/javascript">
                           function onEmpleadoSeleccionado(dni) {
                               document.getElementById("dniSeleccionado").value = dni;
                               document.getElementById("btnConsultar").disabled = false;
                               document.getElementById("btnActualizar").disabled = false;
                               document.getElementById("btnEliminar").disabled = false;
                           }
                           function enviarAccion(url) {
                               var form = document.getElementById("empleadoForm");
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
