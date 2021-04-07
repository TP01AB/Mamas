package Modelo;

/**
 *
 * @author isra9
 */
import Auxiliar.constantes;
import static Auxiliar.constantes.usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import javax.swing.JOptionPane;

public class Conexion {

    //********************* Atributos *************************
    private static java.sql.Connection Conex;
    //Atributo a través del cual hacemos la conexión física.
    private static java.sql.Statement Sentencia_SQL;
    //Atributo que nos permite ejecutar una sentencia SQL
    private static java.sql.ResultSet Conj_Registros;

    public static void nueva() {
        try {

            String controlador = "org.mariadb.jdbc.Driver"; // MariaDB la version libre de MySQL (requiere incluir la librería jar correspondiente).

            Class.forName(controlador);

            Conex = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/" + Auxiliar.constantes.BBDD, Auxiliar.constantes.usuario, Auxiliar.constantes.password);
            Sentencia_SQL = Conex.createStatement();
            System.out.println("Conexion realizada con éxito");
        } catch (Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }

    public static void cerrarBD() {
        try {
            // resultado.close();
            Conex.close();
            System.out.println("Desconectado de la Base de Datos"); // Opcional para seguridad
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error de Desconexion", JOptionPane.ERROR_MESSAGE);
        }
    }

    //METODOS PARA LOGIN-------------------------------------
    //COMPROBAR INTENTOS
    public static int getIntentos(String email) {
        int intentos = -1;
        Conexion.nueva();
        PreparedStatement ps = null;
        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, email);
            Conexion.Conj_Registros = ps.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    intentos = Conj_Registros.getInt("intentos");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return intentos;
    }

    // SUMAR INTENTO DE INICIO
    public static void sumarIntento(String email, int op) {
        //El op a 0 significa que reseteamos la variable en BD , y en 1 sumaria un intento.
        Conexion.nueva();
        try {
            String sql;
            if (op == 1) {
                sql = "UPDATE usuarios SET intentos=intentos+1 WHERE email = '" + email + "'";
            } else {
                sql = "UPDATE usuarios SET intentos=0 WHERE email = '" + email + "'";
            }
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    // USUARIO ACTIVADO
    public static boolean isActive(String email) {// comprobamos si el usuario es activo para evitar hacer consulta de login si no lo esta.
        Conexion.nueva();

        boolean isActive = false;
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE email = ? AND isActive=1";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, email);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    isActive = true;
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return isActive;
    }

    // LOGIN 
    public static Usuario login(String email, String password) {// Realizamos la comprobacion de mail y contraseña .
        Conexion.nueva();
        Usuario user = null;
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE email = ? && password = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    user = new Usuario(Conj_Registros.getInt("id"), email, Conj_Registros.getInt("isActive"), Conj_Registros.getInt("intentos"));
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general: " + ex.getMessage());
            }
        }
        return user;
    }

    // ROL
    public static int getRol(int id) { //Obtenemos el rol del usuario logueado correctamente
        Conexion.nueva();
        PreparedStatement ps = null;
        int rol = -1;
        //SENTENCIA SQL
        String sql = "SELECT * FROM asig_rol WHERE id_usuario = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setInt(1, id);
            Conexion.Conj_Registros = ps.executeQuery();
        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    rol = (Conj_Registros.getInt("id_rol"));
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general: " + ex.getMessage());
            }
        }
        return rol;
    }
    // ENVIAR CORREO CAMBIO DE CONTRASEÑA

    public static void modificarClave(String email, String az) {
        //El op a 0 significa que reseteamos la variable en BD , y en 1 sumaria un intento.
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE usuarios SET password ='" + az + "' WHERE email = '" + email + "'";

            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static int getId(String email) {
        Conexion.nueva();
        PreparedStatement ps = null;
        int id = 0;
        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE email = ? ";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, email);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    id = Conj_Registros.getInt("id");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general: " + ex.getMessage());
            }
        }
        return id;
    }
//Metodos para registro ----------------------------------------
    //Comprobamos dni .

    public static boolean existeDni(String dni) {
        boolean existe = false;
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM perfil WHERE dni = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, dni);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    existe = true;
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return existe;
    }

    //Comprobamos email .
    public static boolean existeEmail(String email) {
        boolean existe = false;
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, email);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    existe = true;
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return existe;
    }

    //Registramos los datos de acceso del usuario
    public static void insertAcceso(String email, String password) {
        Conexion.nueva();

        String sentencia = "INSERT INTO usuarios VALUES(default,'" + email + "','" + password + "',default,default)";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    //Registramos los datos de perfil del usuario
    public static void insertPerfil(int id, String nombre, String apellidos, String dni, String telefono, String nacimiento) {
        Conexion.nueva();

        String sentencia = "INSERT INTO perfil VALUES('" + id + "','" + nombre + "','" + apellidos + "','" + dni + "','" + telefono + "','" + nacimiento + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);
            Conexion.cerrarBD();

        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }

    }

    public static void insertRol(int id, int rol) {
        Conexion.nueva();

        String sentencia = "INSERT INTO asig_rol VALUES('" + id + "','" + rol + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);
            Conexion.cerrarBD();

        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }
//Metodos para cambio de contraseña-----------------------------

    public static void passwordChange(String email, String password) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE usuarios SET password ='" + password + "' WHERE email = '" + email + "'";

            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

//ADMINISTRADOR
//CRUD USUARIOS
    public static LinkedList getUsers() {
        Conexion.nueva();
        LinkedList usuarios = new LinkedList();
        try {
            String sentencia = "SELECT * FROM usuarios";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                Usuario u = new Usuario(id, email, password, activo, intentos);
                usuarios.add(u);
            }
            for (int i = 0; i < usuarios.size(); i++) {
                Usuario u = (Usuario) usuarios.get(i);
                int rol = Conexion.getRol(u.getId_user());
                u.setRol(rol);
                usuarios.set(i, u);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return usuarios;
    }

    public static LinkedList getPerfil(LinkedList usuarios) {
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM perfil";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                for (int i = 0; i < usuarios.size(); i++) {
                    Usuario u = (Usuario) usuarios.get(i);
                    if (u.getId_user() == id) {
                        u.setNombre(Conj_Registros.getString("nombre"));
                        u.setApellidos(Conj_Registros.getString("apellidos"));
                        u.setDni(Conj_Registros.getString("dni"));
                        u.setTelefono(Conj_Registros.getInt("telefono"));
                        u.setNacimiento(Conj_Registros.getDate("nacimiento"));
                        usuarios.set(i, u);
                    }

                }
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return usuarios;
    }

    public static String getEmail(int id) {
        String email = "";
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setInt(1, id);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    email = Conj_Registros.getString("email");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return email;
    }

    public static String getPassword(int id) {
        String password = "";
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setInt(1, id);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    password = Conj_Registros.getString("password");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return password;
    }

    public static void setEmail(String email, int id) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE usuarios SET email ='" + email + "' WHERE id = '" + id + "'";

            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void setActive(int id, int status) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE usuarios SET isActive = '" + status + "' WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void borrarAcceso(int id) {
        Conexion.nueva();
        try {
            String sql;
            sql = "DELETE FROM usuarios  WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void borrarPerfil(int id) {
        Conexion.nueva();
        try {
            String sql;
            sql = "DELETE FROM perfil  WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void actualizarUsuario(int id, String nombre, String apellidos, int telefono) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE perfil SET  nombre = '" + nombre + "', apellidos = '" + apellidos + "',telefono = '" + telefono + "' WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static String getDni(int id) {
        String dni = "";
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM perfil WHERE id = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setInt(1, id);
            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    dni = Conj_Registros.getString("dni");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return dni;
    }

    public static void setDni(int id, String dni) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE perfil SET dni = '" + dni + "' WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    //CRUD CICLOS
    public static LinkedList getCiclos() {
        Conexion.nueva();
        LinkedList ciclos = new LinkedList();
        try {
            String sentencia = "SELECT * FROM ciclos";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String nombre = Conj_Registros.getString("nombre");
                String descripcion = Conj_Registros.getString("descripcion");
                int plazas = Conj_Registros.getInt("plazas");
                Ciclo c = new Ciclo(id, nombre, descripcion, plazas);
                ciclos.add(c);
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return ciclos;
    }

    public static void insertCiclo(String nombre, String descripcion, int plazas) {
        Conexion.nueva();

        String sentencia = "INSERT INTO ciclos VALUES(default,'" + nombre + "','" + descripcion + "','" + plazas + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static void borrarCiclo(int id) {
        Conexion.nueva();
        try {
            String sql;
            sql = "DELETE FROM ciclos  WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void actualizarMateria(int id, String nombre, String descripcion) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE materias SET  nombre = '" + nombre + "', descripcion = '" + descripcion + "' WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void actualizarCiclo(int id, String nombre, String descripcion, int plazas) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE ciclos SET  nombre = '" + nombre + "', descripcion = '" + descripcion + "', plazas ='" + plazas + "' WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    //CRUD MATERIAS
    public static LinkedList getMaterias() {
        Conexion.nueva();
        LinkedList materias = new LinkedList();
        try {
            String sentencia = "SELECT * FROM materias ";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String nombre = Conj_Registros.getString("nombre");
                String descripcion = Conj_Registros.getString("descripcion");
                Materia m = new Materia(id, nombre, descripcion);
                materias.add(m);
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return materias;
    }

    public static LinkedList getMaterias(int IdCiclo) {
        Conexion.nueva();
        LinkedList<Materia> materias = new LinkedList<Materia>();
        try {
            String sentencia = "SELECT * FROM materias,asig_materias WHERE asig_materias.id_ciclo= '" + IdCiclo + "' AND materias.id=asig_materias.id_materia";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String nombre = Conj_Registros.getString("nombre");
                String descripcion = Conj_Registros.getString("descripcion");
                Materia m = new Materia(id, nombre, descripcion);
                materias.add(m);
            }

            for (int i = 0; i < materias.size(); i++) {
                Materia c = (Materia) materias.get(i);
                Profesor p = Conexion.getProfesor(c.getId(), IdCiclo);
                c.setProfesor(p);
                materias.set(i, c);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return materias;
    }

    public static Profesor getProfesor(int idMateria, int idCiclo) {
        Profesor p = new Profesor();
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM usuarios ,asig_profesor WHERE usuarios.id=asig_profesor.id_usuario AND asig_profesor.id_ciclo='" + idCiclo + "' AND asig_profesor.id_materia='" + idMateria + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                p = new Profesor(id, email, password, intentos);
            }
            p = (Profesor) Conexion.getPerfil(p);

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return p;
    }

    public static Usuario getPerfil(Usuario p) {
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM perfil WHERE id ='" + p.getId_user() + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {

                p.setNombre(Conj_Registros.getString("nombre"));
                p.setApellidos(Conj_Registros.getString("apellidos"));
                p.setDni(Conj_Registros.getString("dni"));
                p.setTelefono(Conj_Registros.getInt("telefono"));
                p.setNacimiento(Conj_Registros.getDate("nacimiento"));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return p;
    }

    public static void insertMateria(String nombre, String descripcion) {
        Conexion.nueva();

        String sentencia = "INSERT INTO materias VALUES(default,'" + nombre + "','" + descripcion + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static int getIdMateria(String nombre, String descripcion) {
        int idMateria = -1;
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM materias WHERE nombre = ? AND descripcion = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, descripcion);

            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {
                    idMateria = Conj_Registros.getInt("id");
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return idMateria;
    }

    public static void asignarMateria(int idCiclo, int idMateria) {
        Conexion.nueva();
        String sentencia = "INSERT INTO asig_materias VALUES('" + idCiclo + "','" + idMateria + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    //ASIGNACIONES DE MATERIAS
    public static LinkedList getAsignacionesMateria(int id) {
        Conexion.nueva();
        LinkedList asignaciones = new LinkedList();
        try {
            String sentencia = "SELECT * FROM asig_materias WHERE id_materia = '" + id + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int idCiclo = Conj_Registros.getInt("id_Ciclo");
                Ciclo c = new Ciclo();
                c.setId_ciclo(idCiclo);
                asignaciones.add(c);
            }
            for (int i = 0; i < asignaciones.size(); i++) {
                Ciclo c = (Ciclo) asignaciones.get(i);
                c = Conexion.getCiclo(c.getId_ciclo());
                asignaciones.set(i, c);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return asignaciones;
    }

    public static void matricularme(int idCiclo, int idUsuario, float nota, int estado) {

        Conexion.nueva();

        String sentencia = "INSERT INTO asig_alumno VALUES('" + idCiclo + "','" + idUsuario + "','" + nota + "','" + estado + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static void updateMatricula(int idCiclo, int idUsuario) {
        Conexion.nueva();
        String sentencia = "UPDATE asig_alumno SET estado= 1 WHERE id_ciclo = '" + idCiclo + "' AND id_usuario='" + idUsuario + "'";
        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);
            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static int matricularListaEspera(int idCiclo) {
        int idAlumno = 0;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno WHERE id_ciclo= '" + idCiclo + "' AND estado=0 ORDER BY nota DESC";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                idAlumno = Conj_Registros.getInt("id_usuario");

            }
            Conexion.updateMatricula(idCiclo, idAlumno);
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return idAlumno;
    }

    public static String getNombre(int idUsuario) {
        String nombre = null;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM perfil WHERE id= '" + idUsuario + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                nombre = Conj_Registros.getString("nombre");;
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return nombre;
    }

    public static void convalidar(int idUsuario, int idMateria) {

        Conexion.nueva();

        String sentencia = "INSERT INTO asig_convalidacion VALUES('" + idUsuario + "','" + idMateria + "',0)";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static void anularMatricula(int idCiclo, int idUsuario) {

        Conexion.nueva();

        String sentencia = "DELETE FROM asig_alumno  WHERE id_ciclo = '" + idCiclo + "' AND id_usuario= '" + idUsuario + "'";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static boolean getEstadoMatricula(int idAlumno) {
        boolean matriculado = false;
        int idCiclo = 0;
        int estado;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno WHERE id_usuario= '" + idAlumno + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                idCiclo = Conj_Registros.getInt("id_ciclo");
                estado = Conj_Registros.getInt("estado");
                if (estado != 0 && idCiclo != 0) {
                    matriculado = true;
                }
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return matriculado;
    }

    public static boolean hayPlazasDisponibles(int idCiclo) {
        boolean plazasLibres = true;
        int matriculados = 0;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno,ciclos WHERE asig_alumno.id_ciclo=ciclos.id AND asig_alumno.estado=1";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int plazas = Conj_Registros.getInt("plazas");
                matriculados++;
                if (plazas <= matriculados) {
                    plazasLibres = false;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return plazasLibres;
    }

    public static boolean hayListaEspera(int idCiclo) {
        boolean aspirantes = false;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno,ciclos WHERE asig_alumno.id_ciclo=ciclos.id AND asig_alumno.estado=0";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                aspirantes = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return aspirantes;
    }

    public static int getNumeroListaEspera(int idCiclo, int idAlumno) {
        int puestoLista = 1;
        boolean encontrado = false;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno WHERE id_ciclo= '" + idCiclo + "' AND estado=0 ORDER BY nota";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int idUsuario = Conj_Registros.getInt("id_usuario");
                if (idUsuario != idAlumno && !encontrado) {
                    puestoLista++;
                } else {
                    encontrado = true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return puestoLista;
    }

    public static int estoyMatriculado(int idAlumno) {
        int matriculado = -1;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno WHERE id_usuario= '" + idAlumno + "' AND estado=0";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                matriculado = Conj_Registros.getInt("id_ciclo");
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return matriculado;
    }

    public static LinkedList<Ciclo> getCiclosProfesor(int idProfesor) throws SQLException {
        LinkedList<Ciclo> ciclos = new LinkedList<Ciclo>();
        int idCiclo = 0;
        int idMateria = 0;
        Ciclo c = null;
        int idCicloanterior = 0;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_profesor WHERE id_usuario= '" + idProfesor + "' ORDER BY id_ciclo DESC";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                idCiclo = Conj_Registros.getInt("id_ciclo");
                idMateria = Conj_Registros.getInt("id_materia");
                if (idCicloanterior != 0) {
                    if (idCiclo != idCicloanterior) {
                        ciclos.add(c);
                        c = Conexion.getCiclo(idCiclo);
                        idCicloanterior = idCiclo;

                        c.addMateria(Conexion.getMateria(idMateria));
                    } else {
                        c.addMateria(Conexion.getMateria(idMateria));
                    }
                } else {
                    c = Conexion.getCiclo(idCiclo);
                    idCicloanterior = idCiclo;
                    c.addMateria(Conexion.getMateria(idMateria));
                }
            }
            if (c != null) {
                ciclos.add(c);
            }
            for (int i = 0; i < ciclos.size(); i++) {
                Ciclo ciclo = ciclos.get(i);
                LinkedList<Materia> materias = ciclos.get(i).getMaterias();
                for (int j = 0; j < materias.size(); j++) {
                    Materia m = materias.get(j);
                    m.setEstudiantes(Conexion.getAlumnos(ciclos.get(i).getId_ciclo(), m.getId()));
                    materias.set(j, m);

                }
                ciclo.setMaterias(materias);
                ciclos.set(i, ciclo);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return ciclos;
    }

    public static LinkedList<Estudiante> getAlumnos(int idCiclo, int idMateria) {
        Conexion.nueva();
        LinkedList<Estudiante> estudiantes = new LinkedList<Estudiante>();
        try {
            String sentencia = "SELECT * FROM usuarios,perfil,asig_convalidacion,asig_alumno WHERE perfil.id=usuarios.id AND usuarios.id=asig_alumno.id_usuario AND asig_convalidacion.id_usuario=asig_alumno.id_usuario AND asig_alumno.id_ciclo='" + idCiclo + "' AND asig_alumno.estado=1 AND asig_convalidacion.id_asignatura='" + idMateria + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                String nombre = Conj_Registros.getString("nombre");
                String apellidos = Conj_Registros.getString("apellidos");
                String dni = Conj_Registros.getString("dni");
                int telefono = Conj_Registros.getInt("telefono");
                Estudiante e = new Estudiante(id, email, password, activo, intentos);
                e.setNombre(nombre);
                e.setApellidos(apellidos);
                e.setDni(dni);
                e.setTelefono(telefono);
                e.setRol(1);
                estudiantes.add(e);
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return estudiantes;
    }

    public static Materia getMateria(int idMateria) {
        Materia m = null;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM materias WHERE id= '" + idMateria + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                String nombre = Conj_Registros.getString("nombre");
                String descripcion = Conj_Registros.getString("descripcion");
                m = new Materia(idMateria, nombre, descripcion);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return m;
    }

    public static Ciclo getCicloAlumno(int idAlumno) throws SQLException {
        Ciclo c = null;
        int idCiclo = 0;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_alumno WHERE id_usuario= '" + idAlumno + "' AND estado=1";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                idCiclo = Conj_Registros.getInt("id_ciclo");
            }
            if (idCiclo != 0) {
                c = Conexion.getCiclo(idCiclo);
                LinkedList<Materia> materias = new LinkedList<Materia>();
                materias = Conexion.getMaterias(c.getId_ciclo());

                for (int i = 0; i < materias.size(); i++) {
                    if (!Conexion.estaConvalidada(idAlumno, materias.get(i).getId())) {
                        c.addMateria(materias.get(i));
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        Conexion.cerrarBD();
        return c;
    }

    public static Ciclo getCiclo(int id) {
        Ciclo c = null;
        Conexion.nueva();
        PreparedStatement ps = null;

        //SENTENCIA SQL
        String sql = "SELECT * FROM ciclos WHERE id = ?";
        try {
            ps = Conexion.Conex.prepareStatement(sql);
            ps.setInt(1, id);

            Conexion.Conj_Registros = ps.executeQuery();

        } catch (SQLException ex) {
            System.out.println("Error de SQL: " + ex.getMessage());
        } catch (Exception ex) {
            System.out.println("Error general: " + ex.getMessage());
        } finally {
            try {
                if (Conexion.Conj_Registros.next()) {

                    String nombre = Conj_Registros.getString("nombre");
                    String descripcion = Conj_Registros.getString("descripcion");
                    int plazas = Conj_Registros.getInt("plazas");
                    c = new Ciclo(id, nombre, descripcion, plazas);
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return c;
    }

    public static void borrarMateria(int id) {
        Conexion.nueva();
        try {
            String sql;
            sql = "DELETE FROM materias  WHERE id = '" + id + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    public static void borrarAsignacion(int idCiclo, int idMateria) {
        Conexion.nueva();
        try {
            String sql;
            sql = "DELETE FROM asig_materias  WHERE id_ciclo = '" + idCiclo + "' AND id_materia = '" + idMateria + "'";
            System.out.println(sql);
            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
        Conexion.cerrarBD();
    }

    //DASHBOARD ADMIN
    public static LinkedList getProfesores() {
        Conexion.nueva();
        LinkedList<Profesor> profesores = new LinkedList<Profesor>();
        try {
            String sentencia = "SELECT * FROM usuarios ,asig_rol WHERE asig_rol.id_usuario=usuarios.id AND (asig_rol.id_rol=2 OR asig_rol.id_rol=3)";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                Profesor p = new Profesor(id, email, password, intentos);
                p.setRol(Conj_Registros.getInt("id_rol"));
                profesores.add(p);
            }
            profesores = (LinkedList<Profesor>) Conexion.getPerfil(profesores);
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return profesores;
    }

    public static LinkedList getEstudiantes() {
        Conexion.nueva();
        LinkedList<Estudiante> estudiantes = new LinkedList<Estudiante>();
        try {
            String sentencia = "SELECT * FROM usuarios ,asig_rol WHERE asig_rol.id_usuario=usuarios.id AND asig_rol.id_rol=1";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                Estudiante e = new Estudiante(id, email, password, activo, intentos);
                e.setRol(Conj_Registros.getInt("id_rol"));
                estudiantes.add(e);
            }
            estudiantes = (LinkedList<Estudiante>) Conexion.getPerfil(estudiantes);
            for (int i = 0; i < estudiantes.size(); i++) {
                estudiantes.get(i).setCiclo(Conexion.getCicloAlumno(estudiantes.get(i).getId_user()));
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return estudiantes;
    }

    public static void rechazarConvalidacion(int idAlumno, int idMateria) {
        Conexion.nueva();

        String sentencia = "UPDATE asig_convalidacion SET estado=2 WHERE id_asignatura = '" + idMateria + "' AND id_usuario='" + idAlumno + "'";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static void aceptarConvalidacion(int idAlumno, int idMateria) {
        Conexion.nueva();

        String sentencia = "UPDATE asig_convalidacion SET estado=1 WHERE id_asignatura = '" + idMateria + "' AND id_usuario='" + idAlumno + "'";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static LinkedList getEstudiantes(int idCiclo) {
        Conexion.nueva();
        LinkedList<Estudiante> estudiantes = new LinkedList<Estudiante>();
        try {
            String sentencia = "SELECT * FROM usuarios ,asig_alumno WHERE usuarios.id=asig_alumno.id_usuario AND asig_alumno.id_ciclo='" + idCiclo + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String email = Conj_Registros.getString("email");
                String password = Conj_Registros.getString("password");
                int activo = Conj_Registros.getInt("isActive");
                int intentos = Conj_Registros.getInt("intentos");
                Estudiante e = new Estudiante(id, email, password, activo, intentos);
                e.setRol(1);
                estudiantes.add(e);
            }
            estudiantes = (LinkedList< Estudiante>) Conexion.getPerfil(estudiantes);

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return estudiantes;
    }

    public static LinkedList getCiclosCompletos() {
        Conexion.nueva();
        LinkedList<Ciclo> ciclos = new LinkedList<Ciclo>();
        try {
            String sentencia = "SELECT * FROM ciclos";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int id = Conj_Registros.getInt("id");
                String nombre = Conj_Registros.getString("nombre");
                String descripcion = Conj_Registros.getString("descripcion");
                int plazas = Conj_Registros.getInt("plazas");
                Ciclo c = new Ciclo(id, nombre, descripcion, plazas);
                ciclos.add(c);
            }
            for (int i = 0; i < ciclos.size(); i++) {
                Ciclo aux = ciclos.get(i);
                LinkedList<Materia> materias = new LinkedList<Materia>();
                materias = Conexion.getMaterias(aux.getId_ciclo());
                LinkedList<Estudiante> estudiantesMateria = new LinkedList<Estudiante>();
                estudiantesMateria = Conexion.getEstudiantes(aux.getId_ciclo());
                for (int j = 0; j < materias.size(); j++) {
                    for (int k = 0; k < estudiantesMateria.size(); k++) {
                        if (!Conexion.estaConvalidada(estudiantesMateria.get(k).getId_user(), materias.get(j).getId())) {
                            Estudiante est = estudiantesMateria.get(k);
                            materias.get(j).addAlumno(est);
                        }
                    }
                }
                aux.setMaterias(materias);
                ciclos.set(i, aux);
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return ciclos;
    }

    public static void updateAsignarMateriaProfesor(int idCiclo, int idMateria, int idProfesor) {

        Conexion.nueva();

        String sentencia = "UPDATE asig_profesor SET id_usuario='" + idProfesor + "' WHERE id_ciclo = '" + idCiclo + "' AND id_materia='" + idMateria + "'";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static boolean estaMateriaestaAsignada(int idCiclo, int idMateria) {
        boolean asignada = false;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_profesor WHERE id_ciclo =' " + idCiclo + "' AND id_materia='" + idMateria + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                asignada = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();

        return asignada;
    }

    public static void insertAsignarMateriaProfesor(int idCiclo, int idMateria, int idProfesor) {

        Conexion.nueva();

        String sentencia = "INSERT INTO asig_profesor VALUES('" + idMateria + "','" + idCiclo + "','" + idProfesor + "')";

        try {
            Conexion.Sentencia_SQL.executeUpdate(sentencia);

            Conexion.cerrarBD();
        } catch (Exception ex) {
            System.out.println("Error general 2: " + ex.getMessage());
        }
    }

    public static boolean estaConvalidada(int idUsuario, int idMateria) {
        boolean convalidada = false;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_convalidacion WHERE id_usuario=' " + idUsuario + "' AND id_asignatura='" + idMateria + "' AND estado=1 ";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                convalidada = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return convalidada;
    }

    public static int getnumConvalidaciones(int tipo) {
        int num = 0;
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_convalidacion WHERE estado='" + tipo + "' ";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                num++;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return num;
    }

    public static LinkedList<Convalidacion> getConvalidaciones() {
        LinkedList<Convalidacion> convalidaciones = new LinkedList<Convalidacion>();
        Conexion.nueva();
        try {
            String sentencia = "SELECT * FROM asig_convalidacion";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                int idMateria = Conj_Registros.getInt("id_asignatura");
                int idAlumno = Conj_Registros.getInt("id_usuario");
                int estado = Conj_Registros.getInt("estado");
                Convalidacion u = new Convalidacion(idMateria, idAlumno, estado);
                convalidaciones.add(u);

            }
            for (int i = 0; i < convalidaciones.size(); i++) {
                Convalidacion u = convalidaciones.get(i);
                u.setNombreAlumno(Conexion.getNombre(u.getIdAlumno()));
                convalidaciones.set(i, u);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return convalidaciones;
    }
}
