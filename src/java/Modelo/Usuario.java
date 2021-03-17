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
    private boolean isActive;
    //Roles
    private int rol;

    //Constructor de usuario sin ID y rol , los cuales se asignaran tras el Login.
    public Usuario(int id,String email, boolean isActive) {
        this.id_user=id;
        this.email = email;
        this.isActive = isActive;
    }

    //Constructor de usuario con todos los datos para casos en los que se consulte el usuario completo en BD.
    public Usuario(int id_user, String email, boolean isActive, int rol) {
        this.id_user = id_user;
        this.email = email;
        this.isActive = isActive;
        this.rol = rol;
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

}
