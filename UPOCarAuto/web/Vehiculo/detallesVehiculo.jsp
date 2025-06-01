<%-- 
    Document   : detallesVehiculo
    Created on : 23-may-2025, 17:55:12
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de Vehículo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <s:actionerror/><br/>
            <div class="container my-5">
                <h2 class="text-danger mb-4">Detalles del Vehículo</h2>
                <div class="mb-4">
                    <div class="mb-2">
                        <label class="text-danger">Matrícula:</label>
                        <s:property value="vehiculo.matricula"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Inventario (ID):</label>
                        <s:property value="vehiculo.inventario.idInventario"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Marca:</label>
                        <s:property value="vehiculo.marca"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Modelo:</label>
                        <s:property value="vehiculo.modelo"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Año:</label>
                        <s:property value="vehiculo.anio"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Precio:</label>
                        <s:property value="vehiculo.precio"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Estado:</label>
                        <s:property value="vehiculo.estado"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Disponibilidad:</label>
                        <s:property value="vehiculo.disponibilidad ? 'Sí' : 'No'"/>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Reservas (nº):</label>
                        <s:property value="vehiculo.reservas != null ? vehiculo.reservas.size: 0"/>
                    </div>
                </div>

                <h3 class="text-danger">Reservas Asociadas</h3>
                <s:if test="!vehiculo.reservas.isEmpty()">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Matrícula</th>
                                    <th>Estado</th>
                                    <th>Fecha Creación</th>
                                    <th>Fecha Recogida</th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="vehiculo.reservas" var="r">
                                    <tr>
                                        <td><s:property value="#r.idReserva"/></td>
                                        <td><s:property value="#r.vehiculo.matricula"/></td>
                                        <td><s:property value="#r.estado"/></td>
                                        <td><s:property value="#r.fechaCreacion"/></td>
                                        <td>
                                            <s:if test="#r.fechaRecogida != null">
                                                <s:property value="#r.fechaRecogida"/>
                                            </s:if>
                                            <s:else>
                                                Fecha aún no fijada
                                            </s:else>
                                        </td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>
                </s:if>
                <s:else>
                    <p class="text-muted">Este vehículo no tiene reservas asociadas.</p>
                </s:else>
                <div class="mt-4">
                    <s:form action="/Vehiculo/indexVehiculo" method="get">
                        <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

