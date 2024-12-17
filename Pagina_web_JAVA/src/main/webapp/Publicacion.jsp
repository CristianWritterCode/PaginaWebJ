<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.MultipartConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Resultado de la Publicación</title>
</head>
<body>
<%
    String message = "Se ha subido con exito tu publicacion a la pagina:";
    String id = request.getParameter("id");
    String titulo = request.getParameter("titulo");
    String resumen = request.getParameter("resumen");
    String fecha = request.getParameter("fecha");
    String etiquetas = request.getParameter("etiquetas");

    Part imagenPart = request.getPart("imagen");
    Part pdfPart = request.getPart("pdf");

    InputStream imagenStream = null;
    InputStream pdfStream = null;

    if (imagenPart != null) {
        imagenStream = imagenPart.getInputStream();
    }
    if (pdfPart != null) {
        pdfStream = pdfPart.getInputStream();
    }

    Connection conn = null;
    try {
        // Conectar a la base de datos
        String dbURL = "jdbc:mysql://localhost:3306/bbdd_pagwebjava";
        String dbUser = "root";
        String dbPass = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Preparar la declaración SQL
        String sql = "INSERT INTO publicaciones (id, titulo, resumen, fecha, imagen, pdf, etiquetas) values (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setInt(1, Integer.parseInt(id));
        statement.setString(2, titulo);
        statement.setString(3, resumen);
        statement.setDate(4, java.sql.Date.valueOf(fecha));
        if (imagenStream != null) {
            statement.setBlob(5, imagenStream);
        } else {
            statement.setNull(5, java.sql.Types.BLOB);
        }
        if (pdfStream != null) {
            statement.setBlob(6, pdfStream);
        } else {
            statement.setNull(6, java.sql.Types.BLOB);
        }
        statement.setString(7, etiquetas);

        // Ejecutar la inserción en la base de datos
        int row = statement.executeUpdate();
        if (row > 0) {
            message = "La publicación ha sido guardada exitosamente.";
        }
    } catch (Exception e) {
        message = "ERROR: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    out.println("<h3>" + message + "</h3>");
%>
<a href="index.html">Volver a la página principal</a>
</body>
</html>