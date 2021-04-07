<%@page import="Modelo.Convalidacion"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="Modelo.Estudiante"%>
<%@page import="Modelo.Profesor"%>
<%@page import="java.sql.Date"%>
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

        intentos = Conexion.getIntentos(email);
        Usuario usuarioActual = null;
        //Comprobamos las credenciales en BBDD.
        usuarioActual = Conexion.login(email, password);
        
        if (usuarioActual != null) {
            //Ahora vamos a poner el contador de intentos a 0 tras hacer un inicio correcto.
            Conexion.sumarIntento(email, 0);
            if (intentos > 2) {
                session.setAttribute("email", email);
                //dirigimos al usuario a la pantalla donde se le obligara a cambiar de contraseña.
                response.sendRedirect("../Vistas/cambioContra.jsp");
            }

            // Comprobamos si el email proporcionado esta activo.
            if (Conexion.isActive(email)) {
                //Obtenemos el rol del usuario por medio de su id_usuario
                usuarioActual.setRol(Conexion.getRol(usuarioActual.getId_user()));
                usuarioActual = Conexion.getPerfil(usuarioActual);
                
                LinkedList<Ciclo> ciclos = Conexion.getCiclosCompletos();
                session.setAttribute("ciclosCompletos", ciclos);
                //redireccionamos a su inicio dependiendo de su rol.
                if (usuarioActual.getRol() == 1) {
                    //Rol de alumno
                    session.setAttribute("rolActual", 1);
                    Estudiante e = new Estudiante(usuarioActual.getId_user(), usuarioActual.getEmail(), usuarioActual.getPassword(), usuarioActual.getIntentos());
                    e = (Estudiante) Conexion.getPerfil(e);
                    Ciclo c = Conexion.getCicloAlumno(e.getId_user());
                    if (c == null) {
                        int idCiclo = Conexion.estoyMatriculado(e.getId_user());
                        if (idCiclo != -1) {
                            session.setAttribute("idCicloListaEspera", idCiclo);
                            session.setAttribute("numeroListaEspera", Conexion.getNumeroListaEspera(idCiclo, e.getId_user()));
                        }
                    }
                    e.setCiclo(c);
                    session.setAttribute("usuarioActual", e);
                    response.sendRedirect("../Vistas/inicioAlu.jsp");
                } else if (usuarioActual.getRol() == 2) {
                    //Rol de profesor
                    session.setAttribute("rolActual", 2);
                    Profesor p = new Profesor(usuarioActual.getId_user(), usuarioActual.getEmail(), usuarioActual.getPassword(), usuarioActual.getIntentos());
                    p = (Profesor) Conexion.getPerfil(p);
                    LinkedList<Ciclo> Ciclos = Conexion.getCiclosProfesor(p.getId_user());
                    
                    p.setCiclos(Ciclos);
                    session.setAttribute("usuarioActual", p);
                    response.sendRedirect("../Vistas/inicioProf.jsp");
                } else if (usuarioActual.getRol() == 3) {

                    //Rol de administrador
                    session.setAttribute("rolActual", 3);
                    LinkedList<Profesor> profesores = Conexion.getProfesores();
                    session.setAttribute("profesores", profesores);
                    LinkedList<Estudiante> alumnos = Conexion.getEstudiantes();
                    session.setAttribute("estudiantes", alumnos);
                    LinkedList<Convalidacion> convalidaciones = Conexion.getConvalidaciones();
                    session.setAttribute("convalidaciones", convalidaciones);
                    session.setAttribute("usuarioActual", usuarioActual);
                    response.sendRedirect("../Vistas/inicioAdmin.jsp");
                    
                }
                
            } //usuario no activado
            else {
                session.setAttribute("mensaje", "Usuario desactivado,contacte con el administrador.");
                response.sendRedirect("../Vistas/login.jsp");
            }
            
        } else { //credenciales erroneas o no existentes en BD.

            if (intentos < 3) {
                Conexion.sumarIntento(email, 1);
                intentos++;
                session.setAttribute("mensaje", "Contraseña o e-mail erroneos, intentelo de nuevo.Intento numero:" + intentos + ".");
                response.sendRedirect("../Vistas/login.jsp");
            } else {
                //Enviar email
                String az = Integer.toString((int) (Math.random() * 9999999));

                //Envía email con la contraseña nueva
                Email em = new Email();
                String para = email;
                String mensaje = "Nueva contraseña: " + az + " \n Debido a superar el numero de intentos maximos , se ha procedido a modificar su contraseña. Al iniciar sesion se le pedria un cambio de contraseña.";
                String asunto = "Superado intentos de sesion-cambio de contraseña.";
                em.enviarCorreo(para, mensaje, asunto);

                //Asignar nueva contraseña al usuario
                az = passwordEncryption.MD5(az);
                Conexion.modificarClave(para, az);
                
                session.setAttribute("mensaje", "Contraseña enviada al e-mail proporcionado.");
                System.out.println("Email enviado correctamente a " + para);
                response.sendRedirect("../index.jsp");
            }
        }
    }

//Vista de Registro --------------------------------------------------    
    //REGISTRO
    if (request.getParameter("registrarseBD") != null) {
        String email = request.getParameter("emailRegistro");
        String password = passwordEncryption.MD5(request.getParameter("passwordRegistro"));
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String nacimiento = request.getParameter("nacimiento");
        if (Conexion.existeDni(dni) || Conexion.existeEmail(email)) {
            session.setAttribute("mensaje", "Datos proporcionados ya existentes en el sistema.");
            response.sendRedirect("../index.jsp");
        } else {
            Conexion.insertAcceso(email, password);
            int id = Conexion.getId(email);
            Conexion.insertPerfil(id, nombre, apellidos, dni, telefono, nacimiento);
            int rol = Integer.parseInt(request.getParameter("rol"));
            Conexion.insertRol(id, rol);
            session.setAttribute("mensaje", "Registro correcto.");
            response.sendRedirect("../index.jsp");
            
        }
        
    }

// Vista de Contraseña olvidadad -------------------------------------
    //CONTRASEÑA OLVIDADA
    if (request.getParameter("passwordForget") != null) {
        //Enviar email
        String az = Integer.toString((int) (Math.random() * 9999999));

        //Envía email con la contraseña nueva
        Email em = new Email();
        String para = request.getParameter("emailForget");
        String mensaje = "Nueva contraseña: " + az + " \n  Como has solicitado se te envia una nueva contraseña , la cual debe ser cambiada en el primer inicio de sesion.";
        String asunto = "Solicitado cambio de contraseña";
        em.enviarCorreo(para, mensaje, asunto);

        //Asignar nueva contraseña al usuario
        az = passwordEncryption.MD5(az);
        Conexion.modificarClave(para, az);
        
        session.setAttribute("mensaje", "Contraseña enviada al e-mail proporcionado.");
        System.out.println("Email enviado correctamente a " + para);
        response.sendRedirect("../index.jsp");
    }
//Vista de cambio de contraseña --------------------------------------
    if (request.getParameter("passwordChange") != null) {
        String email = (String) session.getAttribute("email");
        String password = passwordEncryption.MD5(request.getParameter("passwordChange")); //encriptacion por MD5
        Conexion.passwordChange(email, password);
        session.setAttribute("mensaje", "Contraseña cambiada correctamente.");
        response.sendRedirect("../Vistas/login.jsp");
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