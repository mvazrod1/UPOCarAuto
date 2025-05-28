<%-- 
    Document   : modificarVehiculo
    Created on : 24-may-2025, 21:41:35
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Modificar Vehículo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Modificar Vehículo</h2>

            <s:form action="actualizarVehiculo" method="post" cssClass="p-4 border rounded bg-light shadow-sm">
                <div class="mb-3">
                    <label for="dni" class="form-label">Matrícula:</label>
                    <s:textfield name="matricula" theme="simple" value="%{vehiculo.matricula}" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Inventario (ID):</label>
                    <s:textfield name="idInventario" value="%{vehiculo.inventario.idInventario}" theme="simple" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Marca:</label>
                    <s:textfield name="marca" theme="simple" value="%{vehiculo.marca}" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Modelo:</label>
                    <s:textfield name="modelo" theme="simple" value="%{vehiculo.modelo}" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Año:</label>
                    <s:textfield name="anio" theme="simple" value="%{vehiculo.anio}" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Precio (€):</label>
                    <s:textfield name="precio" theme="simple" value="%{vehiculo.precio}" cssClass="form-control"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Estado:</label>
                    <s:select name="estado" theme="simple"  value="%{vehiculo.estado}" cssClass="form-control" list="{'Nuevo','Usado','Reservado'}"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Disponibilidad:</label>
                    <s:checkbox name="disponibilidad" fieldValue="true" checked="%{vehiculo.disponibilidad}" theme="simple"/>
                </div>
                <div class="d-flex justify-content-center gap-2 mt-4">
                    <s:submit value="Guardar Cambios" cssClass="btn-rojo"/>
                    <input type="button" value="Cancelar" class="btn btn-outline-secondary"
                           onclick="window.location.href = '<s:url action="indexVehiculo"/>'"/>
                </div>
                <s:actionerror cssClass="alert alert-danger mt-3"/>
            </s:form>
        </div>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
