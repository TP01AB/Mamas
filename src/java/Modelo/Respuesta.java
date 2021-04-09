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
class Respuesta {

    private int id;
    private int idPregunta;
    private String Respuesta;
    private int correcta;

    public Respuesta() {
    }

    public Respuesta(int id, int idPregunta, String Respuesta, int correcta) {
        this.id = id;
        this.idPregunta = idPregunta;
        this.Respuesta = Respuesta;
        this.correcta = correcta;
    }

    public Respuesta(int id, int idPregunta, int correcta) {
        this.id = id;
        this.idPregunta = idPregunta;
        this.correcta = correcta;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPregunta() {
        return idPregunta;
    }

    public void setIdPregunta(int idPregunta) {
        this.idPregunta = idPregunta;
    }

    public String getRespuesta() {
        return Respuesta;
    }

    public void setRespuesta(String Respuesta) {
        this.Respuesta = Respuesta;
    }

    public int getCorrecta() {
        return correcta;
    }

    public void setCorrecta(int correcta) {
        this.correcta = correcta;
    }

    @Override
    public String toString() {
        return "Respuesta{" + "id=" + id + ", idPregunta=" + idPregunta + ", Respuesta=" + Respuesta + ", correcta=" + correcta + '}';
    }

}
