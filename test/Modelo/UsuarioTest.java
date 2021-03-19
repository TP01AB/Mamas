/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 *
 * @author isra9
 */
public class UsuarioTest {
    
    public UsuarioTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
    }
    
    @AfterAll
    public static void tearDownClass() {
    }
    
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }

    /**
     * Test of getId_user method, of class Usuario.
     */
    @Test
    public void testGetId_user() {
        System.out.println("getId_user");
        Usuario instance = new Usuario();
        int expResult = 0;
        int result = instance.getId_user();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setId_user method, of class Usuario.
     */
    @Test
    public void testSetId_user() {
        System.out.println("setId_user");
        int id_user = 0;
        Usuario instance = new Usuario();
        instance.setId_user(id_user);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getEmail method, of class Usuario.
     */
    @Test
    public void testGetEmail() {
        System.out.println("getEmail");
        Usuario instance = new Usuario();
        String expResult = "";
        String result = instance.getEmail();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setEmail method, of class Usuario.
     */
    @Test
    public void testSetEmail() {
        System.out.println("setEmail");
        String email = "";
        Usuario instance = new Usuario();
        instance.setEmail(email);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of isIsActive method, of class Usuario.
     */
    @Test
    public void testIsIsActive() {
        System.out.println("isIsActive");
        Usuario instance = new Usuario();
        boolean expResult = false;
        boolean result = instance.isIsActive();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setIsActive method, of class Usuario.
     */
    @Test
    public void testSetIsActive() {
        System.out.println("setIsActive");
        boolean isActive = false;
        Usuario instance = new Usuario();
        instance.setIsActive(isActive);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of getRol method, of class Usuario.
     */
    @Test
    public void testGetRol() {
        System.out.println("getRol");
        Usuario instance = new Usuario();
        int expResult = 0;
        int result = instance.getRol();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of setRol method, of class Usuario.
     */
    @Test
    public void testSetRol() {
        System.out.println("setRol");
        int rol = 0;
        Usuario instance = new Usuario();
        instance.setRol(rol);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
