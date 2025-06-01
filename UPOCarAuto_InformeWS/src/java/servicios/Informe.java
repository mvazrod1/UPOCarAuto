/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servicios;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Javier
 */
@WebService(serviceName = "InformeService")
public class Informe {

    @WebMethod(operationName = "generarInformePago")
    public String generarInformePago(
        @WebParam(name = "idPago") int idPago,
        @WebParam(name = "idReserva") int idReserva,
        @WebParam(name = "fechaPago") String fechaPago,
        @WebParam(name = "precioTotal") String precioTotal,
        @WebParam(name = "metodoPago") String metodoPago,
        @WebParam(name = "estadoPago") String estadoPago
    ) {
        try {
            String nombreArchivo = "Informe_Pago_" + idPago + ".pdf";
            String ruta = System.getProperty("user.home") + "/Downloads/" + nombreArchivo;

            com.itextpdf.text.Document documento = new com.itextpdf.text.Document();
            com.itextpdf.text.pdf.PdfWriter.getInstance(documento, new java.io.FileOutputStream(ruta));
            documento.open();

            documento.addTitle("Informe de Pago");
            documento.add(new com.itextpdf.text.Paragraph("Informe de Pago generado"));
            documento.add(new com.itextpdf.text.Paragraph("---------------------------------------"));
            documento.add(new com.itextpdf.text.Paragraph("ID Pago: " + idPago));
            documento.add(new com.itextpdf.text.Paragraph("ID Reserva: " + idReserva));
            documento.add(new com.itextpdf.text.Paragraph("Fecha de Pago: " + fechaPago));
            documento.add(new com.itextpdf.text.Paragraph("Precio Total: " + precioTotal + " €"));
            documento.add(new com.itextpdf.text.Paragraph("Método de Pago: " + metodoPago));
            documento.add(new com.itextpdf.text.Paragraph("Estado: " + estadoPago));
            documento.add(new com.itextpdf.text.Paragraph("---------------------------------------"));
            documento.add(new com.itextpdf.text.Paragraph("Fecha de generación: " + new java.util.Date()));

            documento.close();

            return "Informe generado correctamente en: " + ruta;

        } catch (Exception e) {
            e.printStackTrace();
            return "Error al generar el informe: " + e.getMessage();
        }
    }
}

