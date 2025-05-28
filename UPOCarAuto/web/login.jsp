<%-- 
    Document   : login
    Created on : 26-may-2025, 13:13:41
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body style="display: flex; flex-direction: column; min-height: 100vh; margin: 0;">
        <jsp:include page="HEADER.jsp" />

        <div style="flex: 1;">
            <s:actionerror cssClass="text-danger text-center mb-3"/>

            <div class="container mt-5">
                <main class="mx-auto" style="max-width: 500px;">
                    <s:form action="login" method="post" cssClass="p-4 border rounded bg-light shadow-sm">
                        <h1 class="mb-4">Introduce tus datos</h1>

                        <div class="mb-3">
                            <label for="dni" class="form-label">DNI:</label>
                            <s:textfield name="dni" id="dni" theme="simple" cssClass="form-control" placeholder="12345678A"/>
                            <s:fielderror fieldName="dni" cssClass="text-danger small"/>
                        </div>

                        <div class="mb-3">
                            <label for="contrasenya" class="form-label">Contraseña:</label>
                            <s:textfield name="contrasenya" id="contrasenya" theme="simple" cssClass="form-control" placeholder="Contraseña"/>
                            <s:fielderror fieldName="contrasenya" cssClass="text-danger small"/>
                        </div>

                        <div class="d-grid">
                            <s:submit value="Ingresar" name="btnLogin" cssClass="btn-rojo"/>
                        </div>
                    </s:form>

                    <p class="mt-3 text-center">
                        ¿No tienes cuenta? <a href="<s:url action='mostrarRegistro'/>">Registrarse</a>
                    </p>
                </main>
            </div>
            <s:actionmessage cssClass="text-success text-center mt-3"/>
        </div>

        <jsp:include page="FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


