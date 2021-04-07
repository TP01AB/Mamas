<%-- 
    Document   : controladorAlumno
    Created on : 21-mar-2021, 1:57:30
    Author     : isra9
--%>

<%@page import="Auxiliar.passwordEncryption"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="Modelo.Email"%>
<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Estudiante"%>
<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("aluHome") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");
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
    }
    if (request.getParameter("matricularme") != null) {
        response.sendRedirect("../Vistas/matricula.jsp");
    }
    if (request.getParameter("anularMatricula") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");
        Conexion.anularMatricula(e.getCiclo().getId_ciclo(), e.getId_user());
        if (Conexion.hayPlazasDisponibles(e.getCiclo().getId_ciclo()) && Conexion.hayListaEspera(e.getCiclo().getId_ciclo())) {
            int idAlu = Conexion.matricularListaEspera(e.getCiclo().getId_ciclo());
            String email = Conexion.getEmail(idAlu);
            //Envía email con la contraseña nueva
            Email em = new Email();
            String mensaje = "Hola , ha quedado libre una plaza por lo tanto has sido matriculado correctamente.";
            String asunto = "Plaza libre en ciclo solicitado";
            em.enviarCorreo(email, mensaje, asunto);

        }
        session.setAttribute("mensaje", "Matricula anulada correctamente.");
        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = "Hola " + e.getNombre() + " " + e.getApellidos() + ",has renunciado a la matricula.";
        String asunto = "Matricula anulada  correctamente.";
        em.enviarCorreo(e.getEmail(), mensaje, asunto);
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
    }
    if (request.getParameter("convalidar") != null) {
        response.sendRedirect("../Vistas/convalidar.jsp");
    }
    if (request.getParameter("convalidarBD") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");
        String[] idMaterias = request.getParameterValues("materia");
        for (int i = 0; i < idMaterias.length; i++) {
            Conexion.convalidar(e.getId_user(), Integer.parseInt(idMaterias[i]));
        }
        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = "Hola " + e.getNombre() + " " + e.getApellidos() + ",has enviado correctamente tu solicitud de convalidacion .";
        String asunto = "Convalidacion enviada correctamente.";
        em.enviarCorreo(e.getEmail(), mensaje, asunto);
        session.setAttribute("mensaje", "Convalidacion enviada correctamente, sera notificado por correo cuando sea aceptada o rechazada.");

        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }

    if (request.getParameter("matriculaDB") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");
        int idCiclo = Integer.parseInt(request.getParameter("ciclo"));
        Ciclo c = Conexion.getCiclo(idCiclo);
        float nota = Float.parseFloat(request.getParameter("nota"));
        int opcion;
        if (Conexion.hayPlazasDisponibles(idCiclo)) {
            opcion = 1;
            session.setAttribute("mensaje", "Matricula enviada correctamente, ha sido aceptado en el ciclo.");

        } else {
            opcion = 0;
            session.setAttribute("mensaje", "Matricula enviada correctamente, no quedan plazas libres asi que ha sido puesto en lista de espera.");
        }
        Conexion.matricularme(idCiclo, e.getId_user(), nota, opcion);

        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = "Hola " + e.getNombre() + " " + e.getApellidos() + ",has enviado correctamente tu solicitud de matricularte en : " + c.getNombre() + ".";
        String asunto = "Matricula enviada correctamente.";
        em.enviarCorreo(e.getEmail(), mensaje, asunto);
        e = (Estudiante) Conexion.getPerfil(e);
        c = Conexion.getCicloAlumno(e.getId_user());
        if (c == null) {
            idCiclo = Conexion.estoyMatriculado(e.getId_user());
            if (idCiclo != -1) {
                session.setAttribute("idCicloListaEspera", idCiclo);
                session.setAttribute("numeroListaEspera", Conexion.getNumeroListaEspera(idCiclo, e.getId_user()));
            }
        }
        e.setCiclo(c);
        session.setAttribute("usuarioActual", e);
        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }

    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
    if (request.getParameter("updatePerfil") != null) {
        String email = request.getParameter("emailRegistro");
        String password = passwordEncryption.MD5(request.getParameter("passwordRegistro"));
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String nacimiento = request.getParameter("nacimiento");
        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }
     if (request.getParameter("editarPerfil") != null) {
        response.sendRedirect("../Vistas/editarPerfil.jsp");
    }
      if (request.getParameter("cambioPass") != null) {

response.sendRedirect("../Vistas/cambioContra.jsp");    }
%>