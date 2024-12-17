<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verificar Usuario</title>
</head>
<body>

<%@ page import="java.sql.*" %>

<%

	String correo = request.getParameter("correo");
	String contraseña = request.getParameter("contraseña");
	
	try{

	Class.forName("com.mysql.cj.jdbc.Driver");
	
	Connection miConexion=DriverManager.getConnection("jdbc:mysql://localhost:3306/bbdd_pagwebjava","root","");
	
	String sql = "SELECT * FROM REGISTROUSUARIO WHERE CORREO=? AND CONTRASEÑA=?";
	PreparedStatement c_preparada=miConexion.prepareStatement(sql);
	
	c_preparada.setString(1, correo);
	c_preparada.setString(2, contraseña);
	
	ResultSet miResultset=c_preparada.executeQuery();
	
	if (miResultset.next()) {
        out.println("Usuario autorizado");
    } else{
        out.println("No hay usuario con esos datos");
    }
	
	miResultset.close();
	c_preparada.close();
	miConexion.close();
	
	} catch (Exception e){
		e.printStackTrace();
		out.println("Error en la conexion o consulta");
	}

%>

</body>
</html>