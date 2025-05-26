<%-- 
    Document   : HEADER
    Created on : 26-may-2025, 15:29:23
    Author     : marin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<header class="container-fluid">
    <div class="d-flex flex-wrap justify-content-between align-items-center px-4 py-3">
        
        <s:if test="%{#session.empleado == null}">
            <a href="${pageContext.request.contextPath}/index.jsp" class="d-flex justify-content-between align-items-center px-4">
                <img src="${pageContext.request.contextPath}/FOTOS/logo.png" alt="Logo UPOCarAuto" style="height: 150px;">
            </a>
        </s:if>

        <s:if test="%{#session.empleado != null}">
            <a href="<s:url action='volverInicio'/>" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
                <img src="${pageContext.request.contextPath}/FOTOS/logo.png" alt="Logo UPOCarAuto" style="height: 150px;">
            </a>
            <span class="mb-0">
                <i class="mb-0"></i> <s:property value="#session.empleado.nombre"/>
            </span>
            <ul class="nav nav-pills">
                <li class="nav-item p-1">
                    <a href="<s:url action='logout'/>" class="btn-rojo"><s:text name="Cerrar Sesión" /></a>
                </li>
            </ul>
        </s:if>

    </div>
</header>



