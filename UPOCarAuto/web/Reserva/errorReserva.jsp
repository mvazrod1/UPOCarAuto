<%-- 
    Document   : errorReserva
    Created on : 25-may-2025, 18:23:47
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Error al eliminar la reserva</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body>
        <jsp:include page="../HEADER.jsp" />
        <main class="flex-grow-1">
            <div class="container my-5">
                <div class="alert alert-danger">
                    <h1 class="text-danger">Error al eliminar la reserva</h1>
                </div>

                <s:if test="hasActionErrors()">
                    <div class="alert alert-warning">
                        <s:actionerror />
                    </div>
                </s:if>

                <s:form action="indexReserva" namespace="/Reserva" method="post">
                    <s:submit value="Volver a la lista" cssClass="btn-rojo mt-3"/>
                </s:form>
            </div>
        </main>
        <jsp:include page="../FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

