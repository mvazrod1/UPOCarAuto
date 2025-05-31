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
        <main class="flex-grow-1">
            <div class="container mt-5">

                <h2 class="mb-4">Empleados Registrados</h2>

                <!-- ===== BUSCADOR ===== -->
                <s:form namespace="/Empleado" action="buscar" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                    <s:textfield name="dni" placeholder="Buscar por DNI" required="true"
                                 cssClass="form-control w-25"/>
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                    <a href="<s:url action='indexEmpleado'/>" class="btn btn-outline-secondary">Mostrar todos</a>
                </s:form>
                <!-- ==================== -->

                <s:actionerror cssClass="alert alert-danger"/>
                <s:actionmessage cssClass="alert alert-success"/>

                <!-- ===== TABLA ===== -->
                <s:form id="empleadoForm" namespace="/Empleado" method="post">
                    <input type="hidden" id="dniSeleccionado" name="dni"/>


                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Seleccionar</th>
                                <th scope="col">DNI</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Apellidos</th>
                                <th scope="col">Email</th>
                                <th scope="col">Teléfono</th>
                                <th scope="col">Dirección</th>
                                <th scope="col">Puesto</th>
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
                            <s:if test="listaEmpleados == null || listaEmpleados.isEmpty()">
                                <tr>
                                    <td colspan="5" align="center">-- Sin resultados --</td>
                                </tr>
                            </s:if>
                        </tbody>
                    </table>


                    <!-- ===== BOTONES DE ACCIÓN ===== -->
                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <input type="button" id="btnConsultar" value="Consultar Empleado"
                               class="btn-rojo" disabled
                               onclick="enviarAccion('<s:url value="consultarEmpleado.action"/>')"/>

                        <input type="button" id="btnActualizar" value="Modificar Empleado"
                               class="btn-rojo" disabled
                               onclick="enviarAccion('<s:url value="editarEmpleado.action"/>')"/>

                        <input type="button" id="btnEliminar" value="Eliminar Empleado"
                               class="btn btn-danger" disabled
                               onclick="confirmarEliminacion('<s:url value="eliminarEmpleado.action"/>')"/>
                    </div>
                </s:form>
                <!-- ============================ -->

                <!-- ===== BOTONES SECUNDARIOS ===== -->
                <div class="text-center mt-5">
                    <s:form namespace="/Empleado" action="altaEmpleado" method="get" theme="simple">
                        <s:submit value="Alta Empleado" cssClass="btn-rojo me-2"/>
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
                                   if (confirm("¿Estás seguro de que quieres eliminar este empleado?")) {
                                       enviarAccion(url);
                                   }
                               }
        </script>
    </body>
</html>
