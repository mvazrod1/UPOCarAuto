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
    </head>
    <body>

        <%--<jsp:include page="HEADER.jsp" />--%>

        <div>
            <div>
                <main>
                    <s:form action="login" method="post">
                        <h1>Introduce tus datos</h1>

                        <div>
                            <label for="dni">DNI:</label>
                            <s:textfield name="dni" id="dni" theme="simple" placeholder="12345678A"/>
                            <s:fielderror fieldName="dni"/>
                        </div>
                        <div>
                            <label for="contrasenya">Contraseña:</label>
                            <s:textfield name="contrasenya" id="contrasenya" theme="simple" placeholder="Contraseña"/>
                            <s:fielderror fieldName="contrasenya"/>
                        </div>

                        <div>
                            <s:submit value="Ingresar" name="btnLogin" />
                        </div>

                        <s:fielderror />
                    </s:form>

                    <p><a href="<s:url action='registrarForm'/>">Registrarse</a></p>
                </main>
            </div>
        </div>

        <s:actionmessage />

        <%--<jsp:include page="FOOTER.jsp" />--%>

    </body>
</html>

