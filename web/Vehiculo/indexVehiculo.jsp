<%-- 
    Document   : indexVehiculo
    Created on : 22-may-2025, 20:12:10
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de Vehículos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <div class="container my-5">
            <h2 class="mb-4">Vehículos Registrados</h2>
            <s:actionerror/><br/>


            <s:form action="buscarVehiculo" method="post" theme="simple" cssClass="d-flex gap-2 mb-3">
                <s:textfield name="matricula"
                             placeholder="Introduzca matrícula"
                             size="15" cssClass="form-control w-25"/>
                <s:submit value="Buscar" cssClass="btn-rojo"/>
                <a href="<s:url action='indexVehiculo'/>"class="btn btn-outline-secondary">Mostrar todos</a>
            </s:form>

            <br/>


            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th scope="col">Seleccionar</th>
                        <th scope="col">Matrícula</th>
                        <th scope="col">Marca</th>
                        <th scope="col">Modelo</th>
                        <th scope="col">Año</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="lista" var="vehiculo">
                        <tr>
                            <td>
                                <input type="radio"
                                       name="matricula"
                                       class="selectVehiculo"
                                       value="<s:property value='#vehiculo.matricula'/>"/>
                            </td>
                            <td><s:property value="#vehiculo.matricula"/></td>
                            <td><s:property value="#vehiculo.marca"/></td>
                            <td><s:property value="#vehiculo.modelo"/></td>
                            <td><s:property value="#vehiculo.anio"/></td>
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
                <s:form id="formConsultar" action="consultarVehiculo" method="post">
                    <s:hidden name="matricula" id="hcConsultar"/>
                    <s:submit id="btnConsultar"
                              value="Consultar vehículo"
                              disabled="true" cssClass="btn-rojo"/>
                </s:form>

                <s:form id="formEditar"
                        action="editarVehiculo"
                        method="post">
                    <s:hidden name="matricula" id="hcEditar"/>
                    <s:submit id="btnEditar"
                              value="Modificar vehículo"
                              disabled="true" cssClass="btn-rojo"/>
                </s:form>

                <s:form id="formEliminar"
                        action="eliminarVehiculo"
                        method="post">
                    <s:hidden name="matricula" id="hcEliminar"/>
                    <s:submit id="btnEliminar"
                              value="Eliminar vehículo"
                              disabled="true"
                              onclick="return confirm('¿Eliminar este vehículo?');" cssClass="btn btn-danger"/>
                </s:form>
            </div>
            <div class="text-center mt-5">
                <s:form action="altaVehiculo"
                        method="get" theme="simple">
                    <s:submit value="Alta vehículo" cssClass="btn-rojo me-2"/>
                </s:form>
                <br>
                <s:form action="/principal.jsp" method="post" theme="simple"> 
                    <s:submit value="Volver a la página principal" cssClass="btn btn-outline-secondary"/>
                </s:form>
            </div>
            <script>
                const radios = document.querySelectorAll('.selectVehiculo');
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
                        const enabled = !!document.querySelector('.selectVehiculo:checked');
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
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


