/**
 * IMAS base code for the practical work.
 * Copyright (C) 2016 DEIM - URV
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

import cat.urv.imas.onthology.MetalType;

/**
 * Building cell API for System agent which allows to set new metal in buildings.
 * Set new metal on building is restricted only to System agent, so that
 FieldCell is the API provided to agents.
 */
public class SettableFieldCell extends FieldCell {

    public SettableFieldCell(int row, int col) {
        super(row, col);
    }

    public void setElements(MetalType type, int amount) {
        if (!metal.isEmpty()) {
            throw new IllegalStateException("This cell (" + this.getRow() + "," + this.getCol() + ") has already elements: " + this.getMapMessage());
        }
        metal.put(type, amount);
    }

    @Override
    public boolean isEmpty() {
        return metal.isEmpty();
    }

}
