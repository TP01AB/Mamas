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
public class Examen {

    private int id;
    private int idMateria;
    private String contenido;
    private String descripcion;
    private int estado;
    private int ponderacion;
    private LinkedList<Pregunta> preguntas;

    public Examen() {
    }

    public Examen(int id, int idMateria, String contenido, String descripcion, int estado, int ponderacion) {
        this.id = id;
        this.idMateria = idMateria;
        this.contenido = contenido;
        this.descripcion = descripcion;
        this.estado = estado;
        this.ponderacion = ponderacion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdMateria() {
        return idMateria;
    }

    public void setIdMateria(int idMateria) {
        this.idMateria = idMateria;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getPonderacion() {
        return ponderacion;
    }

    public void setPonderacion(int ponderacion) {
        this.ponderacion = ponderacion;
    }

    public LinkedList<Pregunta> getPreguntas() {
        return preguntas;
    }

    public void setPreguntas(LinkedList<Pregunta> preguntas) {
        this.preguntas = preguntas;
    }

    @Override
    public String toString() {
        return "Examen{" + "id=" + id + ", idMateria=" + idMateria + ", contenido=" + contenido + ", descripcion=" + descripcion + ", estado=" + estado + ", ponderacion=" + ponderacion + ", preguntas=" + preguntas + '}';
    }

}
