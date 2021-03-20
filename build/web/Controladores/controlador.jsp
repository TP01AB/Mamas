<%@page import="Modelo.Email"%>
<%@page import="Auxiliar.passwordEncryption"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Usuario"%>
<%
//GENERALES------------------------------
    int intentos; // controlaremos los intentos de inicio de sesion

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

        Usuario usuarioActual = null;
        //Comprobamos las credenciales en BBDD.
        usuarioActual = Conexion.login(email, password);

        if (usuarioActual != null) {
            //Ahora vamos a poner el contador de intentos a 0 tras hacer un inicio correcto.
            Conexion.sumarIntento(email, 0);

            // Comprobamos si el email proporcionado esta activo.
            if (Conexion.isActive(email)) {
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

            } //usuario no activado
            else {
                session.setAttribute("mensaje", "Usuario desactivado,contacte con el administrador.");
                response.sendRedirect("../Vistas/login.jsp");
            }

        } else { //credenciales erroneas o no existentes en BD.
            intentos = Conexion.getIntentos(email);
            if (intentos < 3) {
                Conexion.sumarIntento(email, 1);
                intentos++;
                session.setAttribute("mensaje", "Contrase�a o e-mail erroneos, intentelo de nuevo.Intento numero:" + intentos + ".");
                response.sendRedirect("../Vistas/login.jsp");
            } else {
             //Enviar email
        String az = Integer.toString((int) (Math.random() * 9999999));

        //Env�a email con la contrase�a nueva
        Email em = new Email();
        String de = "auxiliardaw2@gmail.com";
        String clave = "Chubaca20";
        String para = request.getParameter("emailForget");
        String mensaje = "Nueva contrase�a: " + az + " \n Debido a superar el numero de intentos maximos , se ha procedido a modificar su contrase�a. Al iniciar sesion se le pedria un cambio de contrase�a.";
        String asunto = "Superado intentos de sesion-cambio de contrase�a.";
        em.enviarCorreo(de, clave, para, mensaje, asunto);

        //Asignar nueva contrase�a al usuario
        az = passwordEncryption.MD5(az);
        Conexion.modificarClave(para, az);

        session.setAttribute("mensaje", "Contrase�a enviada al e-mail proporcionado.");
        System.out.println("Email enviado correctamente a " + para);
        response.sendRedirect("../index.jsp");
            }
        }
    }

//Vista de Registro --------------------------------------------------    
    //REGISTRO
    if (request.getParameter("registrarseBD") != null) {

    }

// Vista de Contrase�a olvidadad -------------------------------------
    //CONTRASE�A OLVIDADA
    if (request.getParameter("passwordForget") != null) {
        //Enviar email
        String az = Integer.toString((int) (Math.random() * 9999999));

        //Env�a email con la contrase�a nueva
        Email em = new Email();
        String de = "auxiliardaw2@gmail.com";
        String clave = "Chubaca20";
        String para = request.getParameter("emailForget");
        String mensaje = "Nueva contrase�a: " + az + " \n  Como has solicitado se te envia una nueva contrase�a , la cual debe ser cambiada en el primer inicio de sesion.";
        String asunto = "Superado intentos de sesion-cambio de contrase�a.";
        em.enviarCorreo(de, clave, para, mensaje, asunto);

        //Asignar nueva contrase�a al usuario
        az = passwordEncryption.MD5(az);
        Conexion.modificarClave(para, az);

        session.setAttribute("mensaje", "Contrase�a enviada al e-mail proporcionado.");
        System.out.println("Email enviado correctamente a " + para);
        response.sendRedirect("../index.jsp");
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