<%-- 
    Document   : consultarCliente
    Created on : 20-may-2025, 12:08:24
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <s:form action="/Cliente/indexCliente" method="post"> 
    <s:submit value="Ejecutar Acción" />
</s:form>

</body>
</html>
