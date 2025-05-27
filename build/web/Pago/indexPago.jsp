<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Listado de Pagos</title>
    <script>
        function setSelectedId(inputId) {
            var selectedId = document.getElementById("idPago").value;
            document.getElementById(inputId).value = selectedId;
        }
    </script>
</head>
<body>

    <h2>Listado de Pagos</h2>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Reserva</th>
            <th>Fecha</th>
            <th>Precio Total</th>
            <th>Método de Pago</th>
            <th>Estado</th>
        </tr>

        <s:iterator value="lista" var="pago">
            <tr>
                <td><s:property value="#pago.idPago" /></td>
                <td><s:property value="#pago.reserva.idReserva" /></td>
                <td><s:property value="#pago.fechaPago" /></td>
                <td><s:property value="#pago.precioTotal" /></td>
                <td><s:property value="#pago.metodoPago" /></td>
                <td><s:property value="#pago.estadoPago" /></td>
            </tr>
        </s:iterator>
    </table>

    <br>

    <label for="idPago">Selecciona un pago:</label>
    <select name="idPago" id="idPago">
        <s:iterator value="lista" var="p">
            <option value="<s:property value="#p.idPago" />">
                Pago #<s:property value="#p.idPago" /> - <s:property value="#p.metodoPago" />
            </option>
        </s:iterator>
    </select>

    <br><br>

    <form action="consultarPago.action" method="get" style="display:inline;">
        <input type="hidden" name="idPago" id="consultarId" />
        <input type="submit" value="Consultar" onclick="setSelectedId('consultarId')" />
    </form>

    <form action="editarPago.action" method="post" style="display:inline;">
        <input type="hidden" name="idPago" id="modificarId" />
        <input type="submit" value="Modificar" onclick="setSelectedId('modificarId')" />
    </form>

    <form action="eliminarPago.action" method="post" style="display:inline;" onsubmit="return confirm('¿Estás seguro de eliminar este pago?');">
        <input type="hidden" name="idPago" id="eliminarId" />
        <input type="submit" value="Eliminar" onclick="setSelectedId('eliminarId')" />
    </form>

    <br><br>

    <form action="altaPago.action" method="get">
        <input type="submit" value="Nuevo Pago" />
    </form>

</body>
</html>
