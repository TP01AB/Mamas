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
                        session.setAttribute("materiaElegida", m);
                        response.sendRedirect("../Vistas/vistaMateria.jsp");
                    }
                }
            }
        }
    }
    if (request.getParameter("crudPreguntas") != null) {
        response.sendRedirect("../Vistas/crudPreguntas.jsp");
    }
    if (request.getParameter("CrudExamenes") != null) {
        response.sendRedirect("../Vistas/crudExamenes.jsp");
    }
%>