<%-- 
    Document   : modificarReserva
    Created on : 25-may-2025, 11:38:52
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Modificar Reserva</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />

        <div class="container mt-5">
            <h1 class="mb-4">Modificar Reserva</h1>

            <s:form action="/Reserva/guardarModfReserva" method="post" cssClass="row g-3">
                <div class="col-md-4">
                    <label for="idReserva" class="form-label">ID:</label>
                    <s:textfield name="idReserva" id="idReserva" readonly="true" cssClass="form-control" theme="simple"/>
                </div>

                <div class="col-md-4">
                    <label for="dni_cliente" class="form-label">DNI del Cliente:</label>
                    <s:textfield name="dni_cliente" id="dni_cliente" readonly="true" cssClass="form-control" theme="simple"/>
                </div>

                <div class="col-md-4">
                    <label for="matricula" class="form-label">Matrícula del Vehículo:</label>
                    <s:textfield name="matricula" id="matricula"readonly="true" cssClass="form-control" theme="simple"/>
                </div>

                <div class="col-md-6">
                    <label for="estado" class="form-label">Estado de la Reserva:</label>
                    <s:select name="estado" list="{'Pendiente','Confirmada','Rechazada'}" cssClass="form-select" theme="simple"/>
                    <s:fielderror fieldName="estado" cssClass="text-danger"/>
                </div>

                <div class="col-md-6">
                    <label for="fecha_creacion" class="form-label">Fecha de creación:</label>
                    <s:textfield name="fechaCreacionFormateada" type="date" readonly="true" cssClass="form-control" theme="simple"/>
                    <s:hidden name="fecha_creacion" value="%{fechaCreacionFormateada}" />
                </div>

                <div class="col-md-6">
                    <label for="fecha_recogida" class="form-label">Fecha de recogida:</label>
                    <s:textfield name="fecha_recogida" id="fecha_recogida" type="date" cssClass="form-control" theme="simple"/>
                    <s:fielderror fieldName="fecha_recogida" cssClass="text-danger"/>
                </div>

                <div>
                    <s:submit value="Guardar Cambios" cssClass="btn-rojo"/>
                </div>
                <input type="button" value="Cancelar" class="btn btn-secondary"
                       onclick="window.location.href = '<s:url action='indexReserva'/>'"/>

                <div class="col-12">
                    <s:actionerror cssClass="text-danger"/>
                </div>
            </s:form>
        </div>

        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

