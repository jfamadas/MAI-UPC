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

/**
 * Cell that represents a manufacturing center.
 */
public class ManufacturingCenterCell extends Cell {

    /**
     * Price of manufacturing silver or gold.
     */
    private final int price;
    /**
     * Type of metal that this center manufactures.
     */
    private final MetalType metal;

    /**
     * Initializes a cell.
     *
     * @param row row number (zero based).
     * @param col col number (zero based).
     * @param price prices of manufacturing silver or gold.
     * @param type metal type that this center manufactures.
     */
    public ManufacturingCenterCell(int row, int col, int price, MetalType type) {
        super(CellType.MANUFACTURING_CENTER, row, col);
        this.price = price;
        this.metal = type;
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    /* ***************** Map visualization API ********************************/
    @Override
    public void draw(CellVisualizer visual) {
        visual.drawManufacturingCenter(this);
    }

    @Override
    public String getMapMessage() {
        return price + ":" + metal.getShortString();
    }

}
