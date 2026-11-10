/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package transfer;

import java.io.Serializable;

/**
 *
 * @author ninkovic
 */
public class ServerskiOdgovor implements Serializable {

    private Object odgovor;
    private Exception exc;
    private StatusOdgovora status;

    public ServerskiOdgovor() {

    }

    public ServerskiOdgovor(Object odgovor, Exception exc, StatusOdgovora status) {
        this.odgovor = odgovor;
        this.exc = exc;
        this.status = status;
    }

}
