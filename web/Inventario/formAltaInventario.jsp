<%-- 
    Document   : formAltaInventario
    Created on : 26-may-2025, 19:53:13
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Nuevo Inventario</title>
  </head>
  <body>

    <!-- Errores globales de la acción -->
    <s:actionerror/>

    <h2>Alta de Inventario</h2>
    
    <s:form action="guardarInventario" method="post">
      
      <!-- Selección de concesionario por su ID -->
      <s:textfield name="idConcesionario"
                   label="ID Concesionario"/>

      <!-- DNI del empleado responsable -->
      <s:textfield name="dniEmpleado"
                   label="DNI Empleado"/>

      <!-- Fecha de última actualización -->
      <s:textfield name="ultimaActualizacionStr"
                   label="Fecha Actualización"
                   placeholder="YYYY-MM-DD"/>

      <br/><br/>
      <s:submit value="Guardar"/>
    </s:form>
    <a href="<s:url action='indexInventario'/>">Volver</a>

  </body>
</html>
