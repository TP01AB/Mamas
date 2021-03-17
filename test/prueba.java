/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author isra9
 */
import junit.framework.TestCase;

public class prueba  extends TestCase {
    
    public void probarFallar(){
        assertFalse(false);
    }
    public void probarAcertar(){
        assertFalse(true);
    }
}
