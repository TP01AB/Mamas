/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.util.LinkedList;

/**
 *
 * @author isra9
 */
public class Profesor extends Usuario {

    private LinkedList<Ciclo> Ciclos;

    public Profesor(LinkedList<Ciclo> Ciclos, int id, String email, int isActive) {
        super(id, email, isActive);
        this.Ciclos = Ciclos;
    }

    public Profesor(int id_user, String email, String password, int isActive, int intentos) {
        super(id_user, email, password, isActive, intentos);
    }

    public Profesor(LinkedList<Ciclo> Ciclos) {
        this.Ciclos = Ciclos;
    }

    public LinkedList<Ciclo> getCiclos() {
        return Ciclos;
    }

    public void setCiclos(LinkedList<Ciclo> Ciclos) {
        this.Ciclos = Ciclos;
    }

}
