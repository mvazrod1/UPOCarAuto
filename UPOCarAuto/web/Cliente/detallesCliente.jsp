<%-- 
    Document   : consultarCliente
    Created on : 20-may-2025, 12:08:24
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container my-5">
                <h2 class="text-danger mb-4">Detalles del Cliente</h2>

                <div class="mb-4">
                    <div class="mb-2">
                        <label class="text-danger">DNI:</label>
                        <span><s:property value="cliente.dni"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Nombre:</label>
                        <span><s:property value="cliente.nombre"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Apellidos:</label>
                        <span><s:property value="cliente.apellidos"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Email:</label>
                        <span><s:property value="cliente.email"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Teléfono:</label>
                        <span><s:property value="cliente.telefono"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Dirección:</label>
                        <span><s:property value="cliente.direccion"/></span>
                    </div>
                </div>

                <h3 class="text-danger">Reservas Asociadas</h3>
                <s:if test="!cliente.reservas.isEmpty()">
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
                                <s:iterator value="cliente.reservas" var="r">
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
                    <p class="text-muted">Este cliente no tiene reservas asociadas.</p>
                </s:else>

                <div class="mt-4">
                    <s:form action="/Cliente/indexCliente" method="get">
                        <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
