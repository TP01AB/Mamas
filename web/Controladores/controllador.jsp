<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Usuario"%>
<%
//Vista de Login ----------------------------------------------------
    //LOGIN
    if (request.getParameter("iniciarseBD") != null) {

    }

//Vista de Registro --------------------------------------------------    
    //REGISTRO
    if (request.getParameter("registrarseBD") != null) {

    }

// Vista de Contraseña olvidadad -------------------------------------

    //CONTRASEÑA OLVIDADA
    if (request.getParameter("enviarMail") != null) {

    }

//GENERALES ----------------------------------------------------------
    //VUELTA AL HOME
    if (request.getParameter("home") != null) {

    }

    // IR A CONTRASEÑA OLVIDADA
    if (request.getParameter("vistaOlvidada") != null) {

    }
    //IR A REGISTRO
    if (request.getParameter("vistaRegistro") != null) {

    }
    //IR A LOGIN
    if (request.getParameter("vistaLogin") != null) {

    }
%>