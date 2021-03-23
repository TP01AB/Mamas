package Modelo;

/**
 *
 * @author isra9
 */
import Auxiliar.constantes;
import static Auxiliar.constantes.usuario;
import java.sql.*;
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
                    boolean isActive = (Conj_Registros.getInt("isActive") == 0) ? true : false;
                    user = new Usuario(Conj_Registros.getInt("id"), email, isActive);
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
    }

//Metodos para registro ----------------------------------------
//Metodos para cambio de contraseña-----------------------------
    public static void passwordChange(String email, String password) {
        Conexion.nueva();
        try {
            String sql;
            sql = "UPDATE usuarios SET password ='" + password + "' WHERE email = '" + email + "'";

            Conexion.Sentencia_SQL.executeUpdate(sql);
        } catch (SQLException ex) {
        }
    }
}
