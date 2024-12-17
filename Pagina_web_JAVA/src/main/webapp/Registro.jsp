<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ page import="java.sql.*" %>

<%

	String nombre=request.getParameter("nombre");
	String apellido=request.getParameter("apellido");
	String email=request.getParameter("email");
	String emailReady=request.getParameter("emailReady");
	String contraseña=request.getParameter("contraseña");
	String contraseñaLista=request.getParameter("contraseñaLista");
	String edad=request.getParameter("edad");
	String terminos=request.getParameter("terminos");
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection miConexion=DriverManager.getConnection("jdbc:mysql://localhost:3306/bbdd_pagwebjava","root","");
	
	Statement miStatement=miConexion.createStatement();
	
	String instruccionSql="INSERT INTO registrousuario (nombre, apellido, correo, confirmar_Correo, contraseña, confirma_contraseña, fecha_de_cumpleaños, terminos_condiciones) VALUES ('" + nombre + "','" + apellido + "','" + email +"','" + emailReady + "','" + contraseña + "','" + contraseñaLista + "','"+ edad + "','" + terminos + "')";

	miStatement.executeUpdate(instruccionSql);
	
	out.println("Registrado con exito");
	
%>

</body>
</html>