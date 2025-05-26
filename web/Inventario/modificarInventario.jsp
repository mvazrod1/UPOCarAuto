<%-- 
    Document   : modificarInventario
    Created on : 27-may-2025, 0:08:10
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Modificar Inventario</title>
  </head>
  <body>

    <!-- Mensajes de error / validación -->
    <s:actionerror/>

    <h2>Modificar Inventario</h2>

    <!-- El Action que guarda los cambios está configurado en struts.xml
         como  actualizarInventario  (método guardarModificacion)          -->
    <s:form action="actualizarInventario" method="post">

      <!-- Clave primaria: solo lectura -->
      <s:textfield name="idInventario"
                   label="ID Inventario"
                   value="%{inventario.idInventario}"
                   readonly="true"/>

      <!-- Concesionario al que pertenece -->
      <s:textfield name="idConcesionario"
                   label="ID Concesionario"
                   value="%{inventario.concesionario.idConcesionario}"
                   readonly="true"/>

      <!-- Empleado responsable  -->
      <s:textfield name="dniEmpleado"
                   label="DNI Empleado"
                   value="%{inventario.empleado.dni}"/>

      <!-- Número total de vehículos  -->
      <s:textfield name="totalVehiculos"
                   label="Total de Vehículos"
                   type="number"
                   value="%{inventario.totalVehiculos}"
                   readonly="true"/>

      <!-- Última actualización (se pasa / recibe como String YYYY-MM-DD) -->
      <s:textfield name="ultimaActualizacionStr"
                   label="Fecha Actualización"
                   value="%{#inventario.ultimaActualizacion?@java.text.SimpleDateFormat@new('yyyy-MM-dd').format(inventario.ultimaActualizacion)}"
                   placeholder="YYYY-MM-DD"/>

      <br/><br/>
      <s:submit value="Guardar cambios"/>

    </s:form>

    <a href="<s:url action='indexInventario'/>">Volver</a>

  </body>
</html>
