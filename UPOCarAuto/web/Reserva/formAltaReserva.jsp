<%-- 
    Document   : formAltaReserva
    Created on : 24-may-2025, 2:39:01
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de Alta de Reserva</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4" style="color: var(--color-rojo);">Registro de nuevo cliente</h2>

                <s:form action="/Reserva/registrarReserva" method="post" cssClass="p-4 border rounded bg-light shadow-sm">
                    <div class="mb-3">
                        <label for="dni_cliente" class="form-label">DNI del Cliente:</label>
                        <s:select name="dni_cliente" id="dni_cliente"
                                  list="listaDnis" listKey="dni" listValue="dni"
                                  headerKey="" headerValue="-- Selecciona un cliente --" theme="simple" cssClass="form-select"/>
                        <s:fielderror fieldName="dni_cliente" cssClass="text-danger small"/>
                    </div>
                    <div class="mb-3">
                        <label for="matricula" class="form-label">Matrícula del Vehículo:</label>
                        <s:select name="matricula" id="matricula"
                                  list="listaMatriculas" listKey="matricula" listValue="matricula"
                                  headerKey="" headerValue="-- Selecciona un vehículo --" theme="simple" cssClass="form-select"/>
                        <s:fielderror fieldName="matricula" cssClass="text-danger small"/>
                    </div>
                    <div class="mb-3">
                        <label for="estado" class="form-label">Estado:</label>
                        <s:select name="estado"
                                  label="Estado de la Reserva"
                                  list="{'Pendiente','Confirmada','Rechazada'}" theme ="simple" cssClass="form-select"/>
                        <s:fielderror fieldName="estado" cssClass="text-danger small"/>
                    </div>
                    <div class="mb-3">
                        <label for="fecha_recogida" class="form-label">Fecha de recogida:</label>
                        <s:textfield name="fecha_recogida" id="fecha_recogida" type="date" theme="simple" cssClass="form-control"/>
                        <s:fielderror fieldName="fecha_recogida" cssClass="text-danger small"/>
                    </div>

                    <br/>
                    <div class="d-flex justify-content-center mt-4">
                        <s:submit value="Registrar Reserva" cssClass="btn-rojo"/>
                        <s:reset value="Limpiar" cssClass="btn btn-secondary"/>
                    </div>
                </s:form>
                <div class="d-flex justify-content-center mt-4">
                    <s:form action="/Reserva/indexReserva" method="post">
                        <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


