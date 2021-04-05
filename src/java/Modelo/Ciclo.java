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
public class Ciclo {

    private int id_ciclo;
    private String nombre;
    private String descripcion;
    private int plazasMaximas;
    private LinkedList<Materia> Materias;

    public Ciclo() {
        this.Materias = new LinkedList<Materia>();
    }

    public Ciclo(int id_ciclo, String nombre, String descripcion, int plazas) {
        this.id_ciclo = id_ciclo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.plazasMaximas = plazas;
        this.Materias = new LinkedList<Materia>();
    }

    public Ciclo(int id_ciclo, String nombre, String descripcion, LinkedList<Materia> Materias) {
        this.id_ciclo = id_ciclo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.Materias = Materias;
    }

    public int getId_ciclo() {
        return id_ciclo;
    }

    public void setId_ciclo(int id_ciclo) {
        this.id_ciclo = id_ciclo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LinkedList<Materia> getMaterias() {
        return Materias;
    }

    public void setMaterias(LinkedList<Materia> Materias) {
        this.Materias = Materias;
    }

    public void addMateria(Materia m) {
        this.Materias.add(m);
    }

    public void removeMateria(Materia m) {
        this.Materias.remove(m);
    }

    public int getPlazasMaximas() {
        return plazasMaximas;
    }

    public void setPlazasMaximas(int plazasMaximas) {
        this.plazasMaximas = plazasMaximas;
    }

}
