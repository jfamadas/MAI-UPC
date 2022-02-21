/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cat.urv.imas.onthology;

import java.io.Serializable;

/**
 *
 * @author Josep Famadas
 */
public class MetalField implements Serializable{

    private int[] position;
    private String type;
    private int quantity;

    public MetalField(int[] position, String type, int quantity) {
        this.position = position;
        this.type = type;
        this.quantity = quantity;
    }

    public int[] getPosition() {
        return position;
    }

    public void setPosition(int[] position) {
        this.position = position;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
    
    
    

    
    
    
}
