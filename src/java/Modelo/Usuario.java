/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author isra9
 */
import Auxiliar.passwordEncryption;
import java.sql.Date;
import java.util.LinkedList;

public class Usuario {

    //Atributos  usuario 
    private String nombre;
    private String apellidos;
    private String dni;
    private int telefono;
    private Date nacimiento;
    private int id_user;
    private String email;
    private String password;
    private boolean isActive;
    private int intentos;
    //Roles
    private int rol;

    //Constructor de usuario sin ID y rol , los cuales se asignaran tras el Login.
    public Usuario(int id, String email, int isActive) {
        this.id_user = id;
        this.email = email;
        if (isActive == 1) {
            this.isActive = true;
        } else {
            this.isActive = false;
        }
    }

    //Constructor de usuario con todos los datos para casos en los que se consulte el usuario completo en BD.
    public Usuario(int id_user, String email, String password, int isActive, int intentos) {
        this.id_user = id_user;
        this.email = email;
        this.password = password;
        if (isActive == 1) {
            this.isActive = true;
        } else {
            this.isActive = false;
        }

        this.rol = rol;
        this.intentos = intentos;
        this.apellidos = "prueba";
        this.nombre = "prueba";
    }

    //Constructor vacio
    public Usuario() {
    }

    // GETTER & SETTERS
    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNombre() {
        return nombre;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public Date getNacimiento() {
        return nacimiento;
    }

    public void setNacimiento(Date nacimiento) {
        this.nacimiento = nacimiento;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
        this.rol = rol;
    }

    public int getIntentos() {
        return intentos;
    }

    public void setIntentos(int intentos) {
        this.intentos = intentos;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Usuario{" + "nombre=" + nombre + ", apellidos=" + apellidos + ", dni=" + dni + ", telefono=" + telefono + ", nacimiento=" + nacimiento + ", id_user=" + id_user + ", email=" + email + ", password=" + password + ", isActive=" + isActive + ", intentos=" + intentos + ", rol=" + rol + '}';
    }

}
