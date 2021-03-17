package Modelo;

/**
 *
 * @author isra9
 */

import Auxiliar.constantes;
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
            //Cargar el driver/controlador
            String controlador = "com.mysql.jdbc.Driver";

            Class.forName(controlador);

            String URL_BD = "jdbc:mysql://localhost/" + constantes.BBDD;        

            //Realizamos la conexión a una BD con un usuario y una clave.
            Conex = java.sql.DriverManager.getConnection(URL_BD, constantes.usuario, constantes.password);
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

    
    
}
