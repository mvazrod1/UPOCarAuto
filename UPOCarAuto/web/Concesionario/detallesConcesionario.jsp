<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles del Concesionario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>

        <div class="container my-5">
            <h2 class="text-danger mb-4">Detalles del Concesionario</h2>

            <div class="mb-4">
                <div class="mb-2">
                    <label class="text-danger">ID:</label>
                    <span><s:property value="concesionario.idConcesionario"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Nombre:</label>
                    <span><s:property value="concesionario.nombre"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Dirección:</label>
                    <span><s:property value="concesionario.direccion"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Teléfono:</label>
                    <span><s:property value="concesionario.telefono"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Correo:</label>
                    <span><s:property value="concesionario.correo"/></span>
                </div>
            </div>

            <div class="mt-4">
                <s:form namespace="/Concesionario" action="indexConcesionario" method="get">
                    <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                </s:form>
            </div>
        </div>

        <jsp:include page="../FOOTER.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

