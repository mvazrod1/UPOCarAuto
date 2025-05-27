<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Página principal</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../CSS/general.css">
    </head>
    <body>

        <jsp:include page="HEADER.jsp"/>

        <div class="container mt-5 text-center">
            <h1 class="mb-3" style="color: var(--color-rojo);">
                Bienvenido <s:property value="#session.empleado.nombre"/>.<br/>
                Puesto de <s:property value="#session.empleado.puesto"/>
            </h1>

            <h2 class="mb-4">¿Qué acción deseas realizar?</h2>

            <div class="d-flex flex-column align-items-center" style="max-width: 300px; margin: 0 auto; gap: 1rem;">
                <s:form action="/Cliente/indexCliente" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de clientes" cssClass="btn btn-rojo"/>
                </s:form>

                <s:form action="/Vehiculo/indexVehiculo" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de vehículos" cssClass="btn btn-rojo"/>
                </s:form>

                <s:form action="/Empleado/indexEmpleado" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de empleados" cssClass="btn btn-rojo"/>
                </s:form>

                <s:form action="/Reserva/indexReserva" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de reservas" cssClass="btn btn-rojo"/>
                </s:form>

                <s:form action="/Inventario/indexInventario" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de inventarios" cssClass="btn btn-rojo"/>
                </s:form>

                <s:form action="/Concesionario/indexConcesionario" method="post" style="width:100%;">
                    <s:submit value="Gestión de concesionarios" cssClass="btn-rojo w-100"/>
                </s:form>
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
