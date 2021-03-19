<%@page import="Auxiliar.passwordEncryption"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Usuario"%>
<%
//GENERALES------------------------------
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
//Vista de Login ----------------------------------------------------
    //LOGIN
    if (request.getParameter("iniciarseBD") != null) {
        //Obtenemos los datos del formulario .
        String email = request.getParameter("emailLogin");
        String password = passwordEncryption.MD5(request.getParameter("passwordLogin")); //encriptacion por MD5
        
        // Comprobamos si el email proporcionado esta activo.
        if (Conexion.isActive(email)) {

            Usuario usuarioActual = null;
            //Comprobamos las credenciales en BBDD.
            usuarioActual = Conexion.login(email, password);
            if (usuarioActual != null) {
                //Obtenemos el rol del usuario por medio de su id_usuario
                usuarioActual.setRol(Conexion.getRol(usuarioActual.getId_user()));

                //redireccionamos a su inicio dependiendo de su rol.
                if (usuarioActual.getRol() == 1) {
                    //Rol de alumno
                    response.sendRedirect("../Vistas/inicioAlu.jsp");
                } else if (usuarioActual.getRol() == 2) {
                    //Rol de profesor
                    response.sendRedirect("../Vistas/inicioProf.jsp");
                } else if (usuarioActual.getRol() == 3) {
                    //Rol de administrador
                    response.sendRedirect("../Vistas/inicioAdmin.jsp");
                }

            } //credenciales erroneas o no existentes en BD.
            else {
                int intentos = (int) session.getAttribute("intentosLogin");
                if (intentos < 4) {
                }
                session.setAttribute("mensaje", "Contrase�a o e-mail erroneos, intentelo de nuevo.Intento numero:");
                session.setAttribute("intentosLogin", intentos + 1);
                response.sendRedirect("../Vistas/login.jsp");
            }

            response.sendRedirect("../index.jsp");

        } //usuario no activado
        else {
            session.setAttribute("mensaje", "Usuario desactivado,contacte con el administrador.");
            response.sendRedirect("../Vistas/login.jsp");
        }
    }

//Vista de Registro --------------------------------------------------    
    //REGISTRO
    if (request.getParameter("registrarseBD") != null) {

    }

// Vista de Contrase�a olvidadad -------------------------------------
    //CONTRASE�A OLVIDADA
    if (request.getParameter("passwordForget") != null) {

    }

//GENERALES ----------------------------------------------------------
    //VUELTA AL HOME
    if (request.getParameter("home") != null) {
        response.sendRedirect("../index.jsp");
    }

    // IR A CONTRASE�A OLVIDADA
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