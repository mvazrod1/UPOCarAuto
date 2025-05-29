<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Modificar Empleado</title>

        <!-- Bootstrap + hoja de estilos global -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>

        <div class="container mt-5">
            <h2 class="text-center mb-4" style="color: var(--color-rojo);">Modificar Empleado</h2>

            <s:url var="urlIndex" namespace="/Empleado" action="indexEmpleado"/>

            <s:form namespace="/Empleado" action="modificarEmpleado" method="post"
                    cssClass="p-4 border rounded bg-light shadow-sm">

                <!-- DNI (solo lectura) -->
                <div class="mb-3">
                    <label for="dni" class="form-label">DNI:</label>
                    <s:textfield name="dni" id="dni" theme="simple" readonly="true"
                                 cssClass="form-control-plaintext"/>
                    <s:fielderror fieldName="dni" cssClass="text-danger small"/>
                </div>

                <!-- Nombre -->
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre:</label>
                    <s:textfield name="nombre" id="nombre" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="nombre" cssClass="text-danger small"/>
                </div>

                <!-- Apellidos -->
                <div class="mb-3">
                    <label for="apellidos" class="form-label">Apellidos:</label>
                    <s:textfield name="apellidos" id="apellidos" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="apellidos" cssClass="text-danger small"/>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <s:textfield name="email" id="email" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="email" cssClass="text-danger small"/>
                </div>

                <!-- Teléfono -->
                <div class="mb-3">
                    <label for="telefono" class="form-label">Teléfono:</label>
                    <s:textfield name="telefono" id="telefono" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="telefono" cssClass="text-danger small"/>
                </div>

                <!-- Dirección -->
                <div class="mb-3">
                    <label for="direccion" class="form-label">Dirección:</label>
                    <s:textfield name="direccion" id="direccion" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="direccion" cssClass="text-danger small"/>
                </div>

                <!-- Puesto -->
                <div class="mb-3">
                    <label for="puesto" class="form-label">Puesto:</label>
                    <s:textfield name="puesto" id="puesto" theme="simple" cssClass="form-control"/>
                    <s:fielderror fieldName="puesto" cssClass="text-danger small"/>
                </div>

                <!-- Contraseña -->
                <div class="mb-3">
                    <label for="contrasenya" class="form-label">Contraseña:</label>
                    <s:textfield name="contrasenya" id="contrasenya" theme="simple"
                                cssClass="form-control" type="password"/>
                    <s:fielderror fieldName="contrasenya" cssClass="text-danger small"/>

                    <!-- Mostrar contraseña -->
                    <div class="form-check mt-2">
                        <input class="form-check-input" type="checkbox" id="mostrarContrasenya" onclick="toggleContrasenya()">
                        <label class="form-check-label" for="mostrarContrasenya">Mostrar contraseña</label>
                    </div>
                </div>

                <!-- Concesionario -->
                <div class="mb-3">
                    <label for="idConcesionario" class="form-label">Concesionario:</label>
                    <s:select name="idConcesionario" id="idConcesionario"
                              list="listaConcesionarios"
                              listKey="idConcesionario" listValue="nombre"
                              headerKey="" headerValue="-- Seleccione --"
                              theme="simple" cssClass="form-select"/>
                    <s:fielderror fieldName="idConcesionario" cssClass="text-danger small"/>
                </div>

                <!-- Botones -->
                <div class="d-flex justify-content-center gap-2 mt-4">
                    <s:submit value="Guardar Cambios" cssClass="btn-rojo"/>
                    <input type="button" value="Cancelar" class="btn btn-outline-secondary"
                           onclick="location.href = '${urlIndex}'"/>
                </div>

                <s:actionerror cssClass="alert alert-danger mt-3"/>
            </s:form>
        </div>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script type="text/javascript">
                               function toggleContrasenya() {
                                   var input = document.getElementById("contrasenya");
                                   input.type = (input.type === "password") ? "text" : "password";
                               }
        </script>
    </body>
</html>
