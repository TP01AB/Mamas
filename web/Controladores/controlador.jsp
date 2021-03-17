<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Usuario"%>
<%
//Vista de Login ----------------------------------------------------
    //LOGIN
    if (request.getParameter("iniciarseBD") != null) {
        String email = request.getParameter("emailLogin");
        String password = request.getParameter("passwordLogin");

        if (Conexion.isActive(email)) { // Comprobamos si el email proporcionado esta activo.
            // if (Conexion.login(email, password) != null) {//Comprobamos las credenciales en BBDD.

            //}
            response.sendRedirect("../index.jsp");
        } else {
            
            response.sendRedirect("../Vistas/olvidada.jsp");
        }
    }

//Vista de Registro --------------------------------------------------    
    //REGISTRO
    if (request.getParameter("registrarseBD") != null) {

    }

// Vista de Contraseña olvidadad -------------------------------------
    //CONTRASEÑA OLVIDADA
    if (request.getParameter("passwordForget") != null) {

    }

//GENERALES ----------------------------------------------------------
    //VUELTA AL HOME
    if (request.getParameter("home") != null) {
        response.sendRedirect("../index.jsp");
    }

    // IR A CONTRASEÑA OLVIDADA
    if (request.getParameter("vistaOlvidada") != null) {
        response.sendRedirect("../Vistas/olvidada.jsp");
    }
    //IR A REGISTRO
    if (request.getParameter("vistaRegistro") != null) {
        response.sendRedirect("../Vistas/registro.jsp");
    }
    //IR A LOGIN
    if (request.getParameter("vistaLogin") != null) {
        response.sendRedirect("../Vistas/login.jsp");
    }
%>