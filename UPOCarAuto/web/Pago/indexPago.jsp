<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Listado de Pagos</title>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
        <script>
            function setSelectedId(inputId) {
                const selectedId = document.getElementById("idPago").value;
                document.getElementById(inputId).value = selectedId;
            }
        </script>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">
                <s:actionerror cssClass="alert alert-danger"/>

                <h2 class="mb-4 text-center">Listado de Pagos</h2>

                <table class="table table-hover align-middle text-center">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Reserva</th>
                            <th>Fecha</th>
                            <th>Precio Total</th>
                            <th>Método de Pago</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="lista" var="pago">
                            <tr>
                                <td><s:property value="#pago.idPago" /></td>
                                <td><s:property value="#pago.reserva.idReserva" /></td>
                                <td><s:property value="#pago.fechaPago" /></td>
                                <td><s:property value="#pago.precioTotal" /></td>
                                <td><s:property value="#pago.metodoPago" /></td>
                                <td><s:property value="#pago.estadoPago" /></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>

                <div class="mb-4 text-center">
                    <label for="idPago" class="form-label">Selecciona un pago:</label>
                    <select name="idPago" id="idPago" class="form-select w-50 mx-auto">
                        <s:iterator value="lista" var="p">
                            <option value="<s:property value="#p.idPago" />">
                                Pago #<s:property value="#p.idPago" /> - <s:property value="#p.metodoPago" />
                            </option>
                        </s:iterator>
                    </select>
                </div>

                <div class="d-flex flex-wrap justify-content-center gap-3 mb-4">
                    <form action="consultarPago.action" method="get">
                        <input type="hidden" name="idPago" id="consultarId" />
                        <input type="submit" value="Consultar" onclick="setSelectedId('consultarId')" class="btn-rojo" />
                    </form>

                    <form action="editarPago.action" method="post">
                        <input type="hidden" name="idPago" id="modificarId" />
                        <input type="submit" value="Modificar" onclick="setSelectedId('modificarId')" class="btn-rojo" />
                    </form>

                    <form action="eliminarPago.action" method="post" onsubmit="return confirm('¿Estás seguro de eliminar este pago?');">
                        <input type="hidden" name="idPago" id="eliminarId" />
                        <input type="submit" value="Eliminar" onclick="setSelectedId('eliminarId')" class="btn btn-danger" />
                    </form>
                </div>

                <div class="text-center mt-5">
                    <form action="altaPago.action" method="get">
                        <input type="submit" value="Nuevo Pago" class="btn-rojo" />
                    </form>
                    <br>
                    <s:url var="principalUrl" value="/principal.jsp"/>
                    <input type="button" value="Volver a la página principal"
                           class="btn btn-outline-secondary"
                           onclick="location.href = '${principalUrl}'"/>
                </div>
            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
