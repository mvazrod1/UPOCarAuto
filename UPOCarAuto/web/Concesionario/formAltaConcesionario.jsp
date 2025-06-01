<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alta de Concesionario</title>

        <!-- Bootstrap + hoja de estilos global -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>
        <main class="flex-grow-1">
            <div class="container mt-5">

                <h2 class="text-center mb-4" style="color: var(--color-rojo);">Registro de nuevo concesionario</h2>

                <s:actionerror cssClass="alert alert-danger"/>
                <s:fielderror  cssClass="alert alert-danger"/>

                <s:form namespace="/Concesionario" action="registrarConcesionario" method="post"
                        cssClass="p-4 border rounded bg-light shadow-sm">

                    <!-- Nombre -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <s:textfield name="nombre" id="nombre" theme="simple" cssClass="form-control"/>
                        <s:fielderror fieldName="nombre" cssClass="text-danger small"/>
                    </div>

                    <!-- Dirección -->
                    <div class="mb-3">
                        <label for="direccion" class="form-label">Dirección:</label>
                        <s:textfield name="direccion" id="direccion" theme="simple" cssClass="form-control"/>
                        <s:fielderror fieldName="direccion" cssClass="text-danger small"/>
                    </div>

                    <!-- Teléfono -->
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono:</label>
                        <s:textfield name="telefono" id="telefono" theme="simple" cssClass="form-control"/>
                        <s:fielderror fieldName="telefono" cssClass="text-danger small"/>
                    </div>

                    <!-- Correo -->
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo:</label>
                        <s:textfield name="correo" id="correo" theme="simple" cssClass="form-control"/>
                        <s:fielderror fieldName="correo" cssClass="text-danger small"/>
                    </div>

                    <!-- Botones -->
                    <div class="d-flex justify-content-center gap-2 mt-4">
                        <s:submit value="Registrar Concesionario" cssClass="btn-rojo"/>
                        <s:reset  value="Limpiar" cssClass="btn btn-secondary"/>
                    </div>
                </s:form>

                <!-- Volver al listado -->
                <div class="d-flex justify-content-center mt-4">
                    <s:form namespace="/Concesionario" action="indexConcesionario" method="get" cssClass="m-0">
                        <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
                    </s:form>
                </div>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
