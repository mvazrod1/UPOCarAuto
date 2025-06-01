<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Alta de Transacción</title>
        <meta charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body class="bg-light d-flex flex-column min-vh-100">

        <jsp:include page="../HEADER.jsp"/>

        <main class="flex-grow-1">
            <div class="container mt-5">
                <h2 class="text-center mb-4">Alta de Transacción</h2>

                <div class="w-50 mx-auto">
                    <s:actionerror cssClass="alert alert-danger"/>
                    <s:fielderror cssClass="alert alert-warning"/>

                    <s:form action="guardarTransaccion" method="post" cssClass="d-grid gap-3">

                        <s:textfield name="fechaTransaccion"
                                     label="Fecha de Transacción (dd/MM/yyyy)"
                                     cssClass="form-control"
                                     labelCssClass="form-label"/>

                        <s:textfield name="precio"
                                     label="Precio (€)"
                                     cssClass="form-control"
                                     labelCssClass="form-label"/>

                        <s:select name="metodoPago"
                                  label="Método de Pago"
                                  list="{'Tarjeta','Bizum','Transferencia'}"
                                  cssClass="form-select"
                                  labelCssClass="form-label"/>

                        <s:select name="estado"
                                  label="Estado"
                                  list="{'Pendiente','Completada','Cancelada'}"
                                  cssClass="form-select"
                                  labelCssClass="form-label"/>

                        <s:submit value="Guardar" cssClass="btn-rojo mt-3"/>
                    </s:form>

                    <div class="text-center mt-3">
                        <a href="<s:url action='indexTransaccion'/>" class="btn btn-outline-secondary">Volver al Listado</a>
                    </div>
                </div>
            </div>
        </main>

        <jsp:include page="../FOOTER.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
