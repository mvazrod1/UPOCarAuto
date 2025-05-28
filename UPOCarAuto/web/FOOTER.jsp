<%-- 
    Document   : FOOTER
    Created on : 26-may-2025, 15:29:53
    Author     : marin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<footer class="container-fluid mt-5 py-3 border-top">
    <div class="text-center">
        <s:if test="%{#session.empleado != null}">
            <div class="mt-2">
                <p class="mb-0">
                    Concesionario: <strong><s:property value="#session.empleado.concesionario.nombre"/></strong>
                </p>
                <p class="mb-0">
                    Dirección: <s:property value="#session.empleado.concesionario.direccion"/>
                </p>
                <p class="mb-0">
                    Teléfono: <s:property value="#session.empleado.concesionario.telefono"/>
                </p>
            </div>
        </s:if>
        <br>
        <p>&copy; 2025 UPOCarAuto. Todos los derechos reservados.</p>
    </div>
</footer>
