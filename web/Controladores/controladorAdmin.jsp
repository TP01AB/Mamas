<%-- 
    Document   : controladorAdmin
    Created on : 21-mar-2021, 1:57:20
    Author     : isra9
--%>

<%@page import="Modelo.Materia"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.Date"%>
<%@page import="Modelo.Email"%>
<%@page import="Auxiliar.passwordEncryption"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Conexion"%>
<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("adminHome") != null) {
        response.sendRedirect("../Vistas/inicioAdmin.jsp");
    }
    //CRUD USUARIOS
    if (request.getParameter("crudUsuarios") != null) {
        LinkedList usuarios = new LinkedList();
        usuarios = Conexion.getUsers();
        usuarios = Conexion.getPerfil(usuarios);
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }

    if (request.getParameter("update") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        int telefono = Integer.parseInt(request.getParameter("telefono"));
        String emailOriginal = Conexion.getEmail(id);
        boolean existemail = false;
        boolean existedni = false;
        Conexion.actualizarUsuario(id, nombre, apellidos, telefono);
        if (emailOriginal.compareTo(email) != 0) {
            existemail = Conexion.existeEmail(email);
            if (!existemail) {
                Conexion.setEmail(email, id);
            }
        }
        String dniOriginal = Conexion.getDni(id);

        if (dniOriginal.compareTo(dni) != 0) {
            existedni = Conexion.existeDni(dni);
            if (!existedni) {
                Conexion.setDni(id, dni);
            } else {
                if (existemail) {
                    session.setAttribute("mensaje", "El email y DNI  que usaste ya existe en la base de datos , no pudo ser modificado. \n El resto de datos fueron actualizados correctamente.");

                } else {
                    session.setAttribute("mensaje", "El DNI  que usaste ya existe en la base de datos , no pudo ser modificado. \n El resto de datos fueron actualizados correctamente.");
                }
            }
        }
        if (!existemail && !existedni) {
            session.setAttribute("mensaje", "Los datos fueron actualizados correctamente.");
        }
        LinkedList usuarios = new LinkedList();
        usuarios = Conexion.getUsers();
        usuarios = Conexion.getPerfil(usuarios);
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }
    if (request.getParameter("delete") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        Conexion.borrarPerfil(id);
        Conexion.borrarAcceso(id);
        LinkedList usuarios = new LinkedList();
        usuarios = Conexion.getUsers();
        usuarios = Conexion.getPerfil(usuarios);
        session.setAttribute("mensaje", "Usuario eliminado correctamente");
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }
    if (request.getParameter("newPassword") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        String para = Conexion.getEmail(id);
        //Enviar email
        String az = Integer.toString((int) (Math.random() * 9999999));

        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = " El administrador ha generado una nueva contraseña. \n  Esta es tu nueva contraseña:" + az;
        String asunto = "Administrador genero tu contraseña";
        em.enviarCorreo(para, mensaje, asunto);

        //Asignar nueva contraseña al usuario
        az = passwordEncryption.MD5(az);
        Conexion.modificarClave(para, az);

        session.setAttribute("mensaje", "Contraseña enviada al e-mail proporcionado.");
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }
    if (request.getParameter("activar") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        int status;
        if (request.getParameter("activado").equals("Activado")) {
            status = 0;
            session.setAttribute("mensaje", "Usuario desactivado correctamente");
        } else {
            status = 1;
            session.setAttribute("mensaje", "Usuario activado correctamente");
        }
        Conexion.setActive(id, status);

        LinkedList usuarios = new LinkedList();
        usuarios = Conexion.getUsers();
        usuarios = Conexion.getPerfil(usuarios);
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("../Vistas/crudUsuarios.jsp");
    }

    //CRUD MATERIAS
    if (request.getParameter("crudMaterias") != null) {
        LinkedList<Materia> materias = Conexion.getMaterias();
        LinkedList<Ciclo> ciclos = Conexion.getCiclos();
        session.setAttribute("ciclos", ciclos);
        session.setAttribute("materias", materias);
        response.sendRedirect("../Vistas/crudMaterias.jsp");
    }
    if (request.getParameter("editarMateria") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        Conexion.actualizarCiclo(id, nombre, descripcion);

    }
    if (request.getParameter("asignarMateria") != null) {
        int idCiclo = Integer.parseInt(request.getParameter("cicloAsignado"));
        int idMateria = Integer.parseInt(request.getParameter("idMateria"));
        //Asignamos la materia a un ciclo en su creacion.
        Conexion.asignarMateria(idCiclo, idMateria);
        LinkedList<Ciclo> ciclosAsignados = (LinkedList<Ciclo>) Conexion.getAsignacionesMateria(idMateria);
        LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) Conexion.getCiclos();
        for (int i = 0; i < ciclos.size(); i++) {
            for (int j = 0; j < ciclosAsignados.size(); j++) {
                if (ciclos.get(i).getId_ciclo() == ciclosAsignados.get(j).getId_ciclo()) {
                    ciclos.remove(i);
                }
            }
        }
        session.setAttribute("ciclos", ciclos);
        session.setAttribute("ciclosAsignados", ciclosAsignados);

        response.sendRedirect("../Vistas/verAsignaciones.jsp");
    }
    if (request.getParameter("addMateria") != null) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        int idCiclo = Integer.parseInt(request.getParameter("cicloAsignado"));
        //insertamos en la tabla materias
        Conexion.insertMateria(nombre, descripcion);
        if (idCiclo != -1) {
            //obtenemos la id que se asigna a esa materia.
            int idMateria = Conexion.getIdMateria(nombre, descripcion);
            //Asignamos la materia a un ciclo en su creacion.
            Conexion.asignarMateria(idCiclo, idMateria);
        }
        LinkedList<Materia> materias = Conexion.getMaterias();
        session.setAttribute("materias", materias);
        response.sendRedirect("../Vistas/crudMaterias.jsp");
    }
    if (request.getParameter("eliminarMateria") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        //insertamos en la tabla materias
        Conexion.borrarMateria(id);

        LinkedList<Materia> materias = Conexion.getMaterias();
        session.setAttribute("materias", materias);
        response.sendRedirect("../Vistas/crudMaterias.jsp");
    }
    if (request.getParameter("verAsignaciones") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        Materia m = new Materia(id, nombre, descripcion);
        session.setAttribute("Materia", m);
        LinkedList<Ciclo> ciclosAsignados = (LinkedList<Ciclo>) Conexion.getAsignacionesMateria(id);
        LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) Conexion.getCiclos();
        for (int i = 0; i < ciclos.size(); i++) {
            for (int j = 0; j < ciclosAsignados.size(); j++) {
                if (ciclos.get(i).getId_ciclo() == ciclosAsignados.get(j).getId_ciclo()) {
                    ciclos.remove(i);
                }
            }
        }
        session.setAttribute("ciclos", ciclos);
        session.setAttribute("ciclosAsignados", ciclosAsignados);

        response.sendRedirect("../Vistas/verAsignaciones.jsp");
    }
    if (request.getParameter("eliminarAsignacion") != null) {
        int idCiclo = (Integer.parseInt(request.getParameter("id")));
        int idMateria = (Integer.parseInt(request.getParameter("idMateria")));
        Conexion.borrarAsignacion(idCiclo, idMateria);

        LinkedList<Ciclo> ciclosAsignados = (LinkedList<Ciclo>) Conexion.getAsignacionesMateria(idMateria);
        LinkedList<Ciclo> ciclos = (LinkedList<Ciclo>) Conexion.getCiclos();
        for (int i = 0; i < ciclos.size(); i++) {
            for (int j = 0; j < ciclosAsignados.size(); j++) {
                if (ciclos.get(i).getId_ciclo() == ciclosAsignados.get(j).getId_ciclo()) {
                    ciclos.remove(i);
                }
            }
        }
        session.setAttribute("ciclos", ciclos);
        session.setAttribute("ciclosAsignados", ciclosAsignados);

        response.sendRedirect("../Vistas/verAsignaciones.jsp");
    }
    //CRUD CICLOS
    if (request.getParameter("crudCiclos") != null) {
        LinkedList<Ciclo> ciclos = Conexion.getCiclos();
        session.setAttribute("ciclos", ciclos);
        response.sendRedirect("../Vistas/crudCiclos.jsp");
    }
    if (request.getParameter("addCiclo") != null) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        Conexion.insertCiclo(nombre, descripcion);

        LinkedList<Ciclo> ciclos = Conexion.getCiclos();
        session.setAttribute("ciclos", ciclos);
        response.sendRedirect("../Vistas/crudCiclos.jsp");
    }
    if (request.getParameter("eliminarCiclo") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        Conexion.borrarCiclo(id);

        LinkedList<Ciclo> ciclos = Conexion.getCiclos();
        session.setAttribute("ciclos", ciclos);
        response.sendRedirect("../Vistas/crudCiclos.jsp");
    }
    if (request.getParameter("editarCiclo") != null) {
        int id = (Integer.parseInt(request.getParameter("id")));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        Conexion.actualizarCiclo(id, nombre, descripcion);

        LinkedList<Ciclo> ciclos = Conexion.getCiclos();
        session.setAttribute("ciclos", ciclos);
        response.sendRedirect("../Vistas/crudCiclos.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>