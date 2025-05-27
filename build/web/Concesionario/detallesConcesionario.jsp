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

        <div class="container mt-5">

            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Detalles del Concesionario</h2>

            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <tbody>
                        <tr><th scope="row">ID</th>        <td><s:property value="concesionario.idConcesionario"/></td></tr>
                        <tr><th scope="row">Nombre</th>    <td><s:property value="concesionario.nombre"/></td></tr>
                        <tr><th scope="row">Dirección</th> <td><s:property value="concesionario.direccion"/></td></tr>
                        <tr><th scope="row">Teléfono</th>  <td><s:property value="concesionario.telefono"/></td></tr>
                        <tr><th scope="row">Correo</th>    <td><s:property value="concesionario.correo"/></td></tr>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <s:form namespace="/Concesionario" action="indexConcesionario" method="get" cssClass="m-0">
                    <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                </s:form>
            </div>

        </div>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
