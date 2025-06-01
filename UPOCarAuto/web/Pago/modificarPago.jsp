<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Modificar Pago</title>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4">Modificar Pago</h2>

                <div class="w-50 mx-auto">
                    <s:actionerror cssClass="alert alert-danger" />
                    <s:fielderror cssClass="alert alert-warning" />

                    <s:form action="guardarModfPago" method="post" cssClass="d-grid gap-3">

                        <s:hidden name="idPago" />

                        <s:textfield name="idReserva"
                                     label="ID Reserva"
                                     value="%{idReserva}"
                                     cssClass="form-control"
                                     labelCssClass="form-label" />

                        <s:textfield name="fechaPago"
                                     label="Fecha de Pago"
                                     value="%{fechaPago}"
                                     cssClass="form-control"
                                     labelCssClass="form-label" />

                        <s:textfield name="precioTotal"
                                     label="Precio Total (€)"
                                     value="%{precioTotal}"
                                     cssClass="form-control"
                                     labelCssClass="form-label" />

                        <s:select name="metodoPago"
                                  label="Método de Pago"
                                  list="{'Efectivo','Tarjeta','Bizum'}"
                                  value="%{metodoPago}"
                                  cssClass="form-select"
                                  labelCssClass="form-label" />

                        <s:select name="estadoPago"
                                  label="Estado"
                                  list="{'Pendiente','Pagado','Cancelado'}"
                                  value="%{estadoPago}"
                                  cssClass="form-select"
                                  labelCssClass="form-label" />

                        <s:submit value="Guardar cambios" cssClass="btn-rojo mt-3" />
                    </s:form>

                    <div class="text-center mt-3">
                        <a href="<s:url action='indexPago'/>" class="btn btn-outline-secondary">Volver</a>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
