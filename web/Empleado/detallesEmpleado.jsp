<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles del Empleado</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>

        <jsp:include page="../HEADER.jsp"/>

        <div class="container my-5">
            <h2 class="text-danger mb-4">Detalles del Empleado</h2>

            <div class="mb-4">
                <div class="mb-2">
                    <label class="text-danger">DNI:</label>
                    <span><s:property value="empleado.dni"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Nombre:</label>
                    <span><s:property value="empleado.nombre"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Apellidos:</label>
                    <span><s:property value="empleado.apellidos"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Email:</label>
                    <span><s:property value="empleado.email"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Teléfono:</label>
                    <span><s:property value="empleado.telefono"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Dirección:</label>
                    <span><s:property value="empleado.direccion"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Puesto:</label>
                    <span><s:property value="empleado.puesto"/></span>
                </div>
                <div class="mb-2">
                    <label class="text-danger">Contraseña:</label>
                    <span><s:property value="empleado.contrasenya"/></span>
                </div>
            </div>

            <h3 class="text-danger mb-3">Concesionario Asociado</h3>
            <s:if test="empleado.concesionario != null">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Correo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><s:property value="empleado.concesionario.idConcesionario"/></td>
                                <td><s:property value="empleado.concesionario.nombre"/></td>
                                <td><s:property value="empleado.concesionario.direccion"/></td>
                                <td><s:property value="empleado.concesionario.telefono"/></td>
                                <td><s:property value="empleado.concesionario.correo"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </s:if>
            <s:else>
                <p class="text-muted">Este empleado no está asociado a ningún concesionario.</p>
            </s:else>

            <div class="mt-4">
                <s:form namespace="/Empleado" action="indexEmpleado" method="get">
                    <s:submit value="Volver a la lista" cssClass="btn-rojo px-4"/>
                </s:form>
            </div>
        </div>

        <jsp:include page="../FOOTER.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

