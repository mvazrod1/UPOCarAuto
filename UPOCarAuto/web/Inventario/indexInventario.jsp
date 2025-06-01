<%-- 
    Document   : indexInventario
    Created on : 26-may-2025
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de Inventarios</title>
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container my-5">
                <h2 class="mb-4">Inventarios Registrados</h2>
                <s:actionerror/><br/>

                <!-- Buscador por ID de Inventario -->
                <s:form action="buscarInventario" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                    <s:textfield name="idInventario"
                                 placeholder="Introduzca ID Inventario"
                                 size="15" cssClass="form-control w-25"/>
                    <s:submit value="Buscar" cssClass="btn-rojo"/>
                    <a href="<s:url action='indexInventario'/>" class="btn btn-outline-secondary">Mostrar todos</a>
                </s:form>

                <br/>

                <!-- Tabla de inventarios con selector -->
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Seleccionar</th>
                            <th scope="col">ID Inventario</th>
                            <th scope="col">Concesionario (ID)</th>
                            <th scope="col">Empleado (DNI)</th>
                            <th scope="col">Total Vehículos</th>
                        </tr>
                    </thead>
                    <tbody>
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
                    </tbody>
                </table>

                <div class="d-flex justify-content-center gap-3 mt-4">
                    <!-- Formularios de acción -->
                    <s:form id="formConsultar" action="consultarInventario" method="post">
                        <s:hidden name="idInventario" id="hcConsultar"/>
                        <s:submit id="btnConsultar"
                                  value="Consultar Inventario"
                                  disabled="true" cssClass="btn-rojo"/>
                    </s:form>

                    <s:form id="formEditar"
                            action="editarInventario"
                            method="post">
                        <s:hidden name="idInventario" id="hcEditar"/>
                        <s:submit id="btnEditar"
                                  value="Modificar Inventario"
                                  disabled="true" cssClass="btn-rojo"/>
                    </s:form>

                    <s:form id="formEliminar"
                            action="eliminarInventario"
                            method="post">
                        <s:hidden name="idInventario" id="hcEliminar"/>
                        <s:submit id="btnEliminar"
                                  value="Eliminar Inventario"
                                  disabled="true"
                                  onclick="return confirm('¿Eliminar este inventario?');" cssClass="btn btn-danger"/>
                    </s:form>
                </div>

                <div class="text-center mt-5">
                    <s:form action="altaInventario"
                            method="get" theme="simple">
                        <s:submit value="Alta Inventario" cssClass="btn-rojo me-2"/>
                    </s:form>
                    <br>
                    <s:form action="/principal.jsp" method="post" theme="simple"> 
                        <s:submit value="Volver a la página principal" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>

                <script>
                    const radios = document.querySelectorAll('.selectInventario');
                    const btns = {
                        consultar: document.getElementById('btnConsultar'),
                        editar: document.getElementById('btnEditar'),
                        eliminar: document.getElementById('btnEliminar')
                    };
                    const hides = {
                        consultar: document.getElementById('hcConsultar'),
                        editar: document.getElementById('hcEditar'),
                        eliminar: document.getElementById('hcEliminar')
                    };

                    radios.forEach(radio => {
                        radio.addEventListener('change', () => {
                            const val = radio.value;
                            const enabled = !!document.querySelector('.selectInventario:checked');
                            btns.consultar.disabled = !enabled;
                            btns.editar.disabled = !enabled;
                            btns.eliminar.disabled = !enabled;
                            hides.consultar.value = val;
                            hides.editar.value = val;
                            hides.eliminar.value = val;
                        });
                    });
                </script>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
