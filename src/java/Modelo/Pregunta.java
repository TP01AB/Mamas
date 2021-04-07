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
public class Pregunta {

    private int id;
    private int idMateria;
    private String enunciado;
    private int tipo;
    private int puntuacion;
    private LinkedList<Respuesta> respuestas;

    public Pregunta() {
    }

    public Pregunta(int id, int idMateria, String enunciado, int tipo, int puntuacion) {
        this.id = id;
        this.idMateria = idMateria;
        this.enunciado = enunciado;
        this.tipo = tipo;
        this.puntuacion = puntuacion;
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

    public String getEnunciado() {
        return enunciado;
    }

    public void setEnunciado(String enunciado) {
        this.enunciado = enunciado;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public int getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) {
        this.puntuacion = puntuacion;
    }

    public LinkedList<Respuesta> getRespuestas() {
        return respuestas;
    }

    public void setRespuestas(LinkedList<Respuesta> respuestas) {
        this.respuestas = respuestas;
    }

}
