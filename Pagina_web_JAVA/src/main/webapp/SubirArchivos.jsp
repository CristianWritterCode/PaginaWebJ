<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.MultipartConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
	@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10,  maxRequestSize = 1024 * 1024 * 50);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Resultado de la Subida</title>
</head>
<body>
<%
    String message = "El archivo ha sido subidi con exito";
    Part filePart = request.getPart("file"); // Obtiene el archivo subido
    if (filePart != null) {
        InputStream inputStream = null;
        Connection connection = null;
        try {
            // Obtén el contenido del archivo input stream
            inputStream = filePart.getInputStream();

            // Conectar a la base de datos
            String dbURL = "jdbc:mysql://localhost:3306/bbdd_pagwebjava";
            String dbUser = "root";
            String dbPass = "";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // Prepara la declaración SQL
            String sql = "INSERT INTO archivos_pdf (nombre, contenido) values (?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, filePart.getSubmittedFileName());
            if (inputStream != null) {
                statement.setBlob(2, inputStream);
            }

            // Ejecuta la inserción en la base de datos
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "El archivo ha sido subido y guardado en la base de datos con éxito.";
            }
        } catch (Exception e) {
            message = "ERROR: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
%>

<h3><%= message %></h3>
<a href="index.html">Volver a la página principal</a>
</body>
</html>
