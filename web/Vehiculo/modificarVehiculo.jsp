<%-- 
    Document   : modificarVehiculo
    Created on : 24-may-2025, 21:41:35
    Author     : maria
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Modificar Vehículo</title>
  </head>
  <body>

    <h2>Modificar Vehículo</h2>

    <s:form action="actualizarVehiculo" method="post">

      <s:textfield name="matricula"
                   label="Matrícula"
                   value="%{vehiculo.matricula}"
                   readonly="true"/>

      <s:textfield name="idInventario"
                   label="ID Inventario"
                   value="%{vehiculo.inventario.idInventario}"/>

      <s:textfield name="marca"
                   label="Marca"
                   value="%{vehiculo.marca}"/>

      <s:textfield name="modelo"
                   label="Modelo"
                   value="%{vehiculo.modelo}"/>

      <s:textfield name="anio"
                   label="Año"
                   value="%{vehiculo.anio}"/>

      <s:textfield name="precio"
                   label="Precio (€)"
                   value="%{vehiculo.precio}"/>

      <s:select name="estado"
                label="Estado"
                list="{'Nuevo','Usado','Reservado'}"
                value="%{vehiculo.estado}"/>

      <s:checkbox name="disponibilidad"
                  label="Disponible"
                  fieldValue="true"
                  checked="%{vehiculo.disponibilidad}"/>

      <br/><br/>
      <s:submit value="Guardar cambios"/>

    </s:form>
    <a href="<s:url action='indexVehiculo'/>">Volver</a>

  </body>
</html>
