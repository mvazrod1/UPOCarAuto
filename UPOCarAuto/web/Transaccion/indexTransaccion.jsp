<%-- 
    Document   : indexTransaccion
    Created on : 27-may-2025, 19:51:57
    Author     : teodo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Listado de Transacciones</title>
        <script>
            /* coloca en el hidden el id seleccionado en el <select> */
            function setSelectedId(inputId) {
                const id = document.getElementById("idTransaccion").value;
                document.getElementById(inputId).value = id;
            }
        </script>
    </head>
    <body>

        <s:actionerror/>

        <h2>Listado de Transacciones</h2>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Fecha</th>
                <th>Precio</th>
                <th>Método de Pago</th>
                <th>Estado</th>
            </tr>

            <s:iterator value="lista" var="t">
                <tr>
                    <td><s:property value="#t.idTransaccion"/></td>
                    <td><s:date name="#t.fechaTransaccion" format="yyyy-MM-dd"/></td>
                    <td><s:property value="#t.precio"/></td>
                    <td><s:property value="#t.metodoPago"/></td>
                    <td><s:property value="#t.estado"/></td>
                </tr>
            </s:iterator>
        </table>

        <br/>

       
        <label for="idTransaccion">Selecciona una transacción:</label>
        <select id="idTransaccion" name="idTransaccion">
            <s:iterator value="lista" var="t">
                <option value="<s:property value='#t.idTransaccion'/>">
                    Tx #<s:property value="#t.idTransaccion"/> – <s:property value="#t.metodoPago"/>
                </option>
            </s:iterator>
        </select>

        <br/><br/>

        
        <form action="consultarTransaccion.action" method="get" style="display:inline;">
            <input type="hidden" name="idTransaccion" id="consultId"/>
            <input type="submit" value="Consultar" onclick="setSelectedId('consultId')"/>
        </form>

        <form action="editarTransaccion.action" method="post" style="display:inline;">
            <input type="hidden" name="idTransaccion" id="editId"/>
            <input type="submit" value="Modificar" onclick="setSelectedId('editId')"/>
        </form>

        <form action="eliminarTransaccion.action" method="post" style="display:inline;"
              onsubmit="return confirm('¿Estás seguro de eliminar esta transacción?');">
            <input type="hidden" name="idTransaccion" id="delId"/>
            <input type="submit" value="Eliminar" onclick="setSelectedId('delId')"/>
        </form>

        <br/><br/>

       
        <form action="altaTransaccion.action" method="get">
            <input type="submit" value="Nueva Transacción"/>
        </form>

    </body>
</html>
