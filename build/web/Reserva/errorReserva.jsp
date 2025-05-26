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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error al eliminar la reserva</title>
    </head>
    <body>
        <h1>Error al eliminar la reserva</h1>
    <s:if test="hasActionErrors()">
        <div style="color: red; font-weight: bold;">
            <s:actionerror />
        </div>
    </s:if>
    <s:form action="indexReserva" namespace="/Reserva" method="post">
        <button type="submit">Volver a la lista</button>
    </s:form>
</body>
</html>
