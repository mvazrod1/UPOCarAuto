<%-- 
    Document   : modificarInventario
    Created on : 27-may-2025, 0:08:10
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Modificar Inventario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4" style="color: #c0392b;">Modificar Inventario</h2>

            <s:form action="actualizarInventario" method="post" cssClass="p-4 border rounded bg-light shadow-sm">

                <div class="mb-3">
                    <label class="form-label">ID Inventario:</label>
                    <s:textfield name="idInventario" value="%{inventario.idInventario}" readonly="true" theme="simple" cssClass="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">ID Concesionario:</label>
                    <s:textfield name="idConcesionario" value="%{inventario.concesionario.idConcesionario}" readonly="true" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="idConcesionario" cssClass="text-danger"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">DNI Empleado:</label>
                    <s:textfield name="dniEmpleado" value="%{inventario.empleado.dni}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="dniEmpleado" cssClass="text-danger"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Total de Vehículos:</label>
                    <s:textfield name="totalVehiculos" value="%{inventario.totalVehiculos}" readonly="true" type="number" theme="simple" cssClass="form-control"/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Fecha Actualización:</label>
                    <s:textfield name="ultimaActualizacionStr"
                                 value="%{#inventario.ultimaActualizacion?@java.text.SimpleDateFormat@new('yyyy-MM-dd').format(inventario.ultimaActualizacion)}"
                                 placeholder="YYYY-MM-DD"
                                 theme="simple"
                                 cssClass="form-control"/>
                    <s:fielderror fieldName="ultimaActualizacionStr" cssClass="text-danger"/>
                </div>

                <div class="d-flex justify-content-center gap-2 mt-4">
                    <s:submit value="Guardar Cambios" cssClass="btn-rojo"/>
                    <input type="button" value="Cancelar" class="btn btn-outline-secondary"
                           onclick="window.location.href = '<s:url action="indexInventario"/>'"/>
                </div>

                <s:actionerror cssClass="alert alert-danger mt-3"/>
            </s:form>
        </div>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

