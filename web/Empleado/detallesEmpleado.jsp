<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalles del Empleado</title>

    <!-- Bootstrap + hoja de estilos global -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
</head>
<body>

    <jsp:include page="../HEADER.jsp"/>

    <div class="container mt-5">

        <h2 class="text-center mb-4" style="color: var(--color-rojo);">Detalles del Empleado</h2>

        <div class="table-responsive">
            <table class="table table-bordered align-middle">
                <tbody>
                    <tr><th scope="row">DNI</th>          <td><s:property value="empleado.dni"/></td></tr>
                    <tr><th scope="row">Nombre</th>       <td><s:property value="empleado.nombre"/></td></tr>
                    <tr><th scope="row">Apellidos</th>    <td><s:property value="empleado.apellidos"/></td></tr>
                    <tr><th scope="row">Email</th>        <td><s:property value="empleado.email"/></td></tr>
                    <tr><th scope="row">Teléfono</th>     <td><s:property value="empleado.telefono"/></td></tr>
                    <tr><th scope="row">Dirección</th>    <td><s:property value="empleado.direccion"/></td></tr>
                    <tr><th scope="row">Puesto</th>       <td><s:property value="empleado.puesto"/></td></tr>
                    <tr><th scope="row">Contraseña</th>   <td><s:property value="empleado.contrasenya"/></td></tr>

                    <tr class="table-light"><th colspan="2" class="text-center">Concesionario Asociado</th></tr>

                    <s:if test="empleado.concesionario != null">
                        <tr><th scope="row">ID</th>        <td><s:property value="empleado.concesionario.idConcesionario"/></td></tr>
                        <tr><th scope="row">Nombre</th>    <td><s:property value="empleado.concesionario.nombre"/></td></tr>
                        <tr><th scope="row">Dirección</th> <td><s:property value="empleado.concesionario.direccion"/></td></tr>
                        <tr><th scope="row">Teléfono</th>  <td><s:property value="empleado.concesionario.telefono"/></td></tr>
                        <tr><th scope="row">Correo</th>    <td><s:property value="empleado.concesionario.correo"/></td></tr>
                    </s:if>
                    <s:else>
                        <tr>
                            <td colspan="2" class="text-center text-muted">
                                Este empleado no está asociado a ningún concesionario.
                            </td>
                        </tr>
                    </s:else>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-center mt-4">
            <s:form namespace="/Empleado" action="indexEmpleado" method="get" cssClass="m-0">
                <s:submit value="Volver a la lista" cssClass="btn btn-outline-secondary"/>
            </s:form>
        </div>

    </div>

    <jsp:include page="../FOOTER.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
