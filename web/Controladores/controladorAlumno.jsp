<%-- 
    Document   : controladorAlumno
    Created on : 21-mar-2021, 1:57:30
    Author     : isra9
--%>

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
        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }
    if (request.getParameter("matricularme") != null) {
        response.sendRedirect("../Vistas/matricula.jsp");
    }
    if (request.getParameter("anularMatricula") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");

        Conexion.anularMatricula(e.getCiclo().getId_ciclo(), e.getId_user());
        session.setAttribute("mensaje", "Matricula anulada correctamente.");
        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = "Hola " + e.getNombre() + " " + e.getApellidos() + ",has renunciado a la matricula.";
        String asunto = "Matricula anulada  correctamente.";
        em.enviarCorreo(e.getEmail(), mensaje, asunto);

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

    if (request.getParameter(
            "matriculaDB") != null) {
        Estudiante e = (Estudiante) session.getAttribute("usuarioActual");
        int idCiclo = Integer.parseInt(request.getParameter("ciclo"));
        Ciclo c = Conexion.getCiclo(idCiclo);
        float nota = Float.parseFloat(request.getParameter("nota"));
        Conexion.matricularme(idCiclo, e.getId_user(), nota);
        session.setAttribute("mensaje", "Matricula enviada correctamente, sera notificado por correo cuando sea aceptado.");

        //Envía email con la contraseña nueva
        Email em = new Email();
        String mensaje = "Hola " + e.getNombre() + " " + e.getApellidos() + ",has enviado correctamente tu solicitud de matricularte en : " + c.getNombre() + ". \n  Te notificaremos tu admision o puesto en lista de espera en el proximo correo.";
        String asunto = "Matricula enviada correctamente.";
        em.enviarCorreo(e.getEmail(), mensaje, asunto);

        response.sendRedirect("../Vistas/inicioAlu.jsp");
    }

    //CERRAR SESION
    if (request.getParameter(
            "close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
%>