/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cat.urv.imas.onthology;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Josep Famadas
 */
public class MetalFieldList implements Serializable{
    
    private List<MetalField> metalFields = new ArrayList<MetalField>();

    public MetalFieldList(List<MetalField> metalFields) {
        this.metalFields = metalFields;
    }

    public List<MetalField> getMetalFields() {
        return metalFields;
    }

    public void setMetalFields(List<MetalField> metalFields) {
        this.metalFields = metalFields;
    }
    
    
    
    
}
