<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Nuevo Vehículo</title>
  </head>
  <body>

    <!-- Errores globales de la acción -->
    <s:actionerror/>

    <h2>Alta de Vehículo</h2>
    
    <s:form action="guardarVehiculo" method="post">


      <s:textfield name="matricula"
                   label="Matrícula"/>



      <s:textfield name="idInventario"
                   label="ID Inventario"/>


      <s:textfield name="marca"
                   label="Marca"/>


      <s:textfield name="modelo"
                   label="Modelo"/>


      <s:textfield name="anio"
                   label="Año"/>


      <s:textfield name="precio"
                   label="Precio (€)"/>


      <s:select name="estado"
                label="Estado"
                list="{'Nuevo','Usado','Reservado'}"/>


      <s:checkbox name="disponibilidad"
                  label="Disponible"
                  fieldValue="true"/>

      <br/><br/>
      <s:submit value="Guardar"/>
      &nbsp;


    </s:form>
    <a href="<s:url action='indexVehiculo'/>">Volver</a>

  </body>
</html>
