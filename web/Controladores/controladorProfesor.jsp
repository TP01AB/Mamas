<%-- 
    Document   : controladorProfesor
    Created on : 21-mar-2021, 1:57:04
    Author     : isra9
--%>

<%@page import="Modelo.Conexion"%>
<%@page import="Modelo.Materia"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Profesor"%>
<%
    //Borramos el mensaje para que tras el cambio de pagina no muestre  el mismo mensaje.
    if (session.getAttribute("mensaje") != null) {
        session.setAttribute("mensaje", null);
    }
    //HOME
    if (request.getParameter("profHome") != null) {

        Profesor p = (Profesor) session.getAttribute("usuarioActual");
        p = (Profesor) Conexion.getPerfil(p);
        LinkedList<Ciclo> Ciclos = Conexion.getCiclosProfesor(p.getId_user());

        p.setCiclos(Ciclos);
        session.setAttribute("usuarioActual", p);
        response.sendRedirect("../Vistas/inicioProf.jsp");
    }
    //CERRAR SESION
    if (request.getParameter("close") != null) {
        session.removeAttribute("usuarioActual");
        session.removeAttribute("rolActual");
        response.sendRedirect("../index.jsp");
    }
    if (request.getParameter("editarPerfil") != null) {
        response.sendRedirect("../Vistas/editarPerfil.jsp");
    }
    if (request.getParameter("updatePerfil") != null) {

        response.sendRedirect("../Vistas/inicioProf.jsp");
    }
    if (request.getParameter("cambioPass") != null) {

        response.sendRedirect("../Vistas/cambioContra.jsp");
    }
    if (request.getParameter("Entrar") != null) {
        int idCiclo = Integer.parseInt(request.getParameter("idCiclo"));
        int idMateria = Integer.parseInt(request.getParameter("idMateria"));
        Profesor p = (Profesor) session.getAttribute("usuarioActual");
        LinkedList<Ciclo> ciclos = p.getCiclos();
        for (int i = 0; i < ciclos.size(); i++) {
            if (ciclos.get(i).getId_ciclo() == idCiclo) {
                Ciclo ciclo = ciclos.get(i);
                LinkedList<Materia> materias = ciclo.getMaterias();
                for (int j = 0; j < materias.size(); j++) {
                    Materia m = materias.get(j);
                    if (m.getId() == idMateria) {
                        session.setAttribute("cicloElegido", ciclo);
                        System.out.println("--------------------" + m);
                        session.setAttribute("materiaElegida", m);
                        response.sendRedirect("../Vistas/vistaMateria.jsp");
                    }
                }
            }
        }
    }
    if (request.getParameter("crearPregunta") != null) {
        String enunciado = request.getParameter("enunciado");
        int tipo = (Integer.parseInt(request.getParameter("tipo")));
        int puntuacion = (Integer.parseInt(request.getParameter("puntuacion")));
        int idMateria = Integer.parseInt(request.getParameter("id"));
        Conexion.insertPregunta(idMateria, enunciado, tipo, puntuacion);
        int idPregunta = Conexion.getMaxIdPregunta();
        if (tipo == 0) {
            //futura implementacion para palabras clave y corregir automaticamente
        } else {
            String[] respuestas = request.getParameterValues("respuesta");
            String[] seleccionada = request.getParameterValues("respuestaS");
            for (int i = 0; i < respuestas.length; i++) {
                int correcta = 0;
                for (int j = 0; j < seleccionada.length; j++) {
                    if (i == Integer.parseInt(seleccionada[j])) {
                        correcta = 1;
                    }
                }
                Conexion.insertRespuesta(idPregunta, respuestas[i], correcta);
                int idRespuesta = Conexion.getMaxIdRespuesta();
                Conexion.asignarRespuesta(idRespuesta, idPregunta);
            }
        }
        Materia m = Conexion.getMateria(idMateria);
        session.setAttribute("materiaElegida", m);
        response.sendRedirect("../Vistas/crudPreguntas.jsp");
    }
    if (request.getParameter("crudPreguntas") != null) {
        session.setAttribute("preguntas", Conexion.getPreguntas());
        response.sendRedirect("../Vistas/crudPreguntas.jsp");
    }
    if (request.getParameter("CrudExamenes") != null) {
        response.sendRedirect("../Vistas/crudExamenes.jsp");
    }
    if (request.getParameter("crearExamen") != null) {
        Materia materia = (Materia) session.getAttribute("materiaElegida");
        Ciclo c = (Ciclo) session.getAttribute("cicloElegido");

        String contenido = request.getParameter("contenido");
        String descripcion = request.getParameter("descripcion");
        int ponderacion = (Integer.parseInt(request.getParameter("ponderacion")));
        Conexion.insertExamen(materia.getId(), contenido, descripcion, ponderacion);
        session.setAttribute("materiaElegida", Conexion.getMateria(materia.getId()));
        response.sendRedirect("../Vistas/crudExamenes.jsp");
    }
    if (request.getParameter("cambiarEstado") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        Materia materia = (Materia) session.getAttribute("materiaElegida");
        Ciclo c = (Ciclo) session.getAttribute("cicloElegido");
        int activado = Integer.parseInt(request.getParameter("activado"));
        String contenido = request.getParameter("contenido");
        String descripcion = request.getParameter("descripcion");
        int ponderacion = (Integer.parseInt(request.getParameter("ponderacion")));
        Conexion.updateExamen(id, activado);
        session.setAttribute("materiaElegida", Conexion.getMateria(materia.getId()));
        response.sendRedirect("../Vistas/crudExamenes.jsp");
    }
    if (request.getParameter("finalizar") != null) {
        int id = Integer.parseInt(request.getParameter("id"));
        Materia materia = (Materia) session.getAttribute("materiaElegida");
        Ciclo c = (Ciclo) session.getAttribute("cicloElegido");
        int activado = Integer.parseInt(request.getParameter("activado"));
        String contenido = request.getParameter("contenido");
        String descripcion = request.getParameter("descripcion");
        int ponderacion = (Integer.parseInt(request.getParameter("ponderacion")));
        Conexion.finExamen(id);
        session.setAttribute("materiaElegida", Conexion.getMateria(materia.getId()));
        response.sendRedirect("../Vistas/crudExamenes.jsp");
    }
    if (request.getParameter("eliminarPregunta") != null) {
        int idPregunta = Integer.parseInt(request.getParameter("id"));
        int idMateria = Integer.parseInt(request.getParameter("idM"));
        Conexion.deletePregunta(idPregunta);
        session.setAttribute("mensaje", "Pregunta borrada correctamente");
        Materia m = Conexion.getMateria(idMateria);
        session.setAttribute("materiaElegida", m);
        response.sendRedirect("../Vistas/crudPreguntas.jsp");
    }
%>