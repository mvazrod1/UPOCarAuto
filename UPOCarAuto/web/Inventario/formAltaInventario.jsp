<%-- 
    Document   : formAltaInventario
    Created on : 26-may-2025, 19:53:13
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Nuevo Inventario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4" style="color: var(--color-rojo);">Registro de nuevo inventario</h2>

                <s:actionerror cssClass="alert alert-danger"/>

                <s:form action="guardarInventario" method="post" cssClass="p-4 border rounded bg-light shadow-sm">

                    <div class="mb-3">
                        <label class="form-label">ID Concesionario:</label>
                        <s:textfield name="idConcesionario" theme="simple" cssClass="form-control"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">DNI Empleado:</label>
                        <s:textfield name="dniEmpleado" theme="simple" cssClass="form-control"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Fecha Actualización:</label>
                        <s:textfield name="ultimaActualizacionStr" placeholder="YYYY-MM-DD" theme="simple" cssClass="form-control"/>
                    </div>

                    <div class="d-flex justify-content-center mt-4">
                        <s:submit value="Registrar Inventario" cssClass="btn-rojo"/>
                        <s:reset value="Limpiar" cssClass="btn btn-secondary"/>
                    </div>
                </s:form>

                <div class="d-flex justify-content-center mt-4">
                    <s:form action="indexInventario" method="post">
                        <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

