<%-- 
    Document   : principal
    Created on : 20-may-2025, 19:29:08
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Página principal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="HEADER.jsp" />
        <div class="container mt-5 text-center">
            <h1 class="mb-3" style="color: var(--color-rojo);">Bienvenido <s:property value="#session.empleado.nombre"/>. Puesto de <s:property value="#session.empleado.puesto"/></h1>
            <h2 class="mb-4">¿Qué acción deseas realizar?</h2>

            <div class="d-flex flex-column align-items-center gap-3" style="max-width: 300px; margin: auto;">
                <s:form action="/Cliente/indexCliente" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de clientes" cssClass="btn-rojo w-100"/>
                </s:form>

                <s:form action="/Vehiculo/indexVehiculo" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de vehículos" cssClass="btn-rojo w-100"/>
                </s:form>

                <s:form action="/Empleado/indexEmpleado" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de empleados" cssClass="btn-rojo w-100"/>
                </s:form>

                <s:form action="/Reserva/indexReserva" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de reservas" cssClass="btn-rojo w-100"/>
                </s:form>
                <s:form action="/Pago/indexPago" method="post" style="width: 100%;"> 
                    <s:submit value="Gestión de pagos" cssClass="btn-rojo w-100"/>
                </s:form>
                <s:form action="/Inventario/indexInventario" method="post"> 
                    <s:submit value="Gestión de inventarios" />
                </s:form>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <s:form action="volverInicio">
                    <s:submit value="Volver al inicio" cssClass="btn btn-outline-secondary"/>
                </s:form>
            </div>
        </div>
        <jsp:include page="FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

