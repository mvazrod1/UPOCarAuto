<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalles del Pago</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="mb-4 text-center">Detalles del Pago</h2>

                <table class="table table-bordered w-50 mx-auto text-center align-middle">
                    <tr><th>ID del Pago</th><td><s:property value="pago.idPago" /></td></tr>
                    <tr><th>ID de Reserva</th><td><s:property value="pago.reserva.idReserva" /></td></tr>
                    <tr><th>Fecha de Pago</th><td><s:property value="pago.fechaPago" /></td></tr>
                    <tr><th>Precio Total</th><td><s:property value="pago.precioTotal" /></td></tr>
                    <tr><th>Método de Pago</th><td><s:property value="pago.metodoPago" /></td></tr>
                    <tr><th>Estado del Pago</th><td><s:property value="pago.estadoPago" /></td></tr>
                </table>

                <div class="text-center mt-4">
                    <form action="indexPago.action" method="get">
                        <input type="submit" value="Volver al Listado de Pagos" class="btn btn-outline-secondary" />
                    </form>
                </div>
            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
