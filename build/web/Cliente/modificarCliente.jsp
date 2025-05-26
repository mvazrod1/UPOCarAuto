<%-- 
    Document   : modificarCliente
    Created on : 20-may-2025, 22:28:14
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Modificar Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />

        <div class="container my-5">
            <h2 class="mb-4">Modificar Cliente</h2>

            <s:form action="/Cliente/guardarModfCliente" method="post" cssClass="row g-3">
                <div class="col-md-4">
                    <label for="dni" class="form-label">DNI:</label>
                    <s:textfield name="dni" id="dni" value="%{cliente.dni}" theme="simple" cssClass="form-control" readonly="true"/>
                    <s:fielderror fieldName="dni" cssClass="text-danger small"/>
                </div>

                <div class="col-md-4">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <s:textfield name="nombre" id="nombre" value="%{cliente.nombre}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="nombre" cssClass="text-danger"/>
                </div>

                <div class="col-md-4">
                    <label for="apellidos" class="form-label">Apellidos:</label>
                    <s:textfield name="apellidos" id="apellidos" value="%{cliente.apellidos}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="apellidos" cssClass="text-danger"/>
                </div>

                <div class="col-md-4">
                    <label for="email" class="form-label">Email:</label>
                    <s:textfield name="email" id="email" value="%{cliente.email}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="email" cssClass="text-danger"/>
                </div>

                <div class="col-md-4">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <s:textfield name="telefono" id="telefono" value="%{cliente.telefono}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="telefono" cssClass="text-danger"/>
                </div>

                <div class="col-md-4">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <s:textfield name="direccion" id="direccion" value="%{cliente.direccion}" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="direccion" cssClass="text-danger"/>
                </div>

                <div class="d-flex justify-content-center gap-3 mt-4">
                    <s:submit value="Guardar Cambios" cssClass="btn-rojo"/>
                    <input type="button" value="Cancelar" class="btn btn-secondary"
                           onclick="window.location.href = '<s:url action="indexCliente"/>'"/>
                </div>

                <s:actionerror cssClass="text-danger"/>
            </s:form>
        </div>

        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



