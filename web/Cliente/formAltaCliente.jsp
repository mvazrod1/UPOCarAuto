<%-- 
    Document   : formAltaCliente
    Created on : 20-may-2025, 19:34:24
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario de Alta de Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Registro de nuevo cliente</h2>

            <s:form action="/Cliente/registrarCliente" method="post" cssClass="p-4 border rounded bg-light shadow-sm">
                <div class="mb-3">
                    <label for="dni" class="form-label">DNI:</label>
                    <s:textfield name="dni" id="dni" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="dni" cssClass="text-danger small"/>
                </div>
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <s:textfield name="nombre" id="nombre" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="nombre" cssClass="text-danger small"/>
                </div>
                <div class="mb-3">
                    <label for="apellidos" class="form-label">Apellidos:</label>
                    <s:textfield name="apellidos" id="apellidos" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="apellidos" cssClass="text-danger small"/>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <s:textfield name="email" id="email" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="email" cssClass="text-danger small"/>
                </div>
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <s:textfield name="telefono" id="telefono" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="telefono" cssClass="text-danger small"/>
                </div>
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <s:textfield name="direccion" id="direccion" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="direccion" cssClass="text-danger small"/>
                </div>

                <br/>
                <div class="d-flex justify-content-center mt-4">
                    <s:submit value="Registrar Cliente" cssClass="btn-rojo"/>
                    <s:reset value="Limpiar" cssClass="btn btn-secondary"/>
                </div>
            </s:form>
            <br/>
            <div class="d-flex justify-content-center mt-4">
                <s:form action="/Cliente/indexCliente" method="post">
                    <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                </s:form>
            </div>
            <jsp:include page="../FOOTER.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </div>
    </body>
</html>

