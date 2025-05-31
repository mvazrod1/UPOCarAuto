<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Página principal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="HEADER.jsp"/>

        <div class="container mt-5 text-center">
            <h1 class="mb-3" style="color: var(--color-rojo);">
                Bienvenido <s:property value="#session.empleado.nombre"/> --- Puesto de <s:property value="#session.empleado.puesto"/>
            </h1>

            <h2 class="mb-4">¿Qué acción deseas realizar?</h2>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-3 justify-content-center">

                <div class="col">
                    <s:form action="/Cliente/indexCliente" method="post">
                        <s:submit value="Gestión de clientes" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Vehiculo/indexVehiculo" method="post">
                        <s:submit value="Gestión de vehículos" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Empleado/indexEmpleado" method="post">
                        <s:submit value="Gestión de empleados" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Reserva/indexReserva" method="post">
                        <s:submit value="Gestión de reservas" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Inventario/indexInventario" method="post">
                        <s:submit value="Gestión de inventarios" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Concesionario/indexConcesionario" method="post">
                        <s:submit value="Gestión de concesionarios" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Pago/indexPago" method="post">
                        <s:submit value="Gestión de pagos" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>

                <div class="col">
                    <s:form action="/Transaccion/indexTransaccion" method="post">
                        <s:submit value="Gestión de transacciones" cssClass="btn btn-rojo w-100"/>
                    </s:form>
                </div>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <s:form action="volverInicio">
                    <s:submit value="Volver al inicio" cssClass="btn btn-outline-secondary" style="width: 150px; height: 45px;"/>
                </s:form>
            </div>
        </div>

        <jsp:include page="FOOTER.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
