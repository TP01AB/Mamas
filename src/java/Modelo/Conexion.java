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
                    user = new Usuario(Conj_Registros.getInt("id"), email, Conj_Registros.getInt("isActive"));
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
                System.out.println(u);
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
                Ciclo c = new Ciclo(id, nombre, descripcion);
                ciclos.add(c);
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        Conexion.cerrarBD();
        return ciclos;
    }

    public static void insertCiclo(String nombre, String descripcion) {
        Conexion.nueva();

        String sentencia = "INSERT INTO ciclos VALUES(default,'" + nombre + "','" + descripcion + "')";

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

    public static void actualizarCiclo(int id, String nombre, String descripcion) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE ciclos SET  nombre = '" + nombre + "', descripcion = '" + descripcion + "' WHERE id = '" + id + "'";
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

    public static Ciclo getCiclo(int id) {
        Ciclo c = new Ciclo();
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
                    c.setId_ciclo(id);
                    c.setNombre(Conj_Registros.getString("nombre"));
                    c.setDescripcion(Conj_Registros.getString("descripcion"));
                }
                ps.close();
                Conexion.cerrarBD();
            } catch (Exception ex) {
                System.out.println("Error general 2: " + ex.getMessage());
            }
        }
        return c;
    }
}
