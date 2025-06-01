<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Nuevo Vehículo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <!-- Errores globales de la acción -->
        <s:actionerror/>
        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4" style="color: #c0392b;">Registro de nuevo vehículo</h2>
            <s:form action="/Vehiculo/guardarVehiculo" method="post" cssClass="p-4 border rounded bg-light shadow-sm">
                <div class="mb-3">
                    <label for="dni" class="form-label">Matrícula:</label>
                    <s:textfield name="matricula" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="matricula" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Inventario (ID):</label>
                    <s:textfield name="idInventario" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="idInventario" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Marca:</label>
                    <s:textfield name="marca" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="marca" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Modelo:</label>
                    <s:textfield name="modelo" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="modelo" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Año:</label>
                    <s:textfield name="anio" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="anio" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Precio:</label>
                    <s:textfield name="precio" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="precio" cssClass="text-danger"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Estado:</label>
                    <s:select name="estado" theme="simple" cssClass="form-control" list="{'Nuevo','Usado','Reservado'}"/>
                </div>
                <div class="mb-3">
                    <label for="dni" class="form-label">Disponibilidad:</label>
                    <s:checkbox name="disponibilidad" fieldValue="true" theme="simple"/>
                </div>

                    <div class="d-flex justify-content-center mt-4">
                        <s:submit value="Registrar Vehículo" cssClass="btn-rojo"/>
                        <s:reset value="Limpiar" cssClass="btn btn-secondary"/>
                    </div>
                </s:form>
                <br/>
                <div class="d-flex justify-content-center mt-4">
                    <s:form action="/Vehiculo/indexVehiculo" method="post">
                        <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>
