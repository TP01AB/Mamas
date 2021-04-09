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
public class Convalidacion {

    private int idMateria;
    private int idAlumno;
    private String nombreAlumno;
    private int estado;

    public Convalidacion() {
    }

    public Convalidacion(int idMateria, int idAlumno, int estado) {
        this.idMateria = idMateria;
        this.idAlumno = idAlumno;
        this.estado = estado;
    }

    public Convalidacion(int idMateria, int idAlumno, String nombreAlumno, int estado) {
        this.idMateria = idMateria;
        this.idAlumno = idAlumno;
        this.nombreAlumno = nombreAlumno;
        this.estado = estado;
    }

    public String getNombreAlumno() {
        return nombreAlumno;
    }

    public void setNombreAlumno(String nombreAlumno) {
        this.nombreAlumno = nombreAlumno;
    }

    public int getIdMateria() {
        return idMateria;
    }

    public void setIdMateria(int idMateria) {
        this.idMateria = idMateria;
    }

    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    @Override
    public String toString() {
        return "Convalidacion{" + "idMateria=" + idMateria + ", idAlumno=" + idAlumno + ", nombreAlumno=" + nombreAlumno + ", estado=" + estado + '}';
    }

}
