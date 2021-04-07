<%-- 
    Document   : crudPreguntas
    Created on : 07-abr-2021, 6:43:45
    Author     : isra9
--%>

<%@page import="Modelo.Pregunta"%>
<%@page import="Modelo.Examen"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Ciclo"%>
<%@page import="Modelo.Materia"%>
<%@page import="Modelo.Profesor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mamas</title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <!-- Material Design Bootstrap -->
        <link rel="stylesheet" href="../css/mdb.min.css">
        <!-- Your custom styles (optional) -->
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/all.css">
    </head>
    <body>
        <jsp:include page="../Recursos/navbar.jsp"/>
        <%
            Profesor uActual = (Profesor) session.getAttribute("usuarioActual");
            Materia materia = (Materia) session.getAttribute("materiaElegida");
            LinkedList<Examen> examenes = materia.getExamenes();
            LinkedList<Pregunta> preguntas = new LinkedList<Pregunta>();

        %>
    </head>
<body>
    <section class="text-center">
        <div class="row">  
            <div class="col-md-12 mx-auto">
                <div class="card rounded col-12 mx-auto">
                    <div class="card-body">
                        <h3 class="font-weight-bold my-4">Gestión de Preguntas</h3>
                        <!<!-- Mensaje de error guardado en sesion -->
                        <%                            if (session.getAttribute("mensaje") != null) {
                                String mensaje = (String) session.getAttribute("mensaje");
                        %>
                        <hr>
                        <div ><span name="mensaje" id="mensaje"><%=mensaje%></span></div>
                        <hr>
                        <%}%>
                        <!------------------TABLA------------------------->
                        <h5>Creaccion de examen: <%= materia.getNombre()%></h5>
                        <input class="btn btn-primary  text-center" type="submit" name="tipo" id="" value="texto" onclick="tipotexto()" >
                        <input class="btn btn-primary  text-center" type="submit" name="tipo" id="" value="numerica" onclick="tipoNum()">
                        <input class="btn btn-primary  text-center" type="submit" name="tipo" id="" value="test" onclick="tipoTest()">
                        <input class="btn btn-primary  text-center" type="submit" name="tipo" id="" value="multiple" onclick="tipoMultiple()">
                        <form id="text" class="text-center row d-none"  action="../Controladores/controladorProfesor.jsp" method="POST" >
                            <input type="hidden" name="id" value="<%= materia.getId()%>">
                            <input class="form-control  m-1 " type="text" name="enunciado" placeholder="introduce un nombre" required >
                            <input class="form-control  m-1" type="hidden" name="tipo" value="0">
                            <input class="form-control  m-1" type="number" name="puntuacion" min="1" max="100" placeholder="introduce la ponderacion 1-100" required>
                            <br>
                            <input class="btn btn-primary col-2 text-center" type="submit" name="crearPregunta" value="+">
                        </form>
                        <form id="num" class="text-center row d-none"  action="../Controladores/controladorProfesor.jsp" method="POST" >
                            <input type="hidden" name="id" value="<%= materia.getId()%>">
                            <input class="form-control  m-1" type="text" name="enunciado" placeholder="introduce un nombre" required >
                            <input class="form-control  m-1" type="hidden" name="tipo" value="1">
                            <input class="form-control  m-1" type="number" name="puntuacion" min="1" max="100" placeholder="introduce la ponderacion 1-100" required>
                            <hr>
                            <div class="row  m-2">
                                <input type="radio" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                                <input type="radio" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <div class="row  m-2">
                                <input type="radio" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                                <input type="radio" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <input class="btn btn-primary col-2 text-center" type="submit" name="crearPregunta" value="+">
                        </form>
                        <form id="test" class="text-center row d-none"  action="../Controladores/controladorProfesor.jsp" method="POST" >
                            <input type="hidden" name="id" value="<%= materia.getId()%>">
                            <input class="form-control  m-1" type="text" name="enunciado" placeholder="introduce un nombre" required >
                            <input class="form-control  m-1" type="hidden" name="tipo" value="2">
                            <input class="form-control  m-1" type="number" name="puntuacion" min="1" max="100" placeholder="introduce la ponderacion 1-100" required>
                            <hr>
                            <div class="row  m-2">
                                <input type="radio" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                                <input type="radio" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <div class="row  m-2">
                                <input type="radio" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                                <input type="radio" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <br>
                            <input class="btn btn-primary col-2 text-center" type="submit" name="crearPregunta" value="+">
                        </form>
                        <form id="mult" class="text-center row d-none"  action="../Controladores/controladorProfesor.jsp" method="POST" >
                            <input type="hidden" name="id" value="<%= materia.getId()%>">
                            <input class="form-control  m-1" type="text" name="enunciado" placeholder="introduce un nombre" required >
                            <input class="form-control  m-1" type="hidden" name="tipo" value="3">
                            <input class="form-control  m-1" type="number" name="puntuacion" min="1" max="100" placeholder="introduce la ponderacion 1-100" required>
                            <div class="row m-2">
                                <input type="checkbox" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                                <input type="checkbox" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <div class="row m-2">
                                <input type="checkbox" name="respuesta"> <input type="number" name="respuesta" placeholder="" required> 
                                <input type="checkbox" name="respuesta"><input type="number" name="respuesta" placeholder="" required> 
                            </div>
                            <input class="btn btn-primary col-2 text-center" type="submit" name="crearPregunta" value="+">
                        </form>
                        <hr>
                        <table class="table table-striped mx-auto" >
                            <tr class="m-5">
                                <th scope="col">id</th>
                                <th scope="col" >Contenido</th>
                                <th scope="col" >Descripcion</th>
                                <th scope="col" >Estado</th>
                                <th scope="col" >Ponderacion</th>
                                <th scope="col" >Acciones</th>
                            </tr>
                            <%
                                for (int i = 0; i < examenes.size(); i++) {
                                    Examen m = examenes.get(i);
                            %>
                            <form class="text-center justify-content-center"  action="../Controladores/controladorProfesor.jsp" method="POST" >
                                <tr >
                                <input type="hidden" name="id" value="<%= m.getId()%>">
                                <td scope="row" >
                                    <%=m.getId()%>
                                </td>
                                <td >
                                    <input class="form-control" type="text" name="nombre" value="<%=m.getContenido()%>" readonly>
                                </td>
                                <td >
                                    <input class="form-control" type="text" name="descripcion" value="<%=m.getDescripcion()%>" readonly>
                                </td>
                                <td class="text-center <%if (m.getEstado() == 1) {
                                        out.print("text-success");
                                    } else if (m.getEstado() == 0) {
                                        out.print("text-danger");
                                    } else if (m.getEstado() == 1) {
                                        out.print("text-info");
                                    }%> " >
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-circle-fill" viewBox="0 0 16 16">
                                    <circle cx="8" cy="8" r="8"/>
                                    </svg>
                                    <input type="hidden" name="activado" value="<%=m.getEstado()%>">
                                </td>
                                <td >
                                    <input class="form-control" type="text" name="ponderacion" value="<%=m.getPonderacion()%>" readonly>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-secondary m-1 p-1" type="submit" name="asignarPreguntas" title="asignar preguntas">?</button>
                                    <button class="btn btn-success m-1 p-1" type="submit" name="cambiarEstado" title="cambiar estado examen" <%if (m.getEstado() == 2) {
                                            out.print("readonly");
                                        } %> >ON/OFF</button>
                                    <button class="btn btn-info m-1 p-1" type="submit" name="finalizar" title="finalizar examen">FIN</button>
                                </td>
                                </tr>

                            </form>
                            <%}%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- SCRIPT -->

    <!-- jQuery -->
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="../js/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <!-- MDB core JavaScript -->
    <script type="text/javascript" src="../js/mdb.min.js"></script>
    <!-- Your custom scripts (optional) -->
    <script type="text/javascript" src="../js/validar.js"></script>
    <jsp:include page="../Recursos/Footer.jsp"/>
</body>
</html> 