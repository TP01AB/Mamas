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
import java.util.LinkedList;

public class Usuario {
    //Atributos  usuario 

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
    public Usuario(int id_user, String email, String password, int rol, int isActive, int intentos) {
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

}
