<%-- 
    Document   : detallesInventario
    Created on : 26-may-2025, 19:17:18
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de Inventario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <s:actionerror/><br/>
        <div class="container my-5">
            <h2 class="text-danger mb-4">Detalles del Inventario</h2>
            <div class="mb-4">
                <div class="mb-2">
                    <label class="text-danger">Inventario (ID):</label>
                    <s:property value="inventario.idInventario"/>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Concesionario (ID):</label>
                    <s:property value="inventario.concesionario.idConcesionario"/>
                </div>
                <div class="mb-2">
                    <label class="text-danger">DNI Empleado:</label>
                    <s:property value="inventario.empleado.dni"/>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Total Vehículos:</label>
                    <s:property value="inventario.totalVehiculos"/>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Última Actualización:</label>
                    <s:property value="inventario.ultimaActualizacion"/>
                </div>
            </div>

            <div class="mt-4">
                <s:form action="/Inventario/indexInventario" method="get">
                    <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                </s:form>
            </div>
        </div>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

