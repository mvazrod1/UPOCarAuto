<%-- 
    Document   : detallesReserva
    Created on : 24-may-2025, 2:21:10
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles Reserva</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container my-5">
                <h2 class="text-danger mb-4">Detalles de la Reserva</h2>

                <div class="mb-4">
                    <div class="mb-2">
                        <label class="text-danger">ID Reserva:</label>
                        <span><s:property value="reserva.idReserva"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">DNI Cliente:</label>
                        <span><s:property value="reserva.cliente.dni"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Matrícula:</label>
                        <span><s:property value="reserva.vehiculo.matricula"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Estado:</label>
                        <span><s:property value="reserva.estado"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Fecha Creación:</label>
                        <span><s:property value="reserva.fechaCreacion"/></span>
                    </div>
                    <div class="mb-2">
                        <label class="text-danger">Fecha Recogida:</label>
                        <span>
                            <s:if test="reserva.fechaRecogida != null">
                                <s:property value="reserva.fechaRecogida"/>
                            </s:if>
                            <s:else>
                                Fecha aún no fijada
                            </s:else>
                        </span>
                    </div>
                </div>

                <div>
                    <h3 class="text-danger">Pagos</h3>
                    <s:if test="!reserva.pagos.isEmpty()">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID Pago</th>
                                        <th>Precio</th>
                                        <th>Fecha de Pago</th>
                                        <th>Método de Pago</th>
                                        <th>Estado de Pago</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="reserva.pagos" var="pago">
                                        <tr>
                                            <td><s:property value="#pago.idPago" /></td>
                                            <td><s:property value="#pago.precioTotal" /></td>
                                            <td><s:property value="#pago.fechaPago" /></td>
                                            <td><s:property value="#pago.metodoPago" /></td>
                                            <td><s:property value="#pago.estadoPago" /></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </s:if>
                    <s:else>
                        <p class="text-muted">No hay pagos registrados para esta reserva.</p>
                    </s:else>
                </div>

                <div class="mt-4">
                    <s:form action="/Reserva/indexReserva" method="get">
                        <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


