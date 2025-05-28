<%-- 
    Document   : index
    Created on : 26-may-2025, 12:54:16
    Author     : marin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inicio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/general.css">
    </head>
    <body style="display: flex; flex-direction: column; min-height: 100vh; margin: 0;">
        <jsp:include page="HEADER.jsp" />

        <div style="flex: 1;">
            <div class="row mt-2 text-center">
                <h1>¡BIENVENIDO!</h1>
                <div class="container-fluid">
                    <div class="row">
                        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000" data-bs-wrap="true">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="${pageContext.request.contextPath}/FOTOS/concesionario.jpg" class="d-block w-100" alt="Concesionario 1" style="object-fit: contain; height: 400px;">
                                </div>
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/FOTOS/mecanico.jpg" class="d-block w-100" alt="Concesionario 2" style="object-fit: contain; height: 400px;">
                                </div>
                                <div class="carousel-item">
                                    <img src="${pageContext.request.contextPath}/FOTOS/vendedor.jpg" class="d-block w-100" alt="Concesionario 3" style="object-fit: contain; height: 400px;">
                                </div>

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Registro y login -->
            <div style="margin-top: 40px; display: flex; justify-content: space-around;">
                <div style="width: 45%; text-align: center;">
                    <h2>¿Ya eres empleado de UPOCarAuto?</h2>
                    <a href="<s:url action='loginForm'/>" class="btn-rojo">
                        <s:text name="Iniciar Sesión" />
                    </a>
                </div>
                <div style="width: 45%; text-align: center;">
                    <h2>¿Aún no te has registrado como empleado?</h2>
                    <a href="<s:url action='mostrarRegistro'/>"class="btn-rojo">
                        <s:text name="Registrar" />
                    </a>   
                </div>
            </div>
        </div>
        <s:actionmessage />
        <jsp:include page="FOOTER.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
