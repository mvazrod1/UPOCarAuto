<%-- 
    Document   : HEADER
    Created on : 26-may-2025, 15:29:23
    Author     : marin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<header class="container-fluid position-relative" style="height: 80px; overflow: visible;">

    <div class="d-flex flex-wrap justify-content-between align-items-center px-4 py-1" style="height: 80px;">

        <s:if test="%{#session.empleado == null}">
            <a href="${pageContext.request.contextPath}/index.jsp" class="position-relative w-100 d-flex justify-content-center">
                <img src="${pageContext.request.contextPath}/FOTOS/logo.png" alt="Logo UPOCarAuto" 
                     style="height: 120px; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
            </a>
        </s:if>

        <s:if test="%{#session.empleado != null}">
            <a href="<s:url action='volverInicio'/>" class="d-flex align-items-center mb-0 me-md-auto link-body-emphasis text-decoration-none position-relative" style="height: 80px; min-width: 120px;">
                <img src="${pageContext.request.contextPath}/FOTOS/logo.png" alt="Logo UPOCarAuto" 
                     style="height: 120px; position: relative; top: 50%; transform: translateY(-50%);">
            </a>
            <div class="d-flex align-items-center" style="gap: 0;">
                <a href="<s:url action='/Empleado/consultarEmpleado'>
                       <s:param name='dni' value='#session.empleado.dni'/>
                   </s:url>" 
                   class="text-decoration-none me-2" 
                   style="font-size: 1rem; line-height: 1.2; color: inherit; white-space: nowrap;">
                    <s:property value="#session.empleado.nombre"/>
                </a>
                <ul class="nav nav-pills mb-0" style="margin: 0;">
                    <li class="nav-item p-1">
                        <a href="<s:url action='logout'/>" class="btn-rojo" style="padding: 6px 12px; font-size: 0.9rem;">
                            <s:text name="Cerrar Sesión" />
                        </a>
                    </li>
                </ul>
            </div>
        </s:if>

    </div>
</header>


