<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Detalles de la Transacción</title>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">

                <h2 class="text-center text-primary mb-4">Detalles de la Transacción</h2>

                <table class="table table-hover align-middle w-75 mx-auto text-center">
                    <tr><th>ID Transacción</th> <td><s:property value="transaccion.idTransaccion"/></td></tr>
                    <tr><th>Fecha</th>          <td><s:date name="transaccion.fechaTransaccion" format="yyyy-MM-dd"/></td></tr>
                    <tr><th>Precio (€)</th>     <td><s:property value="transaccion.precio"/></td></tr>
                    <tr><th>Método de Pago</th> <td><s:property value="transaccion.metodoPago"/></td></tr>
                    <tr><th>Estado</th>         <td><s:property value="transaccion.estado"/></td></tr>
                </table>

                <div class="text-center mt-4">
                    <form action="indexTransaccion.action" method="get">
                        <input type="submit" value="Volver al Listado de Transacciones" class="btn btn-outline-secondary" />
                    </form>
                </div>

            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
