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

    public static boolean isActive(String email) {
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

    public static Usuario login(String email, String password) {
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

}
