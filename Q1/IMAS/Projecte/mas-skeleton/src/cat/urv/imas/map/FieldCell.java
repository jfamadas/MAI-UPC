/**
 * IMAS base code for the practical work.
 * Copyright (C) 2014 DEIM - URV
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */
package cat.urv.imas.map;

import cat.urv.imas.gui.CellVisualizer;
import cat.urv.imas.onthology.MetalType;
import java.util.HashMap;
import java.util.Map;

/**
 * Field cell.
 */
public class FieldCell extends Cell {

    /**
     * When this metal is not found yet, an empty list of metal is returned.
     */
    protected static Map<MetalType, Integer> empty = new HashMap();

    /**
     * Metal of the field: it can only be of one type at a time.
     * But, once generated, it can be of any type and amount.
     */
    protected Map<MetalType, Integer> metal;
    /**
     * If true, prospectors have found this metal. false when prospectors have
     * to find it yet.
     */
    protected boolean found = false;

    /**
     * Builds a cell corresponding to a field.
     *
     * @param row row number.
     * @param col column number.
     */
    public FieldCell(int row, int col) {
        super(CellType.FIELD, row, col);
        metal = new HashMap();
    }

    /**
     * Detects the real metal on this field.
     * @return the metal on it.
     */
    public Map<MetalType, Integer> detectMetal() {
        found = (!metal.isEmpty());
        return metal;
    }

    /**
     * Whenever the metal has been detected, it informs about the
     * current metal on this field. Otherwise, it will behave as if
     * no metal was in.
     * @return the metal on it.
     */
    public Map<MetalType, Integer> getMetal() {
        return (found) ? metal : empty;
    }

    @Override
    public boolean isEmpty() {
        return found;
    }


    /**
     * Removes an item of the current metal, if any.
     * When there is no more metal after removing it, the set of
     * metal is emptied.
     */
    public void removeMetal() {
        if (found && metal.size() > 0) {
            for (Map.Entry<MetalType, Integer> entry: metal.entrySet()) {
                if (entry.getValue() == 1) {
                    metal.clear();
                    found = false;
                } else {
                    metal.replace(entry.getKey(), entry.getValue()-1);
                }
            }
        }
    }

    /* ***************** Map visualization API ********************************/

    @Override
    public void draw(CellVisualizer visual) {
        visual.drawField(this);
    }

    /**
     * Shows the type of metal and the amount of it, with the form:
     * <pre>
     *    {type}:{amount}
     * </pre>
     * or an empty string if no metal is present. A star is placed at the end
     * of the string if the metal is found by prospectors.
     * @return String detail of the metal present in this field.
     */
    @Override
    public String getMapMessage() {
        if (metal.isEmpty()) {
            return "";
        }
        for (Map.Entry<MetalType, Integer> entry: metal.entrySet()) {
            return entry.getKey().getShortString() + ":" + entry.getValue() +
                    ((found) ? "*" : "");
        }
        return "";
    }
}
