<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Listado de Transacciones</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
        <script>
            function setSelectedId(inputId) {
                const id = document.getElementById("idTransaccion").value;
                document.getElementById(inputId).value = id;
            }
        </script>
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="mb-4">Transacciones Registradas</h2>

                <s:actionerror cssClass="alert alert-danger"/>

                <s:form id="transaccionForm" method="post">
                    <input type="hidden" id="idSeleccionado" name="idTransaccion"/>

                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Precio</th>
                                <th>Método de Pago</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:iterator value="lista" var="t">
                                <tr>
                                    <td><s:property value="#t.idTransaccion"/></td>
                                    <td><s:date name="#t.fechaTransaccion" format="yyyy-MM-dd"/></td>
                                    <td><s:property value="#t.precio"/></td>
                                    <td><s:property value="#t.metodoPago"/></td>
                                    <td><s:property value="#t.estado"/></td>
                                </tr>
                            </s:iterator>
                            <s:if test="lista == null || lista.isEmpty()">
                                <tr>
                                    <td colspan="5" class="text-center">-- Sin resultados --</td>
                                </tr>
                            </s:if>
                        </tbody>
                    </table>

                    <div class="text-center mb-4">
                        <label for="idTransaccion" class="form-label">Selecciona una transacción:</label>
                        <select id="idTransaccion" name="idTransaccion" class="form-select w-50 mx-auto">
                            <s:iterator value="lista" var="t">
                                <option value="<s:property value='#t.idTransaccion'/>">
                                    Tx #<s:property value="#t.idTransaccion"/> – <s:property value="#t.metodoPago"/>
                                </option>
                            </s:iterator>
                        </select>
                    </div>

                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <input type="button" value="Consultar Transacción"
                               class="btn-rojo" onclick="setSelectedId('consultId'); enviarAccion('consultarTransaccion.action')"/>

                        <input type="button" value="Modificar Transacción"
                               class="btn-rojo" onclick="setSelectedId('editId'); enviarAccion('editarTransaccion.action')"/>

                        <input type="button" value="Eliminar Transacción"
                               class="btn btn-danger"
                               onclick="if(confirm('¿Estás seguro de eliminar esta transacción?')) { setSelectedId('delId'); enviarAccion('eliminarTransaccion.action'); }"/>
                    </div>
                </s:form>

                <div class="text-center mt-5">
                    <s:form action="altaTransaccion" method="get" theme="simple">
                        <s:submit value="Nueva Transacción" cssClass="btn-rojo me-2"/>
                    </s:form>
                    <br>
                    <s:url var="principalUrl" value="/principal.jsp"/>
                    <input type="button" value="Volver a la página principal"
                           class="btn btn-outline-secondary mt-2"
                           onclick="location.href = '${principalUrl}'"/>
                </div>
            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function enviarAccion(url) {
                const form = document.getElementById("transaccionForm");
                form.action = url;
                form.submit();
            }
        </script>
    </body>
</html>
